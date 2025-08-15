part of 'city_bloc.dart';

@immutable
sealed class CityState {}

final class CityInitial extends CityState {}

final class CityLoading extends CityState {}

final class CityLoaded extends CityState {
  CityLoaded({
    required this.cities,
    required this.selectedCity,
  });

  final List<City> cities;
  final City selectedCity;
}
