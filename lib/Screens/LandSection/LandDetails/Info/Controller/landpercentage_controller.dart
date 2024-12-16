
import 'package:farm_easy/Screens/LandSection/LandDetails/Info/Model/LandPercentageResponseModel.dart';
import 'package:farm_easy/Screens/LandSection/LandDetails/Info/ViewModel/land_info_view_model.dart';
import 'package:farm_easy/Services/network/status.dart';
import 'package:farm_easy/SharedPreferences/shared_preferences.dart';
import 'package:get/get.dart';

class LandPercentageController extends GetxController{

@override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    percentageIndicator();
  }
  final _api = LandPercentageViewModel();
  final percentIndicate = LandPercentageResponseModel().obs;
  final loading = false.obs;
  final rxRequestStatus = Status.LOADING.obs;
  RxInt landId= 0.obs;
  final _prefs = AppPreferences();
  void setRxRequestStatus(Status _value)=>rxRequestStatus.value=_value;
  void setRxRequestData(LandPercentageResponseModel _value)=>percentIndicate.value=_value;
  Future<void> percentageIndicator() async {
    loading.value=true;
    _api.landPercentage(
    {"Authorization":'Bearer ${ await _prefs.getUserAccessToken()}',"Content-Type": "application/json"},
      landId.value
    ).then((value) {
      setRxRequestData(value);
    }).onError((error, stackTrace) {
      print(error);
    });
  }
}