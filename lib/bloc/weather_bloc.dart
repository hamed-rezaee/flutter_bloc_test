import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:flutter_bloc_test/data/weather_repository.dart';
import 'package:flutter_bloc_test/exceptions/network_error.dart';
import 'package:meta/meta.dart';

import 'package:flutter_bloc_test/data/models/weather.dart';

part 'weather_event.dart';
part 'weather_state.dart';

class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  final WeatherRepository repository;

  WeatherBloc(this.repository) : super(WeatherInitialState());

  @override
  Stream<WeatherState> mapEventToState(
    WeatherEvent event,
  ) async* {
    yield WeatherLoadingState();

    try {
      Weather weather;

      if (event is GetWeatherEvent) {
        weather = await repository.fetchWeather(event.cityName);
      } else if (event is GetDetailWeatherEvent) {
        weather = await repository.fetchDetailWeather(event.cityName);
      }

      yield WeatherLoadedState(weather);
    } on NetworkError {
      yield WeatherErrorState('Network Error...');
    }
  }
}
