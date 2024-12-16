import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart' as geo;
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapController extends GetxController with WidgetsBindingObserver {
  @override
  void onInit() {
    super.onInit();
    WidgetsBinding.instance
        .addObserver(this); // Add observer for lifecycle changes
    getCurrentLocation();
  }

  @override
  void onClose() {
    super.onClose();
    WidgetsBinding.instance.removeObserver(this); // Remove observer
    locationController.value.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      // Check permissions again when the app is resumed
      checkLocationPermissionOnResume();
    }
  }

  RxBool showMap = true.obs;
  RxString fullAddress = "".obs;
  var drawnPolygon = <LatLng>[].obs;
  var polygons = <Polygon>{}.obs;
  final Rx<GoogleMapController?> mapController = Rx<GoogleMapController?>(null);
  final Rx<CameraPosition?> initialCameraPosition = Rx<CameraPosition?>(null);
  final Rx<Marker?> currentLocationMarker = Rx<Marker?>(null);
  final locationController = TextEditingController().obs;
  Rx<LatLng?> pinnedLocation = Rx<LatLng?>(null); // Save pinned location

  Future<void> getCurrentLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    if (pinnedLocation.value != null) {
      initialCameraPosition.value = CameraPosition(
        target: pinnedLocation.value!,
        zoom: 15,
      );
      return;
    }

    // Check if location services are enabled
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      Get.defaultDialog(
        title: 'Location Services Disabled',
        middleText: 'Please enable location services to continue.',
        confirm: ElevatedButton(
          onPressed: () {
            Geolocator.openLocationSettings(); // Open location settings
          },
          child: Text('Enable Location'),
        ),
      );
      return;
    }

    // Request location permission
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return; // Permission still denied
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // If permission is permanently denied, prompt the user to go to app settings
      showPermissionDeniedDialog();
      return;
    }

    // Dismiss dialog if permission is granted and services are enabled
    if (Get.isDialogOpen!) {
      Get.back(); // Close the dialog if it's still open
    }

    // If permission is granted, get the current location
    try {
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

  // Check permission again when app resumes
  Future<void> checkLocationPermissionOnResume() async {
    LocationPermission permission = await Geolocator.checkPermission();

    if (permission == LocationPermission.always ||
        permission == LocationPermission.whileInUse) {
      // Permission granted, dismiss the dialog if it's open
      if (Get.isDialogOpen!) {
        Get.back(); // Close the dialog if it's open
      }
      getCurrentLocation(); // Proceed to get current location if permission is granted
    } else if (permission == LocationPermission.denied) {
      // If permission is denied, show the request dialog again
      showPermissionDialog();
    } else if (permission == LocationPermission.deniedForever) {
      // If permission is denied forever, show the permission denied dialog
      showPermissionDeniedDialog();
    }
  }

  // Show the permission request dialog
  void showPermissionDialog() {
    Get.defaultDialog(
      title: 'Location Permission Needed',
      middleText:
          'Location access is required to show your current location. Please grant permission.',
      confirm: ElevatedButton(
        onPressed: () async {
          LocationPermission permission = await Geolocator.requestPermission();
          if (permission == LocationPermission.always ||
              permission == LocationPermission.whileInUse) {
            Get.back(); // Close the dialog
            getCurrentLocation(); // Proceed with location access
          } else {
            Get.snackbar(
              'Permission Denied',
              'You need to grant location permission to continue.',
              snackPosition: SnackPosition.BOTTOM,
            );
          }
        },
        child: Text('Grant Permission'),
      ),
      barrierDismissible: false,
    );
  }

  // Show the permission denied forever dialog
  void showPermissionDeniedDialog() {
    Get.defaultDialog(
      title: 'Permission Denied',
      middleText:
          'Location permissions are permanently denied. Please enable location access in app settings.',
      confirm: ElevatedButton(
        onPressed: () {
          Geolocator.openAppSettings(); // Open app settings
        },
        child: Text('Open Settings'),
      ),
      barrierDismissible: false,
    );
  }

  Future<void> moveToLocation(String location) async {
    try {
      List<geo.Location> locations = await geo.locationFromAddress(location);
      if (locations.isNotEmpty) {
        geo.Location loc = locations.first;
        mapController.value?.animateCamera(
          CameraUpdate.newLatLngZoom(
            LatLng(loc.latitude, loc.longitude),
            15, // Zoom level
          ),
        );
      } else {
        print('Location not found');
      }
    } catch (e) {
      print('Error in moveToLocation: $e');
    }
  }
}
