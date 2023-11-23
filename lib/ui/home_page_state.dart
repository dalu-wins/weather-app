import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:weather_app/data/permissions.dart';
import 'package:weather_app/ui/home_page.dart';
import 'package:weather_app/data/weather.dart';
import 'package:weather_app/ui/widgets/fab.dart';
import 'package:weather_app/ui/widgets/content.dart';

class MyHomePageState extends State<MyHomePage> {
  final WeatherHandler weatherHandler = WeatherHandler();
  final MainContent mainContent = MainContent();
  final CustomFAB customFAB = CustomFAB();

  @override
  Widget build(BuildContext context) {
    PermissionHandler.check();

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        body: mainContent.build(this),
        floatingActionButton: customFAB.build(this),
      ),
    );
  }

  Future<void> updateWeatherInfo() async {
    var (city, weather, forecast) = await weatherHandler.getWeather();
    setState(() {
      mainContent.city = city;

      mainContent.temperature = "${weather.temperature!.celsius!.round()}°";
      mainContent.tempMin = "${weather.tempMin!.celsius!.round()}°";
      mainContent.tempMax = "${weather.tempMax!.celsius!.round()}°";

      mainContent.sunrise = DateFormat("HH:MM").format(weather.sunrise!);
      mainContent.sunset = DateFormat("HH:MM").format(weather.sunset!);

      mainContent.forecastTime0 = DateFormat("HH:mm").format(forecast[0].date!);
      mainContent.forecastTemperature0 =
          "${forecast[0].temperature!.celsius!.round()}°";
      mainContent.forecastCondition0 = forecast[0].weatherMain!.toLowerCase();

      mainContent.forecastTime1 = DateFormat("HH:mm").format(forecast[1].date!);
      mainContent.forecastTemperature1 =
          "${forecast[1].temperature!.celsius!.round()}°";
      mainContent.forecastCondition1 = forecast[1].weatherMain!.toLowerCase();

      mainContent.forecastTime2 = DateFormat("HH:mm").format(forecast[2].date!);
      mainContent.forecastTemperature2 =
          "${forecast[2].temperature!.celsius!.round()}°";
      mainContent.forecastCondition2 = forecast[2].weatherMain!.toLowerCase();

      mainContent.forecastTime3 = DateFormat("HH:mm").format(forecast[3].date!);
      mainContent.forecastTemperature3 =
          "${forecast[3].temperature!.celsius!.round()}°";
      mainContent.forecastCondition3 = forecast[3].weatherMain!.toLowerCase();

      mainContent.forecastTime4 = DateFormat("HH:mm").format(forecast[4].date!);
      mainContent.forecastTemperature4 =
          "${forecast[4].temperature!.celsius!.round()}°";
      mainContent.forecastCondition4 = forecast[4].weatherMain!.toLowerCase();
    });
  }
}
