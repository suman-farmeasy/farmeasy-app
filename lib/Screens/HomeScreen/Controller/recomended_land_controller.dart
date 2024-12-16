import 'package:farm_easy/Screens/HomeScreen/Model/recomended_lands.dart';
import 'package:farm_easy/Screens/HomeScreen/ViewModel/land_list_viewmodel.dart';
import 'package:farm_easy/Services/network/status.dart';
import 'package:farm_easy/SharedPreferences/shared_preferences.dart';
import 'package:get/get.dart';

class RecommendedLandController extends GetxController {
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    recommendedLandData(100);
  }

  var currentDistance = 100.obs; // Initial distance

// Update distance based on slider value
  void updateDistance(double value) {
    currentDistance.value = value.toInt();
  }

  final prefs = AppPreferences();
  final _api = RecomendedLandViewModel();
  final landData = RecomendedLandResponseModel().obs;
  final loading = false.obs;
  final rxRequestStatus = Status.LOADING.obs;
  void setRxRequestStatus(Status _value) => rxRequestStatus.value = _value;
  void setRxRequestData(RecomendedLandResponseModel _value) =>
      landData.value = _value;
  Future<void> recommendedLandData(int distance) async {
    loading.value = true;
    _api.landList({
      "Authorization": 'Bearer ${await prefs.getUserAccessToken()}',
      "Content-Type": "application/json"
    }, distance).then((value) {
      loading.value = false;
      setRxRequestData(value);
    }).onError((error, stackTrace) {});
  }
}
