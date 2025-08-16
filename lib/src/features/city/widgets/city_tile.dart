import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/constants.dart';
import '../../../core/widgets/button.dart';
import '../../restaurant/bloc/restaurant_bloc.dart';
import '../bloc/city_bloc.dart';
import '../models/city.dart';

class CityTile extends StatelessWidget {
  const CityTile({
    super.key,
    required this.city,
    required this.selectedCity,
  });

  final City city;
  final City selectedCity;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 16,
      ),
      margin: const EdgeInsets.only(bottom: 8),
      decoration: BoxDecoration(
        color: Colors.greenAccent,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Button(
        onPressed: () {
          context.read<CityBloc>().add(SelectCity(city: city));
          context.read<RestaurantBloc>().add(GetRestaurants(city: city.id));
        },
        child: Row(
          children: [
            Expanded(
              child: Text(
                city.name,
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                  fontFamily: AppFonts.w600,
                ),
              ),
            ),
            if (selectedCity.id == city.id) Icon(Icons.check),
          ],
        ),
      ),
    );
  }
}
