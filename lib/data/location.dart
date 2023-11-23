import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';

class CustomLocation {
  double longitude;
  double latitude;
  String city;
  CustomLocation(this.longitude, this.latitude, this.city);
}

class CustomLocationBuilder {
  static Future<CustomLocation> build() async {
    String city = "undefined";

    Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.best,
    ).timeout(const Duration(seconds: 5));

    try {
      List<Placemark> placemarks = await placemarkFromCoordinates(
        position.latitude,
        position.longitude,
      );
      city = placemarks[0].locality!;
    } catch (err) {
      Future.error("Parsing city from coordinates failed.");
    }

    return CustomLocation(position.longitude, position.latitude, city);
  }
}
