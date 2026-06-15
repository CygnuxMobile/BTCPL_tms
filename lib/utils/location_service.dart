import 'package:geolocator/geolocator.dart';

class LocationModule {
  Position? lastLocation;
  Future<void> init() async {
    await Geolocator.requestPermission();
    await Geolocator.getCurrentPosition().then((value) {
      lastLocation = value;
    });
  }

  Future<double> getCurrentDistance() async {
    Position currentPosition = await Geolocator.getCurrentPosition();
    double distanceInMeters = Geolocator.distanceBetween(
      lastLocation!.latitude,
      lastLocation!.longitude,
      currentPosition.latitude,
      currentPosition.longitude,
    );
    lastLocation = currentPosition;
    return distanceInMeters;
  }
}
