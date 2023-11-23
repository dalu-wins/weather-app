import 'package:weather/weather.dart';
import 'package:weather_app/data/location.dart';
import 'package:weather_app/data/api_key_secret.dart';

class WeatherHandler {
  WeatherFactory wf = WeatherFactory(APIKey.key, language: Language.ENGLISH);

  Future<(String, Weather, List<Weather>)> getWeather() async {
    CustomLocation location = await CustomLocationBuilder.build();

    Weather weather = await wf.currentWeatherByLocation(
      location.latitude,
      location.longitude,
    );

    List<Weather> forecast = await wf.fiveDayForecastByLocation(
      location.latitude,
      location.longitude,
    );

    return (location.city, weather, forecast);
  }
}
