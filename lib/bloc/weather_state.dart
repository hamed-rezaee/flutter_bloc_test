part of 'weather_bloc.dart';

@immutable
abstract class WeatherState {}

class WeatherInitialState extends WeatherState {
  @override
  String toString() => runtimeType.toString();
}

class WeatherLoadingState extends WeatherState {
  @override
  String toString() => runtimeType.toString();
}

class WeatherLoadedState extends WeatherState {
  final Weather weather;

  WeatherLoadedState(this.weather);

  @override
  String toString() => runtimeType.toString();
}

class WeatherErrorState extends WeatherState {
  final String message;

  WeatherErrorState(this.message);

  @override
  String toString() => runtimeType.toString();
}
