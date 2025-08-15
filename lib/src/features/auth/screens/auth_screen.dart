import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:pinput/pinput.dart';

import '../../../core/constants.dart';
import '../../../core/utils.dart';
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

  void onContinue() {
    if (code) {
      context.read<AuthBloc>().add(LoginEvent(
            phone: phoneController.text,
            code: codeController.text,
          ));
    } else {
      context.read<AuthBloc>().add(SendCodeEvent(phone: phoneController.text));
      setState(() {
        code = true;
      });
    }
  }

  @override
  void dispose() {
    phoneController.dispose();
    codeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(Constants.padding),
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
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                code
                    ? Pinput(
                        length: 5,
                        controller: codeController,
                        errorText:
                            state is AuthError ? 'Code is incorrect' : null,
                      )
                    : TxtField(
                        controller: phoneController,
                        keyboardType: TextInputType.phone,
                        hintText: 'Phone',
                      ),
                const SizedBox(height: 20),
                MainButton(
                  title: 'Continue',
                  onPressed: onContinue,
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
