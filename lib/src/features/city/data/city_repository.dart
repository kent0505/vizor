import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../core/constants.dart';
import '../models/city.dart';

abstract interface class CityRepository {
  const CityRepository();

  Future<List<City>> getCities();
  Future<void> selectCity(City city);
  int getCity();
}

final class CityRepositoryImpl implements CityRepository {
  CityRepositoryImpl({
    required SharedPreferences prefs,
    required Dio dio,
  })  : _prefs = prefs,
        _dio = dio;

  final SharedPreferences _prefs;
  final Dio _dio;

  @override
  Future<List<City>> getCities() async {
    final response = await _dio.get('/api/v1/client/cities');

    if (response.statusCode == 200) {
      List data = response.data['cities'];

      List<City> cities = data.map((json) {
        return City.fromJson(json);
      }).toList();

      if (!cities.any((city) => city.id == _prefs.getInt(Keys.city))) {
        _prefs.remove(Keys.city);
      }

      return cities;
    }

    throw Exception(response.data['detail']);
  }

  @override
  Future<void> selectCity(City city) async {
    await _prefs.setInt(Keys.city, city.id);
  }

  @override
  int getCity() {
    return _prefs.getInt(Keys.city) ?? 0;
  }
}
