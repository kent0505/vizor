import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../core/utils.dart';
import '../../../core/widgets/button.dart';
import '../../../core/widgets/loading_widget.dart';
import '../../../core/widgets/main_button.dart';
import '../../city/bloc/city_bloc.dart';
import '../../city/data/city_repository.dart';
import '../../city/screens/select_city_screen.dart';
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
    return Column(
      children: [
        const SizedBox(height: 100),
        BlocBuilder<CityBloc, CityState>(
          builder: (context, state) {
            if (state is CityLoading) {
              return const LoadingWidget();
            }

            if (state is CityLoaded) {
              return Button(
                onPressed: () {
                  context.push(SelectCityScreen.routePath);
                },
                child: Text(
                  state.selectedCity.name,
                  style: TextStyle(
                    color: Colors.black,
                  ),
                ),
              );
            }

            return MainButton(
              title: 'Choose city',
              onPressed: () {
                context.push(SelectCityScreen.routePath);
              },
            );
          },
        ),
      ],
    );
  }
}
