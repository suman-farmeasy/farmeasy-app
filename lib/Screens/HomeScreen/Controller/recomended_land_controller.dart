import 'package:farm_easy/Screens/HomeScreen/Model/recomended_lands.dart';
import 'package:farm_easy/Screens/HomeScreen/ViewModel/land_list_viewmodel.dart';
import 'package:farm_easy/API/Services/network/status.dart';
import 'package:farm_easy/Utils/SharedPreferences/shared_preferences.dart';
import 'package:get/get.dart';

class RecommendedLandController extends GetxController {
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    recommendedLandData();
  }

  final prefs = AppPreferences();
  final _api = RecomendedLandViewModel();
  final landData = RecomendedLandResponseModel().obs;
  final loading = false.obs;
  final rxRequestStatus = Status.LOADING.obs;
  void setRxRequestStatus(Status _value) => rxRequestStatus.value = _value;
  void setRxRequestData(RecomendedLandResponseModel _value) =>
      landData.value = _value;
  Future<void> recommendedLandData() async {
    loading.value = true;
    _api.landList({
      "Authorization": 'Bearer ${await prefs.getUserAccessToken()}',
      "Content-Type": "application/json"
    }).then((value) {
      loading.value = false;
      setRxRequestData(value);
    }).onError((error, stackTrace) {});
  }
}
