import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../core/utils.dart';
import '../../../core/widgets/loading_widget.dart';
import '../../city/bloc/city_bloc.dart';
import '../../city/data/city_repository.dart';
import '../../city/screens/select_city_screen.dart';
import '../../restaurant/bloc/restaurant_bloc.dart';
import '../../restaurant/widgets/restaurant_card.dart';
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
  void checkCity() {
    if (context.read<CityRepository>().getCity() == 0) {
      context.push(SelectCityScreen.routePath);
    }
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      checkCity();
    });
    context.read<CityBloc>().add(GetCities());
    context
        .read<RestaurantBloc>()
        .add(GetRestaurants(city: context.read<CityRepository>().getCity()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: HomeAppbar(),
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
                int index = state is HomeInitial ? 0 : 1;

                return IndexedStack(
                  index: index,
                  children: const [
                    _Home(),
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

class _Home extends StatelessWidget {
  const _Home();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RestaurantBloc, RestaurantState>(
      builder: (context, state) {
        if (state is RestaurantLoading) {
          return const LoadingWidget();
        }

        if (state is RestaurantsLoaded) {
          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: state.restaurants.length,
            itemBuilder: (context, index) {
              return RestaurantCard(
                restaurant: state.restaurants[index],
              );
            },
          );
        }

        if (state is RestaurantError) {
          return Center(
            child: Text(state.error),
          );
        }

        return const SizedBox();
      },
    );
  }
}
