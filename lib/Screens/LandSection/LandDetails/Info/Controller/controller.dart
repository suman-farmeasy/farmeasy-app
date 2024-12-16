import 'package:farm_easy/Screens/LandSection/LandDetails/Info/Controller/land_weather_controller.dart';
import 'package:farm_easy/Screens/LandSection/LandDetails/Info/Model/LandDetailsResponseModel.dart';
import 'package:farm_easy/Screens/LandSection/LandDetails/Info/ViewModel/land_info_view_model.dart';
import 'package:farm_easy/API/Services/network/status.dart';
import 'package:farm_easy/Utils/SharedPreferences/shared_preferences.dart';
import 'package:file_picker/file_picker.dart';
import 'package:get/get.dart';
import 'dart:io';

import 'package:http/http.dart';

class LandInfoController extends GetxController {
  RxInt select = 0.obs;
  RxBool containerVisible = true.obs;
  RxBool waterSourceVisible = true.obs;
  RxBool isvissible = false.obs;
  final _prefs = AppPreferences();
  RxList title = [
    "Agriculture",
    "Abc",
    "Commercial",
    "Non- Agricultural",
  ].obs;

  RxString selectedValue = 'Available'.obs;

  void setSelectedValue(String value) {
    selectedValue.value = value;
    waterSourceVisible = false.obs;
  }

  RxInt landId = 0.obs;
  final _api = LandDetailViewModel();
  final landDetailsLoading = false.obs;
  final landDetailsData = LandDetailsResponseModel().obs;
  final rxlandDetailsLoading = Status.LOADING.obs;
  void setRxlandDetails(Status _value) => rxlandDetailsLoading.value = _value;
  void setRxLandDetailsData(LandDetailsResponseModel _value) =>
      landDetailsData.value = _value;
  Future<void> getLandDetails() async {
    landDetailsLoading.value = true;
    _api.landInfo({
      "Authorization": 'Bearer ${await _prefs.getUserAccessToken()}',
      "Content-Type": "application/json"
    }, landId.value).then((value) {
      landDetailsLoading.value = false;
      setRxLandDetailsData(value);
      final weatherController = Get.find<LandWeatherController>();
      final latitude = double.parse(value.result!.latitude ?? '0');
      final longitude = double.parse(value.result!.longitude ?? '0');

      weatherController.currentWeather(latitude, longitude);
    }).onError((error, stackTrace) {
      print(error);
      print(stackTrace);
    });
  }
}
