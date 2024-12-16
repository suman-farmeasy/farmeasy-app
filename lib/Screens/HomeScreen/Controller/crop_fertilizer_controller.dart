import 'package:farm_easy/Screens/HomeScreen/Model/crop_fertilizer_data_model.dart';
import 'package:farm_easy/Screens/HomeScreen/ViewModel/land_list_viewmodel.dart';
import 'package:farm_easy/API/Services/network/status.dart';
import 'package:farm_easy/utils/SharedPreferences/shared_preferences.dart';
import 'package:get/get.dart';

class CropFertilizerController extends GetxController {
  final prefs = AppPreferences();
  final _api = CropFertilizerViewModel();
  final cropData = CropFertilizerDataModel().obs;
  RxInt nitrogen = 0.obs;
  RxInt phosphorus = 0.obs;
  RxInt potassium = 0.obs;
  final loading = false.obs;
  RxInt cropId = 0.obs;
  final refreshloading = false.obs;
  final rxRequestStatus = Status.LOADING.obs;
  void setRxRequestStatus(Status _value) => rxRequestStatus.value = _value;
  void setRxRequestData(CropFertilizerDataModel _value) =>
      cropData.value = _value;
  Future<void> cropfertilizer(int crop) async {
    loading.value = true;
    _api.cropFertilizer(crop, {
      "Authorization": 'Bearer ${await prefs.getUserAccessToken()}',
      "Content-Type": "application/json"
    }).then((value) {
      potassium.value = value.result!.potassium!.toInt() ?? 0;
      phosphorus.value = value.result!.phosphorus!.toInt() ?? 0;
      nitrogen.value = value.result!.nitrogen!.toInt() ?? 0;
      loading.value = false;
      setRxRequestData(value);
    }).onError((error, stackTrace) {
      loading.value = false;
      print(error);
      print(stackTrace);
    });
  }
}
