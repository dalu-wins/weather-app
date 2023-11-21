import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:weather/weather.dart';
import 'package:weather_app/api_key_secret.dart';

class WeatherHandler {
  WeatherFactory wf = WeatherFactory(APIKey.key, language: Language.ENGLISH);

  Future<(String, Weather)> getWeather() async {
    permissionCheck(); // Handling permission dialouges

    // Default values
    String city = "San Francisco";

    // Get position coordinates
    Position position = await Geolocator.getCurrentPosition(
            desiredAccuracy: LocationAccuracy.best)
        .timeout(const Duration(seconds: 5));

    // Get nearest city
    try {
      List<Placemark> placemarks = await placemarkFromCoordinates(
        position.latitude,
        position.longitude,
      );
      city = placemarks[0].locality!;
    } catch (err) {
      Future.error("Parsing city from coordinates failed.");
    }

    // OpenWeather API call
    Weather weather = await wf.currentWeatherByLocation(
      position.latitude,
      position.longitude,
    );

    return (city, weather);
  }

  Future<void> permissionCheck() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }
  }
}
