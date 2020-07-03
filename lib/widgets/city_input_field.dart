import 'package:flutter/material.dart';

class CityInputField extends StatelessWidget {
  final Function(String cityName) onSubmit;

  const CityInputField({Key key, @required this.onSubmit}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 48.0),
      child: TextField(
        textInputAction: TextInputAction.search,
        decoration: InputDecoration(
          hintText: 'City Name',
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(5.0)),
          suffixIcon: Icon(Icons.search),
        ),
        onSubmitted: (String cityName) => onSubmit(cityName),
      ),
    );
  }
}
