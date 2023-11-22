import 'package:intl/intl.dart';
import 'package:weather/weather.dart';

class ForecastWrapper {
  List<ForecastItem> forecastWrapped = [];
  ForecastWrapper(List<Weather> forecast) {
    forecast.forEach((element) {
      // Set infos
      DateTime dateTime = element.date!;
      String time = DateFormat('HH:mm').format(dateTime);
      String condition = element.weatherMain!.toLowerCase();
      String temperature = "${element.temperature!.celsius!.round()}°";

      // create and add forecast item
      ForecastItem forecastItem = ForecastItem(
        time: time,
        tempertature: temperature,
        condition: condition,
      );
      forecastWrapped.add(forecastItem);
    });
  }
}

class ForecastItem {
  String time;
  String tempertature;
  String condition;
  ForecastItem({
    required this.time,
    required this.tempertature,
    required this.condition,
  });
}
