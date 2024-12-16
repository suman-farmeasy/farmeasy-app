import 'package:farm_easy/Screens/LandSection/LandAdd/Model/list_others_crop_response_model.dart';
import 'package:farm_easy/Screens/LandSection/LandAdd/ViewModel/land_view_model.dart';
import 'package:farm_easy/Services/network/status.dart';
import 'package:farm_easy/SharedPreferences/shared_preferences.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

class ListOthersCropController extends GetxController {
  final _api = ListOthersCropViewModel();
  final cropData = ListOthersCropsResponseModel().obs;
  final loading = false.obs;
  final rxRequestStatus = Status.LOADING.obs;
  RxInt landId = 0.obs;
  final cropController = TextEditingController().obs;
  final _prefs = AppPreferences();
  void setRxRequestStatus(Status _value) => rxRequestStatus.value = _value;
  void setRxRequestData(ListOthersCropsResponseModel _value) =>
      cropData.value = _value;
  Future listOtherCrop(String crop) async {
    loading.value = true;
    _api.cropData({
      "Authorization": 'Bearer ${await _prefs.getUserAccessToken()}',
      "Content-Type": "application/json"
    }, crop).then((value) {
      setRxRequestData(value);
      setRxRequestStatus(Status.SUCCESS);
      loading.value = false;
    }).onError((error, stackTrace) {
      loading.value = false;
      print(error);
      print(stackTrace);
    });
  }
}
