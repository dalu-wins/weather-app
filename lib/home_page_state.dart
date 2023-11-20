import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:weather_app/home_page.dart';
import 'package:weather_app/weather_handler.dart';

class MyHomePageState extends State<MyHomePage> {
  final WeatherHandler weatherHandler = WeatherHandler();

  String _city = "San Francisco";
  int _temp = 18;
  LottieBuilder _condition = Lottie.asset("assets/clear.json");

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: buildBody(context),
        floatingActionButton: buildFAB(),
      ),
    );
  }

  FloatingActionButton buildFAB() {
    return FloatingActionButton(
      child: const Icon(Icons.location_on),
      onPressed: () => {updateWeatherInfo()},
    );
  }

  Future<void> updateWeatherInfo() async {
    var (city, temp, condition) = await weatherHandler.getWeather();
    setState(() {
      _city = city;
      _temp = temp;
      _condition = condition;
    });
  }

  CustomScrollView buildBody(BuildContext context) {
    return CustomScrollView(
      slivers: <Widget>[
        SliverAppBar.large(
          pinned: true,
          actions: [
            IconButton(
              icon: const Icon(
                Icons.more_vert,
              ),
              onPressed: () {
                // do something
              },
            )
          ],
          flexibleSpace: FlexibleSpaceBar(
            titlePadding: EdgeInsets.all(16),
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
          hasScrollBody: false,
          fillOverscroll: true,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    "$_temp°C",
                    style: TextStyle(fontSize: 18),
                  ),
                ),
                _condition,
              ],
            ),
          ),
        ),
      ],
    );
  }
}
