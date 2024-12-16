import 'dart:convert';

import 'package:farm_easy/utils/Constants/string_constant.dart';
import 'package:farm_easy/Screens/Auth/UserResgister/Controller/partner_services_list.dart';
import 'package:farm_easy/Screens/Auth/UserResgister/Controller/select_corp.dart';
import 'package:farm_easy/Screens/Auth/UserResgister/Model/AgriProviderResponseModel.dart';
import 'package:farm_easy/Screens/Auth/UserResgister/Model/CreateUserResponseModel.dart';
import 'package:farm_easy/Screens/Auth/UserResgister/Model/FarmerExpertiesResponseModel.dart';
import 'package:farm_easy/Screens/Auth/UserResgister/Model/service_area_response_model.dart';
import 'package:farm_easy/Screens/Auth/UserResgister/ViewModel/agri_provider_response_model.dart';
import 'package:farm_easy/Screens/Auth/UserResgister/ViewModel/create_user_view_model.dart';
import 'package:farm_easy/Screens/Auth/UserResgister/ViewModel/farmer_experties_view_model.dart';
import 'package:farm_easy/Screens/Dashboard/view/dashboard.dart';
import 'package:farm_easy/API/Services/network/status.dart';
import 'package:farm_easy/utils/SharedPreferences/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class UserController extends GetxController {
  FocusNode focusNode = FocusNode();
  FocusNode focusNodeName = FocusNode();
  RxString cityValue = ''.obs;
  RxString stateValue = ''.obs;
  RxString countryValue = ''.obs;

  Future<void> fetchPlaceDetails(String placeId) async {
    final String apiKey = StringConstatnt.GOOGLE_PLACES_API;
    final url =
        'https://maps.googleapis.com/maps/api/place/details/json?place_id=$placeId&key=$apiKey';

    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final json = jsonDecode(response.body);
      final result = json['result'];
      String? city;
      String? state;
      String? country;

      result['address_components'].forEach((component) {
        if (component['types'].contains('locality')) {
          city = component['long_name'];
        } else if (component['types'].contains('administrative_area_level_1')) {
          state = component['long_name'];
        } else if (component['types'].contains('country')) {
          country = component['long_name'];
        }
      });
      cityValue.value = city ?? '';
      stateValue.value = state ?? '';
      countryValue.value = country ?? '';
      print('City: ${cityValue.value}');
      print('State: ${stateValue.value}');
      print('Country: ${countryValue.value}');
    } else {
      print('Failed to fetch place details');
    }
  }

  RxInt? select = RxInt(-1);
  RxList title = ['Land Owner', 'Agent'].obs;
  RxString userProfieType = ''.obs;
  RxList subtitle =
      ['I own the land.', '     Property Broker, Land agent, etc.    '].obs;
  final locationController = TextEditingController().obs;

  Rx<TextEditingController> locationfetching =
      TextEditingController(text: "fetching location...").obs;
  final nameController = TextEditingController().obs;
  RxList agriItems = [].obs;
  RxList farmerItems = [].obs;
  RxString userType = ''.obs;

  RxString servicableAreaName = ''.obs;
  RxInt servicableAreaId = 0.obs;
  // FocusNode focusNode = FocusNode();
  final cropcontroller = Get.put(FarmerCrops());
  final _apiService = ServiceAreaViewModel();
  final loadingService = false.obs;
  final serviceData = ServiceableAreaResponseModel().obs;
  void setRequestStatusService(Status _value) =>
      rxRequestStatusService.value = _value;
  void setCreateUserDataService(ServiceableAreaResponseModel _value) =>
      serviceData.value = _value;
  final rxRequestStatusService = Status.LOADING.obs;

  ///FOR_LANDOWNER
  final _api = CreateUserViewModel();

  final loading = false.obs;

  final createUserData = CreateUserResponseModel().obs;
  final rxRequestStatus = Status.LOADING.obs;
  void setRequestStatus(Status _value) => rxRequestStatus.value = _value;

  void setCreateUserData(CreateUserResponseModel _value) =>
      createUserData.value = _value;

  final AppPreferences _prefs = AppPreferences();

  ///FOR_LANDOWNER
  Future landowner() async {
    loading.value = true;
    _api.userTypeData({
      "full_name": "${nameController.value.text}",
      "lives_in": "${locationController.value.text}",
      "profile_type": "${userProfieType.value}",
      "latitude": "$selectedLatitude",
      "longitude": "$selectedLongitude",
      "city": "${cityValue.value}",
      "state": "${stateValue.value}",
      "country": "${countryValue.value}"
    }, {
      "Authorization": 'Bearer ${await _prefs.getUserAccessToken()}'
    }).then((value) async {
      await _prefs.setUserName(nameController.value.text ?? "");
      // Get.snackbar(
      //   'Message',
      //   'Registeration Successfull',
      //   snackPosition: SnackPosition.TOP,
      //   duration: Duration(seconds: 3),
      //   colorText: Colors.black,
      //   instantInit: true,
      //   backgroundGradient: AppColor.PRIMARY_GRADIENT,
      //   maxWidth: double.infinity,
      // );
      Get.offAll(() => DashBoard());
    }).onError((error, stackTrace) {});
  }

  Future servicesArea(String url) async {
    loading.value = true;
    _apiService.agriProvider(url).then((value) async {
      loading.value = false;
      setCreateUserDataService(value);
    }).onError((error, stackTrace) {
      print(error);
      print(stackTrace);
    });
  }

  ///FOR_FARMER
  Future farmer() async {
    loading.value = true;
    _api.userTypeData(
        jsonEncode({
          "full_name": "${nameController.value.text}",
          "lives_in": "${locationController.value.text}",
          "crop_expertise": cropcontroller.selectedCropsId.toList(),
          "latitude": "$selectedLatitude",
          "longitude": "$selectedLongitude",
          "city": "${cityValue.value}",
          "state": "${stateValue.value}",
          "country": "${countryValue.value}"
        }),
        {
          "Authorization": 'Bearer ${await _prefs.getUserAccessToken()}',
          "Content-Type": "application/json"
        }).then((value) async {
      _prefs.setUserName(nameController.value.text ?? "");
      // Get.snackbar(
      //   'Message',
      //   'Registeration Successfull',
      //   snackPosition: SnackPosition.TOP,
      //   duration: Duration(seconds: 3),
      //   colorText: Colors.black,
      //   instantInit: true,
      //   backgroundGradient: AppColor.PRIMARY_GRADIENT,
      //   maxWidth: double.infinity,
      // );
      Get.offAll(() => DashBoard());
    }).onError((error, stackTrace) {
      print(error);
      print(stackTrace);
    });
  }

  final serviceController = Get.put(PartnerServicesList());

  ///FOR_AGRI_PROVIDER
  Future agriProvider() async {
    loading.value = true;
    _api.userTypeData(
        jsonEncode(
          {
            "full_name": "${nameController.value.text}",
            "lives_in": "${locationController.value.text}",
            "services": serviceController.agriItems.toList(),
            "latitude": "$selectedLatitude",
            "longitude": "$selectedLongitude",
            "serviceable_area": "${servicableAreaId.value}",
            "city": "${cityValue.value}",
            "state": "${stateValue.value}",
            "country": "${countryValue.value}"
          },
        ),
        {
          "Authorization": 'Bearer ${await _prefs.getUserAccessToken()}',
          "Content-Type": "application/json"
        }).then((value) async {
      _prefs.setUserName(nameController.value.text ?? "");

      Get.offAll(() => DashBoard());
    }).onError((error, stackTrace) {});
  }

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    print("on Init Called");
    focusNodeName.requestFocus();
    farmerExperties();
  }

  ///FOR_FARMER_EXPERTIES
  final _farmerExperties = FarmerExpertiesViewModel();
  final farmerLoading = false.obs;
  final farmerExpertiesData = FarmerExpertiesResponseModel().obs;
  final rxRequestStatusFarmerExperties = Status.LOADING.obs;
  void setRequestStatusFarmerExperties(Status _value) =>
      rxRequestStatusFarmerExperties.value = _value;
  void setFarmerExpertiesData(FarmerExpertiesResponseModel _value) =>
      farmerExpertiesData.value = _value;
  void farmerExperties() {
    loading.value = true;
    _farmerExperties.farmerExperties().then((value) {
      setFarmerExpertiesData(value);
      setRequestStatusFarmerExperties(Status.SUCCESS);
    }).onError((error, stackTrace) {
      setRequestStatusFarmerExperties(Status.ERROR);
      print(error);
      print(stackTrace);
    });
  }

  ///FARMER_CROPS

  ///FOR AGRI_PROVIDER_ROLES
  final _agriProviderRoles = AgriProviderViewModel();
  final agriProviderRolesData = AgriProviderResponseModel().obs;
  final agriRolesLoading = false.obs;
  final rxRequestStatusAgriRoles = Status.LOADING.obs;
  void setRequestAgriRoles(Status _value) =>
      rxRequestStatusAgriRoles.value = _value;
  void setAgriProviderData(AgriProviderResponseModel _value) =>
      agriProviderRolesData.value = _value;
  void agriProviderRoles() {
    loading.value = true;
    _agriProviderRoles.agriProvider().then((value) {
      setAgriProviderData(value);
      setRequestAgriRoles(Status.SUCCESS);
    }).onError((error, stackTrace) {
      setRequestAgriRoles(Status.ERROR);
      print(error);
    });
  }

  double selectedLatitude = 0.0;
  double selectedLongitude = 0.0;

  RxBool locationLoading = false.obs;
  Future detectLocation() async {
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
    List<Placemark> placemarks = await placemarkFromCoordinates(
      position.latitude,
      position.longitude,
    );
    if (placemarks.isNotEmpty) {
      Placemark placemark = placemarks.first;
      locationController.value.text =
          "${placemark.subLocality}, ${placemark.locality}, ${placemark.administrativeArea}";
    }
    locationLoading.value = false;
  }
}
