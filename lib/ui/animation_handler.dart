import 'package:lottie/lottie.dart';

class AnimationHandler {
  static LottieBuilder getConditionAnimation(String condition,
      {bool animated = true}) {
    switch (condition) {
      case "squall":
      case "thunderstorm":
        return Lottie.asset("assets/storm.json", animate: animated);

      case "drizzle":
      case "rain":
        return Lottie.asset("assets/rain.json", animate: animated);

      case "snow":
        return Lottie.asset("assets/snow.json", animate: animated);

      case "mist":
      case "haze":
      case "fog":
        return Lottie.asset("assets/fog.json", animate: animated);

      case "tornado":
      case "sand":
      case "smoke":
      case "dust":
      case "ash":
        return Lottie.asset("assets/alert.json", animate: animated);

      case "clear":
        return Lottie.asset("assets/clear.json", animate: animated);

      case "clouds":
        return Lottie.asset("assets/clouds.json", animate: animated);

      default:
        return Lottie.asset("assets/alert.json", animate: animated);
    }
  }
}
