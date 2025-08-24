import 'package:go_router/go_router.dart';

import '../features/auth/screens/auth_screen.dart';
import '../features/city/screens/select_city_screen.dart';
import '../features/home/screens/home_screen.dart';
import '../features/restaurant/models/restaurant.dart';
import '../features/restaurant/screens/restaurant_detail_screen.dart';
import '../features/splash/screens/splash_screen.dart';

final routerConfig = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const SplashScreen(),
    ),
    GoRoute(
      path: AuthScreen.routePath,
      builder: (context, state) => const AuthScreen(),
    ),
    GoRoute(
      path: HomeScreen.routePath,
      builder: (context, state) => const HomeScreen(),
    ),
    GoRoute(
      path: SelectCityScreen.routePath,
      builder: (context, state) => const SelectCityScreen(),
    ),
    GoRoute(
      path: RestaurantDetailScreen.routePath,
      builder: (context, state) => RestaurantDetailScreen(
        restaurant: state.extra as Restaurant,
      ),
    ),
  ],
);
