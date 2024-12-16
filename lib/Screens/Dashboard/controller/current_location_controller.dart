import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';

class CurrentLocation extends GetxController {
  RxBool locationLoading = false.obs;
  RxDouble long = 0.0.obs;
  RxDouble lat = 0.0.obs;

  Future<void> detectLocation() async {
    bool serviceEnabled;
    locationLoading.value = true;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return;
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.deniedForever) {
      return;
    }

    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission != LocationPermission.whileInUse &&
          permission != LocationPermission.always) {
        return;
      }
    }

    Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );
    lat.value = position.latitude;
    long.value = position.longitude;

    print('@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@Latitude: ${lat.value}');
    print('@@@@@@@@@@@@@@@@@@@@@@@@@@@Longitude: ${long.value}');

    locationLoading.value = false;
  }
}
