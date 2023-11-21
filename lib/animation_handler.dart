import 'package:lottie/lottie.dart';

class AnimationHandler {
  static LottieBuilder getConditionAnimation(String condition) {
    switch (condition) {
      case "squall":
      case "thunderstorm":
        return Lottie.asset("assets/storm.json");

      case "drizzle":
      case "rain":
        return Lottie.asset("assets/rain.json");

      case "snow":
        return Lottie.asset("assets/snow.json");

      case "mist":
      case "haze":
      case "fog":
        return Lottie.asset("assets/fog.json");

      case "tornado":
      case "sand":
      case "smoke":
      case "dust":
      case "ash":
        return Lottie.asset("assets/alert.json");

      case "clear":
        return Lottie.asset("assets/clear.json");

      case "clouds":
        return Lottie.asset("assets/clouds.json");

      default:
        return Lottie.asset("assets/alert.json");
    }
  }
}
