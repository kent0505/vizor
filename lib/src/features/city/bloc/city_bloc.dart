import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/utils.dart';
import '../data/city_repository.dart';
import '../models/city.dart';

part 'city_event.dart';
part 'city_state.dart';

class CityBloc extends Bloc<CityEvent, CityState> {
  final CityRepository _repository;

  List<City> cities = [];

  CityBloc({required CityRepository repository})
      : _repository = repository,
        super(CityInitial()) {
    on<CityEvent>(
      (event, emit) => switch (event) {
        GetCities() => _getCities(event, emit),
        SelectCity() => _selectCity(event, emit),
      },
    );
  }

  void _getCities(
    GetCities event,
    Emitter<CityState> emit,
  ) async {
    try {
      cities = await _repository.getCities();
      final selectedCity = cities.firstWhereOrNull((city) {
            return city.id == _repository.getCity();
          }) ??
          City();

      emit(CityLoaded(
        cities: cities,
        selectedCity: selectedCity,
      ));
    } catch (e) {
      logger(e);
      emit(CityError(error: e.toString()));
    }
  }

  void _selectCity(
    SelectCity event,
    Emitter<CityState> emit,
  ) async {
    await _repository.selectCity(event.city);
    emit(CityLoaded(
      cities: cities,
      selectedCity: event.city,
    ));
  }
}
