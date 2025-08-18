import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/widgets/loading_widget.dart';
import '../bloc/restaurant_bloc.dart';
import 'restaurant_card.dart';

class RestaurantsList extends StatelessWidget {
  const RestaurantsList({super.key});

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
