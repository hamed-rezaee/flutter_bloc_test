import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter_bloc_test/bloc/weather_bloc.dart';
import 'package:flutter_bloc_test/data/models/weather.dart';

class WeatherDetailPage extends StatefulWidget {
  final Weather weather;

  const WeatherDetailPage({Key key, this.weather}) : super(key: key);

  @override
  _WeatherDetailPageState createState() => _WeatherDetailPageState();
}

class _WeatherDetailPageState extends State<WeatherDetailPage> {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    BlocProvider.of<WeatherBloc>(context).add(
      GetDetailWeatherEvent(widget.weather.cityName),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Weather Detail'),
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(vertical: 16.0),
        alignment: Alignment.center,
        child: BlocBuilder<WeatherBloc, WeatherState>(
          builder: (BuildContext context, WeatherState state) {
            if (state is WeatherLoadedState) {
              return _buildColumnWithData(state.weather);
            }

            return _buildLoading();
          },
        ),
      ),
    );
  }

  Widget _buildLoading() => Center(child: CircularProgressIndicator());

  Widget _buildColumnWithData(Weather weather) => Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Text(
            weather.cityName,
            style: TextStyle(fontSize: 32.0, fontWeight: FontWeight.w800),
          ),
          Text(
            '${weather.temperatureCelsius.toStringAsFixed(1)} °C',
            style: TextStyle(fontSize: 64.0),
          ),
          Text(
            '${weather.temperatureFahrenheit.toStringAsFixed(1)} °F',
            style: TextStyle(fontSize: 64.0),
          ),
        ],
      );
}
