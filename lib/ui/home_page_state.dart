import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:weather_app/ui/animation_handler.dart';
import 'package:weather_app/weather/forecast_wrapper.dart';
import 'package:weather_app/ui/home_page.dart';
import 'package:weather_app/weather/weather_handler.dart';

class MyHomePageState extends State<MyHomePage> {
  final WeatherHandler weatherHandler = WeatherHandler();

  String _city = "San Francisco";
  int _temp = 18;
  int _tempMin = 12;
  int _tempMax = 22;
  String _condition = "clear";
  LottieBuilder _conditionAnimation = Lottie.asset("assets/clear.json");

  String _sunrise = "06:00";
  String _sunset = "18:00";

  String _forecastTime_0 = "-:-";
  String _forecastTemp_0 = "-°";
  String _forecastCondition_0 = "not loaded";

  String _forecastTime_1 = "-:-";
  String _forecastTemp_1 = "-°";
  String _forecastCondition_1 = "not loaded";

  String _forecastTime_2 = "-:-";
  String _forecastTemp_2 = "-°";
  String _forecastCondition_2 = "not loaded";

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
    var (city, weather, forecastRaw) = await weatherHandler.getWeather();
    List<ForecastItem> forecast = ForecastWrapper(forecastRaw).forecastWrapped;

    setState(() {
      _city = city;

      _temp = weather.temperature!.celsius!.round();
      _tempMin = weather.tempMin!.celsius!.round();
      _tempMax = weather.tempMax!.celsius!.round();
      _condition = weather.weatherMain!.toLowerCase();
      _conditionAnimation = AnimationHandler.getConditionAnimation(_condition);

      _sunrise = DateFormat('HH:mm').format(weather.sunrise!);
      _sunset = DateFormat('HH:mm').format(weather.sunset!);

      _forecastTime_0 = forecast[0].time;
      _forecastTemp_0 = forecast[0].tempertature;
      _forecastCondition_0 = forecast[0].condition;

      _forecastTime_1 = forecast[1].time;
      _forecastTemp_1 = forecast[1].tempertature;
      _forecastCondition_1 = forecast[1].condition;

      _forecastTime_2 = forecast[2].time;
      _forecastTemp_2 = forecast[2].tempertature;
      _forecastCondition_2 = forecast[2].condition;
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
        SliverToBoxAdapter(
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
                  padding: const EdgeInsets.only(top: 16, bottom: 16),
                  child: _conditionAnimation,
                ),
                Padding(
                  padding: EdgeInsets.only(bottom: 48),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Column(
                        children: [
                          Text(
                            "$_sunrise",
                            style: TextStyle(
                              fontSize: 20,
                              color: Theme.of(context).colorScheme.onBackground,
                            ),
                          ),
                          Text(
                            "sunrise",
                            style: TextStyle(
                              color: Theme.of(context).colorScheme.onBackground,
                            ),
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          Text(
                            "$_sunset",
                            style: TextStyle(
                              fontSize: 20,
                              color: Theme.of(context).colorScheme.onBackground,
                            ),
                          ),
                          Text(
                            "sunset",
                            style: TextStyle(
                              color: Theme.of(context).colorScheme.onBackground,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(bottom: 96),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        children: [
                          SizedBox(
                            height: 32,
                            child: AnimationHandler.getConditionAnimation(
                                _forecastCondition_0,
                                animated: false),
                          ),
                          SizedBox(
                            height: 32,
                            child: AnimationHandler.getConditionAnimation(
                                _forecastCondition_1,
                                animated: false),
                          ),
                          SizedBox(
                            height: 32,
                            child: AnimationHandler.getConditionAnimation(
                                _forecastCondition_2,
                                animated: false),
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          SizedBox(
                            height: 32,
                            child: Text(
                              _forecastTime_0,
                              style: TextStyle(
                                color:
                                    Theme.of(context).colorScheme.onBackground,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 32,
                            child: Text(
                              _forecastTime_1,
                              style: TextStyle(
                                color:
                                    Theme.of(context).colorScheme.onBackground,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 32,
                            child: Text(
                              _forecastTime_2,
                              style: TextStyle(
                                color:
                                    Theme.of(context).colorScheme.onBackground,
                              ),
                            ),
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          SizedBox(
                            height: 32,
                            child: Text(
                              _forecastTemp_0,
                              style: TextStyle(
                                color:
                                    Theme.of(context).colorScheme.onBackground,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 32,
                            child: Text(
                              _forecastTemp_0,
                              style: TextStyle(
                                color:
                                    Theme.of(context).colorScheme.onBackground,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 32,
                            child: Text(
                              _forecastTemp_2,
                              style: TextStyle(
                                color:
                                    Theme.of(context).colorScheme.onBackground,
                              ),
                            ),
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          SizedBox(
                            height: 32,
                            child: Text(
                              _forecastCondition_0,
                              style: TextStyle(
                                color:
                                    Theme.of(context).colorScheme.onBackground,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 32,
                            child: Text(
                              _forecastCondition_1,
                              style: TextStyle(
                                color:
                                    Theme.of(context).colorScheme.onBackground,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 32,
                            child: Text(
                              _forecastCondition_2,
                              style: TextStyle(
                                color:
                                    Theme.of(context).colorScheme.onBackground,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
