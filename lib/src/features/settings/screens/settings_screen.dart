import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../core/widgets/dialog_widget.dart';
import '../../../core/widgets/main_button.dart';
import '../../auth/bloc/auth_bloc.dart';
import '../../auth/screens/auth_screen.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        MainButton(
          title: 'Logout',
          onPressed: () {
            DialogWidget.show(
              context,
              title: 'Logout?',
              confirm: true,
              onPressed: () {
                context.read<AuthBloc>().add(LogoutEvent());
                context.replace(AuthScreen.routePath);
              },
            );
          },
        ),
      ],
    );
  }
}
