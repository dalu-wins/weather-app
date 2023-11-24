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
        return Lottie.asset("assets/rainy.json", animate: animated);

      case "snow":
        return Lottie.asset("assets/snowy.json", animate: animated);

      case "mist":
      case "haze":
      case "fog":
      case "sand":
      case "dust":
      case "ash":
        return Lottie.asset("assets/foggy.json", animate: animated);

      case "clear":
        return Lottie.asset("assets/clear.json", animate: animated);

      case "clouds":
        return Lottie.asset("assets/cloudy.json", animate: animated);

      case "smoke":
      case "tornado":
      default:
        return Lottie.asset("assets/alert.json", animate: animated);
    }
  }
}
