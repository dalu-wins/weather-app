import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'weather_handler.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Weather',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.green),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Weather'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  WeatherHandler weatherHandler = WeatherHandler();
  int _temp = 0;
  String _city = "San Francisco";
  LottieBuilder _condition = Lottie.asset("./assets/alert.json");

  Future<void> _locate() async {
    var (city, temp, condition) = await weatherHandler.getWeather();
    setState(() {
      _city = city;
      _temp = temp;
      _condition = condition;
    });
  }

  Center configBody() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Padding(
                  padding: EdgeInsets.only(
                    right: 4,
                  ),
                  child: Icon(Icons.location_on)),
              Text(
                _city,
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(
              top: 16,
            ),
            child: Text(
              '$_temp°C',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ),
          _condition,
        ],
      ),
    );
  }

  FloatingActionButton configFAB() {
    return FloatingActionButton(
      onPressed: _locate,
      tooltip: 'Locate',
      child: const Icon(Icons.gps_fixed),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: configBody(),
      floatingActionButton: configFAB(),
    );
  }
}
