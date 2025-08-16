import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/utils.dart';
import '../data/restaurant_repository.dart';
import '../models/restaurant.dart';

part 'restaurant_event.dart';
part 'restaurant_state.dart';

class RestaurantBloc extends Bloc<RestaurantEvent, RestaurantState> {
  final RestaurantRepository _repository;

  RestaurantBloc({required RestaurantRepository repository})
      : _repository = repository,
        super(RestaurantInitial()) {
    on<RestaurantEvent>(
      (event, emit) => switch (event) {
        GetRestaurants() => _getRestaurants(event, emit),
      },
    );
  }

  void _getRestaurants(
    GetRestaurants event,
    Emitter<RestaurantState> emit,
  ) async {
    emit(RestaurantLoading());
    try {
      final restaurants = await _repository.getRestaurants(event.city);
      emit(RestaurantsLoaded(restaurants: restaurants));
    } catch (e) {
      logger(e);
      emit(RestaurantError(error: e.toString()));
    }
  }
}
