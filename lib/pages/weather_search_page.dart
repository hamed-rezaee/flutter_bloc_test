import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_test/bloc/weather_bloc.dart';

import 'package:flutter_bloc_test/data/models/weather.dart';
import 'package:flutter_bloc_test/pages/weather_detail_page.dart';
import 'package:flutter_bloc_test/widgets/city_input_field.dart';

class WeatherSearchPage extends StatelessWidget {
  const WeatherSearchPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Weather Search'),
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(vertical: 16.0),
        alignment: Alignment.center,
        child: BlocListener<WeatherBloc, WeatherState>(
          listener: (BuildContext context, WeatherState state) {
            if (state is WeatherErrorState) {
              Scaffold.of(context).showSnackBar(
                SnackBar(content: Text(state.message)),
              );
            }
          },
          child: BlocBuilder<WeatherBloc, WeatherState>(
            builder: (BuildContext context, WeatherState state) {
              if (state is WeatherInitialState) {
                return _buildInitialInput(context);
              } else if (state is WeatherLoadingState) {
                return _buildLoading();
              } else if (state is WeatherLoadedState) {
                return _buildColumnWithData(context, state.weather);
              }

              return _buildInitialInput(context);
            },
          ),
        ),
      ),
    );
  }

  Widget _buildInitialInput(BuildContext context) => Center(
        child: CityInputField(
          onSubmit: (String cityName) => BlocProvider.of<WeatherBloc>(context)
              .add(GetWeatherEvent(cityName)),
        ),
      );

  Widget _buildLoading() => Center(child: CircularProgressIndicator());

  Widget _buildColumnWithData(BuildContext context, Weather weather) => Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Text(
            weather.cityName,
            style: TextStyle(fontSize: 32.0, fontWeight: FontWeight.w800),
          ),
          Text(
            '${weather.temperatureCelsius.toStringAsFixed(1)} °c',
            style: TextStyle(fontSize: 64.0),
          ),
          RaisedButton(
            color: Theme.of(context).primaryColor,
            child: Text(
              'See Details',
              style: TextStyle(color: Colors.white),
            ),
            onPressed: () => Navigator.of(context).push(
              MaterialPageRoute(
                builder: (_) => BlocProvider.value(
                  value: BlocProvider.of<WeatherBloc>(context),
                  child: WeatherDetailPage(weather: weather),
                ),
              ),
            ),
          ),
          _buildInitialInput(context)
        ],
      );
}
