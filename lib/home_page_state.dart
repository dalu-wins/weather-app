import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:weather_app/animation_handler.dart';
import 'package:weather_app/home_page.dart';
import 'package:weather_app/weather_handler.dart';

class MyHomePageState extends State<MyHomePage> {
  final WeatherHandler weatherHandler = WeatherHandler();

  String _city = "San Francisco";
  int _temp = 18;
  int _tempMin = 12;
  int _tempMax = 22;
  String _condition = "clear";
  LottieBuilder _conditionAnimation = Lottie.asset("assets/clear.json");

  @override
  Widget build(BuildContext context) {
    weatherHandler.permissionCheck();

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        body: buildBody(context),
        floatingActionButton: buildFAB(),
      ),
    );
  }

  FloatingActionButton buildFAB() {
    return FloatingActionButton(
      backgroundColor: Theme.of(context).colorScheme.primary,
      elevation: 5,
      child: Icon(
        Icons.location_on,
        color: Theme.of(context).colorScheme.background,
      ),
      onPressed: () => {updateWeatherInfo()},
    );
  }

  Future<void> updateWeatherInfo() async {
    var (city, weather) = await weatherHandler.getWeather();

    setState(() {
      _city = city;
      _temp = weather.temperature!.celsius!.round();
      _tempMin = weather.tempMin!.celsius!.round();
      _tempMax = weather.tempMax!.celsius!.round();
      _condition = weather.weatherMain!.toLowerCase();
      _conditionAnimation = AnimationHandler.getConditionAnimation(_condition);
    });
  }

  CustomScrollView buildBody(BuildContext context) {
    return CustomScrollView(
      slivers: <Widget>[
        SliverAppBar.large(
          pinned: true,
          backgroundColor: Theme.of(context).colorScheme.background,
          surfaceTintColor: Colors.transparent,
          flexibleSpace: FlexibleSpaceBar(
            titlePadding: const EdgeInsets.only(left: 32, right: 32, bottom: 8),
            centerTitle: false,
            collapseMode: CollapseMode.none,
            title: Text(
              _city,
              style: TextStyle(
                color: Theme.of(context).colorScheme.onBackground,
              ),
            ),
          ),
        ),
        SliverFillRemaining(
          hasScrollBody: true,
          fillOverscroll: true,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32),
            child: Column(
              children: [
                Align(
                  alignment: Alignment.topLeft,
                  child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(right: 16),
                        child: Text(
                          "$_temp°",
                          style: TextStyle(
                              fontSize: 32,
                              color:
                                  Theme.of(context).colorScheme.onBackground),
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "$_tempMin° / $_tempMax°",
                            style: TextStyle(
                                color:
                                    Theme.of(context).colorScheme.onBackground),
                          ),
                          Text(
                            _condition,
                            style: TextStyle(
                                color:
                                    Theme.of(context).colorScheme.onBackground),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: _conditionAnimation,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
