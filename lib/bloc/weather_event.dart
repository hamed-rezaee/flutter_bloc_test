part of 'weather_bloc.dart';

@immutable
abstract class WeatherEvent {}

class GetWeatherEvent extends WeatherEvent {
  final String cityName;

  GetWeatherEvent(this.cityName);

  @override
  String toString() => runtimeType.toString();
}

class GetDetailWeatherEvent extends WeatherEvent {
  final String cityName;

  GetDetailWeatherEvent(this.cityName);

  @override
  String toString() => runtimeType.toString();
}
