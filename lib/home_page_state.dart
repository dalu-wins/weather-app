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
      backgroundColor: Theme.of(context).primaryColor,
      elevation: 5,
      child: Icon(
        Icons.location_on,
        color: Theme.of(context).colorScheme.background,
      ),
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
            titlePadding: const EdgeInsets.symmetric(horizontal: 16),
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
            padding: const EdgeInsets.only(left: 18, right: 18, top: 16),
            child: Column(
              children: [
                Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    "$_temp°C",
                    style: const TextStyle(fontSize: 22),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(32),
                  child: _condition,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
