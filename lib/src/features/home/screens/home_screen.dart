import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../core/utils.dart';
import '../../city/bloc/city_bloc.dart';
import '../../city/data/city_repository.dart';
import '../../city/screens/select_city_screen.dart';
import '../../restaurant/bloc/restaurant_bloc.dart';
import '../../restaurant/widgets/restaurants_list.dart';
import '../../settings/screens/settings_screen.dart';
import '../bloc/home_bloc.dart';
import '../widgets/home_appbar.dart';
import '../widgets/nav_bar.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  static const routePath = '/HomeScreen';

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (context.read<CityRepository>().getCity() == 0) {
        context.push(SelectCityScreen.routePath);
      }
    });
    context.read<CityBloc>().add(GetCities());
    context
        .read<RestaurantBloc>()
        .add(GetRestaurants(city: context.read<CityRepository>().getCity()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const HomeAppbar(),
      body: Stack(
        children: [
          Padding(
            padding: EdgeInsets.only(
              bottom: 62 + MediaQuery.of(context).viewPadding.bottom,
            ),
            child: BlocConsumer<HomeBloc, HomeState>(
              listener: (context, state) {
                logger(state.runtimeType);
              },
              buildWhen: (previous, current) {
                return previous.runtimeType != current.runtimeType;
              },
              builder: (context, state) {
                return IndexedStack(
                  index: switch (state) {
                    HomeInitial() => 0,
                    HomeFavorite() => 1,
                    HomeSettings() => 2,
                  },
                  children: const [
                    RestaurantsList(),
                    Placeholder(),
                    SettingsScreen(),
                  ],
                );
              },
            ),
          ),
          const NavBar(),
        ],
      ),
    );
  }
}
