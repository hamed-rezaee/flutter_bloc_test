import 'dart:math';

import 'package:flutter_bloc_test/data/models/weather.dart';
import 'package:flutter_bloc_test/exceptions/network_error.dart';

abstract class WeatherRepository {
  Future<Weather> fetchWeather(String cityName);
  Future<Weather> fetchDetailWeather(String cityName);
}

class FakeWeatherRepository implements WeatherRepository {
  double _cachedTempCelsius;
  @override
  Future<Weather> fetchWeather(String cityName) =>
      Future.delayed(Duration(seconds: 1), () {
        final random = Random();

        if (random.nextBool()) {
          throw NetworkError();
        }

        _cachedTempCelsius = 20 + random.nextInt(15) + random.nextDouble();

        return Weather(
          cityName: cityName,
          temperatureCelsius: _cachedTempCelsius,
        );
      });

  @override
  Future<Weather> fetchDetailWeather(String cityName) => Future.delayed(
        Duration(seconds: 1),
        () => Weather(
          cityName: cityName,
          temperatureCelsius: _cachedTempCelsius,
          temperatureFahrenheit: _cachedTempCelsius * 1.8 + 32,
        ),
      );
}
