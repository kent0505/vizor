import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:dio/dio.dart';

import 'src/core/constants.dart';
import 'src/core/router.dart';
import 'src/core/themes.dart';
import 'src/features/auth/bloc/auth_bloc.dart';
import 'src/features/auth/data/auth_repository.dart';
import 'src/features/city/bloc/city_bloc.dart';
import 'src/features/city/data/city_repository.dart';

// final colors = Theme.of(context).extension<MyColors>()!;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  await dotenv.load(fileName: ".env");

  final prefs = await SharedPreferences.getInstance();
  // await prefs.clear();

  final dio = Dio(
    BaseOptions(
      baseUrl: Env.baseUrl,
      connectTimeout: const Duration(seconds: 5),
      receiveTimeout: const Duration(seconds: 5),
      sendTimeout: const Duration(seconds: 5),
      validateStatus: (status) => true,
      headers: {
        'Content-Type': 'application/json',
      },
    ),
  );

  runApp(
    MultiRepositoryProvider(
      providers: [
        RepositoryProvider<AuthRepository>(
          create: (context) => AuthRepositoryImpl(
            prefs: prefs,
            dio: dio,
          ),
        ),
        RepositoryProvider<CityRepository>(
          create: (context) => CityRepositoryImpl(
            prefs: prefs,
            dio: dio,
          ),
        ),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => AuthBloc(
              repository: context.read<AuthRepository>(),
            ),
          ),
          BlocProvider(
            create: (context) => CityBloc(
              repository: context.read<CityRepository>(),
            ),
          ),
        ],
        child: MaterialApp.router(
          debugShowCheckedModeBanner: false,
          theme: theme,
          routerConfig: routerConfig,
        ),
      ),
    ),
  );
}
