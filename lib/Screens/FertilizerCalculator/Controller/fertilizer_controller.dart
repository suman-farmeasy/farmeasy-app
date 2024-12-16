import 'package:farm_easy/Screens/FertilizerCalculator/Model/fertilizer_calculated_model.dart';
import 'package:farm_easy/Screens/FertilizerCalculator/View/fertilizer_calculator.dart';
import 'package:farm_easy/Screens/FertilizerCalculator/ViewModel/fertilizer_view_model.dart';
import 'package:farm_easy/API/Services/network/status.dart';
import 'package:farm_easy/utils/SharedPreferences/shared_preferences.dart';
import 'package:get/get.dart';

class FertilizerCalculatedController extends GetxController {
  final prefs = AppPreferences();
  final _api = FertilizerCalculatedViewModel();

  final cropData = FertilizerCalculatedValueModel().obs;
  final loading = false.obs;
  final rxRequestStatus = Status.LOADING.obs;
  void setRxRequestStatus(Status _value) => rxRequestStatus.value = _value;
  void setRxRequestData(FertilizerCalculatedValueModel _value) =>
      cropData.value = _value;
  Future<void> fertilizer(String landSize, String landUnit, int nitrogen,
      int phosphorus, int potassium, int cropId) async {
    loading.value = true;
    _api.fertilizer({
      "Authorization": 'Bearer ${await prefs.getUserAccessToken()}',
      "Content-Type": "application/json"
    }, landSize, landUnit, nitrogen, phosphorus, potassium, cropId).then(
        (value) {
      loading.value = false;
      setRxRequestData(value);
      Get.to(() => FertilizerCalculator());
    }).onError((error, stackTrace) {
      loading.value = false;
      print(error);
      print(stackTrace);
    });
  }
}
