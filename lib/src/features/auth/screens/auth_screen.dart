import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:pinput/pinput.dart';

import '../../../core/constants.dart';
import '../../../core/utils.dart';
import '../../../core/widgets/button.dart';
import '../../../core/widgets/main_button.dart';
import '../../../core/widgets/snack_widget.dart';
import '../../../core/widgets/txt_field.dart';
import '../../home/screens/home_screen.dart';
import '../bloc/auth_bloc.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  static const routePath = '/AuthScreen';

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final phoneController = TextEditingController();
  final codeController = TextEditingController();

  bool code = false;

  Timer? timer;

  int seconds = 0;

  void startTimer() {
    setState(() {
      seconds = 60;
    });
    timer?.cancel();
    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (seconds == 0) {
        timer.cancel();
      } else {
        setState(() {
          seconds--;
        });
      }
    });
  }

  void onContinue() {
    final bloc = context.read<AuthBloc>();
    if (code) {
      bloc.add(LoginEvent(
        phone: phoneController.text,
        code: codeController.text,
      ));
    } else {
      bloc.add(SendCodeEvent(phone: phoneController.text));
      setState(() {
        code = true;
      });
      startTimer();
    }
  }

  void onResend() {
    final bloc = context.read<AuthBloc>();
    bloc.add(SendCodeEvent(phone: phoneController.text));
    codeController.clear();
    startTimer();
  }

  void onCancel() {
    setState(() {
      code = false;
      timer?.cancel();
      seconds = 0;
      codeController.clear();
    });
  }

  @override
  void dispose() {
    phoneController.dispose();
    codeController.dispose();
    timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Padding(
        padding: EdgeInsets.all(Constants.padding).copyWith(
          top: MediaQuery.of(context).viewPadding.top,
        ),
        child: BlocConsumer<AuthBloc, AuthState>(
          listener: (context, state) {
            logger(state.runtimeType);

            if (state is Logined) {
              context.replace(HomeScreen.routePath);
            }

            if (state is AuthError) {
              SnackWidget.show(
                context,
                message: state.error,
                isError: true,
              );
              codeController.clear();
            }
          },
          builder: (context, state) {
            return Column(
              children: [
                if (code)
                  Row(
                    children: [
                      Button(
                        onPressed: onCancel,
                        child: const Text(
                          'Cancel',
                          style: TextStyle(color: Colors.black),
                        ),
                      ),
                    ],
                  ),
                const Spacer(),
                code
                    ? Pinput(
                        length: 5,
                        controller: codeController,
                        onTapOutside: (event) {
                          FocusManager.instance.primaryFocus?.unfocus();
                        },
                      )
                    : TxtField(
                        controller: phoneController,
                        keyboardType: TextInputType.phone,
                        hintText: 'Phone',
                      ),
                const SizedBox(height: 20),
                MainButton(
                  title: code ? 'Verify' : 'Continue',
                  onPressed: onContinue,
                ),
                if (code) ...[
                  const SizedBox(height: 10),
                  seconds > 0
                      ? SizedBox(
                          height: 44,
                          child: Center(
                            child: Text(
                              "Resend code in ${seconds}s",
                              style: const TextStyle(color: Colors.grey),
                            ),
                          ),
                        )
                      : Button(
                          onPressed: onResend,
                          child: const Text(
                            'Resend Code',
                            style: TextStyle(color: Colors.black),
                          ),
                        ),
                ],
                const SizedBox(height: 44),
                const Spacer(),
              ],
            );
          },
        ),
      ),
    );
  }
}
