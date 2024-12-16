import 'dart:convert';

import 'package:farm_easy/Screens/HomeScreen/Model/FCMTokenResponseModel.dart';
import 'package:farm_easy/Screens/HomeScreen/ViewModel/land_list_viewmodel.dart';
import 'package:farm_easy/API/Services/network/status.dart';
import 'package:farm_easy/utils/SharedPreferences/shared_preferences.dart';
import 'package:get/get.dart';

class DeviceTokenController extends GetxController {
  final _api = FCMTokenViewModel();
  final loading = false.obs;
  RxString token = "".obs;
  final fcmData = FcmTokenResponseModel().obs;
  final rxRequestdata = Status.LOADING.obs;
  final prefs = AppPreferences();
  void rxRequestStatus(Status _value) => rxRequestdata.value = _value;
  void setRxRequestData(FcmTokenResponseModel _value) => fcmData.value = _value;
  Future<void> fcmToken(String token) async {
    loading.value = true;
    _api.fcmToken(
        {
          "Authorization": 'Bearer ${await prefs.getUserAccessToken()}',
          "Content-Type": "application/json"
        },
        jsonEncode({
          "fcm_token": token,
        })).then((value) {
      loading.value = false;
      setRxRequestData(value);
    }).onError((error, stackTrace) {
      print(error);
      print(stackTrace);
    });
  }
}
