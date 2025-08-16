part of 'restaurant_bloc.dart';

@immutable
sealed class RestaurantState {}

final class RestaurantInitial extends RestaurantState {}

final class RestaurantLoading extends RestaurantState {}

final class RestaurantsLoaded extends RestaurantState {
  RestaurantsLoaded({required this.restaurants});

  final List<Restaurant> restaurants;
}

final class RestaurantError extends RestaurantState {
  RestaurantError({required this.error});

  final String error;
}
