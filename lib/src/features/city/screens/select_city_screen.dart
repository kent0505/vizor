import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/widgets/appbar.dart';
import '../bloc/city_bloc.dart';
import '../widgets/city_tile.dart';

class SelectCityScreen extends StatelessWidget {
  const SelectCityScreen({super.key});

  static const routePath = '/SelectCityScreen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Appbar(
        title: 'Select City',
      ),
      body: BlocBuilder<CityBloc, CityState>(
        builder: (context, state) {
          if (state is CityLoaded) {
            return ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: state.cities.length,
              itemBuilder: (context, index) {
                return CityTile(
                  city: state.cities[index],
                  selectedCity: state.selectedCity,
                );
              },
            );
          }

          if (state is CityError) {
            return Center(
              child: Text(state.error),
            );
          }

          return const SizedBox();
        },
      ),
    );
  }
}
