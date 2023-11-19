import 'package:flutter/material.dart';
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
  int _temp = 0;
  String _city = "San Francisco";

  Future<void> _locate() async {
    var (city, temp, condition) = await WeatherHandler.getWeather();
    setState(() {
      _city = city;
      _temp = temp;
    });
  }

  AppBar configAppBar() {
    return AppBar(
      backgroundColor: Theme.of(context).colorScheme.background,
      foregroundColor: Theme.of(context).colorScheme.primary,
      title: Text(widget.title),
    );
  }

  Center configBody() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.location_on),
              Text(
                _city,
              ),
            ],
          ),
          Text(
            '$_temp°C',
            style: Theme.of(context).textTheme.headlineMedium,
          ),
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
      appBar: configAppBar(),
      body: configBody(),
      floatingActionButton: configFAB(),
    );
  }
}
