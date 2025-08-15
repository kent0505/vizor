import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../core/widgets/button.dart';
import '../../../core/widgets/loading_widget.dart';
import '../../../core/widgets/main_button.dart';
import '../../city/bloc/city_bloc.dart';
import '../../city/data/city_repository.dart';
import '../../city/screens/select_city_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  static const routePath = '/HomeScreen';

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  void onChooseCity() {
    context.push(SelectCityScreen.routePath);
  }

  void checkCity() {
    if (context.read<CityRepository>().getCity() == 0) {
      onChooseCity();
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
      body: Column(
        children: [
          const SizedBox(height: 100),
          BlocBuilder<CityBloc, CityState>(
            builder: (context, state) {
              if (state is CityLoading) {
                return const LoadingWidget();
              }

              if (state is CityLoaded) {
                return Button(
                  onPressed: onChooseCity,
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
                onPressed: onChooseCity,
              );
            },
          ),
        ],
      ),
    );
  }
}
