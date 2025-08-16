import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../core/widgets/loading_widget.dart';
import '../../auth/data/auth_repository.dart';
import '../../auth/screens/auth_screen.dart';
import '../../home/screens/home_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    final isExpired = context.read<AuthRepository>().isExpired();
    Future.delayed(
      const Duration(seconds: 2),
      () {
        if (mounted) {
          context.go(isExpired ? AuthScreen.routePath : HomeScreen.routePath);
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: LoadingWidget(),
    );
  }
}
