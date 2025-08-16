part of 'restaurant_bloc.dart';

@immutable
sealed class RestaurantEvent {}

final class GetRestaurants extends RestaurantEvent {
  GetRestaurants({required this.city});

  final int city;
}
