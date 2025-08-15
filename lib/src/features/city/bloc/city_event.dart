part of 'city_bloc.dart';

@immutable
sealed class CityEvent {}

final class GetCities extends CityEvent {}

final class SelectCity extends CityEvent {
  SelectCity({required this.city});

  final City city;
}
