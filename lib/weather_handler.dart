import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:weather/weather.dart';
import 'package:weather_app/api_key_secret.dart';
import 'package:lottie/lottie.dart';

class WeatherHandler {
  WeatherFactory wf = WeatherFactory(APIKey.key, language: Language.ENGLISH);

  Future<(String, int, LottieBuilder)> getWeather() async {
    permissionCheck(); // Handling permission dialouges

    // Default values
    String city = "San Francisco";
    int temp = 30;

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
    Weather w = await wf.currentWeatherByLocation(
      position.latitude,
      position.longitude,
    );
    temp = w.temperature!.celsius!.round();

    // Parse weather condition to icon
    String condition = w.weatherMain!.toLowerCase();
    LottieBuilder conditionAnimation;

    switch (condition) {
      case "squall":
      case "thunderstorm":
        conditionAnimation = Lottie.asset("assets/storm.json");
        break;

      case "drizzle":
      case "rain":
        conditionAnimation = Lottie.asset("assets/rain.json");
        break;

      case "snow":
        conditionAnimation = Lottie.asset("assets/snow.json");
        break;

      case "mist":
      case "haze":
      case "fog":
        conditionAnimation = Lottie.asset("assets/fog.json");
        break;

      case "tornado":
      case "sand":
      case "smoke":
      case "dust":
      case "ash":
        conditionAnimation = Lottie.asset("assets/alert.json");
        break;

      case "clear":
        conditionAnimation = Lottie.asset("assets/clear.json");
        break;

      case "clouds":
        conditionAnimation = Lottie.asset("assets/clouds.json");
        break;

      default:
        conditionAnimation = Lottie.asset("assets/alert.json");
    }

    return (city, temp, conditionAnimation);
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
