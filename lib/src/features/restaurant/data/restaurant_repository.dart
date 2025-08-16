import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../core/constants.dart';
import '../models/restaurant.dart';

abstract interface class RestaurantRepository {
  const RestaurantRepository();

  Future<List<Restaurant>> getRestaurants(int city);
  Future<void> addRestaurant(Restaurant restaurant);
}

final class RestaurantRepositoryImpl implements RestaurantRepository {
  RestaurantRepositoryImpl({
    required SharedPreferences prefs,
    required Dio dio,
  })  : _prefs = prefs,
        _dio = dio;

  final SharedPreferences _prefs;
  final Dio _dio;

  @override
  Future<List<Restaurant>> getRestaurants(int city) async {
    final response = await _dio.get('/api/v1/client/restaurants?city=$city');

    if (response.statusCode == 200) {
      List data = response.data['restaurants'];

      List<Restaurant> restaurants = data.map((json) {
        return Restaurant.fromJson(json);
      }).toList();

      return restaurants;
    }

    throw Exception(response.data['detail']);
  }

  @override
  Future<void> addRestaurant(Restaurant restaurant) async {
    final response = await _dio.post(
      '/api/v1/restaurant',
      options: Options(
        headers: {
          'Authorization:': 'Bearer ${_prefs.getString(Keys.token) ?? ''}',
        },
      ),
    );

    if (response.statusCode == 200) return;

    throw Exception(response.data['detail']);
  }
}
