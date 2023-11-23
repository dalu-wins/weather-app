import 'package:flutter/material.dart';
import 'package:weather_app/ui/home_page_state.dart';

class CustomFAB {
  FloatingActionButton build(MyHomePageState homepage) {
    return FloatingActionButton(
      backgroundColor: Theme.of(homepage.context).colorScheme.primary,
      elevation: 5,
      child: Icon(
        Icons.location_on,
        color: Theme.of(homepage.context).colorScheme.background,
      ),
      onPressed: () => {homepage.updateWeatherInfo()},
    );
  }
}
