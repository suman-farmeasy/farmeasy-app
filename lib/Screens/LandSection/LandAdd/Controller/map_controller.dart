import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapController extends GetxController {
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    initialCameraPosition;
    currentLocationMarker;
    getCurrentLocation();
  }

  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
    locationController.value.dispose();
  }

  RxBool showMap = true.obs;
  RxString fullAddress = "".obs;
  var drawnPolygon = <LatLng>[].obs;
  var polygons = <Polygon>{}.obs;
  final Rx<GoogleMapController?> mapController = Rx<GoogleMapController?>(null);
  final Rx<CameraPosition?> initialCameraPosition = Rx<CameraPosition?>(null);
  final Rx<Marker?> currentLocationMarker = Rx<Marker?>(null);
  final locationController = TextEditingController().obs;

  Future<void> getCurrentLocation() async {
    try {
      LocationPermission permission = await Geolocator.requestPermission();

      if (permission == LocationPermission.denied) {
        // Handle denied permission
        return;
      }

      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );
      initialCameraPosition.value = CameraPosition(
        target: LatLng(position.latitude, position.longitude),
        zoom: 15,
      );

      currentLocationMarker.value = Marker(
        markerId: MarkerId("currentLocation"),
        position: LatLng(position.latitude, position.longitude),
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
        draggable: true,
        onDragEnd: (newPosition) {
          currentLocationMarker.value = currentLocationMarker.value?.copyWith(
            positionParam: newPosition,
          );
        },
      );
    } catch (e) {
      print(e.toString());
    }
  }

  Future<void> moveToLocation(String location) async {
    List<Location> locations = await locationFromAddress(location);
    if (locations.isNotEmpty) {
      Location loc = locations.first;
      mapController.value?.animateCamera(
        CameraUpdate.newLatLngZoom(
          LatLng(loc.latitude, loc.longitude),
          15,
        ),
      );
    } else {
      print('Location not found');
    }
  }
}
