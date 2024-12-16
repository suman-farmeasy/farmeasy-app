import 'package:farm_easy/Screens/LandSection/LandDetails/Info/Controller/controller.dart';
import 'package:farm_easy/Screens/LandSection/LandDetails/Info/Model/CheckLandDetailsResponseModel.dart';
import 'package:farm_easy/Screens/LandSection/LandDetails/Info/ViewModel/land_info_view_model.dart';
import 'package:farm_easy/API/Services/network/status.dart';
import 'package:farm_easy/utils/SharedPreferences/shared_preferences.dart';
import 'package:get/get.dart';

class ChecklandDetailsController extends GetxController {
  final controller = Get.put(LandInfoController());

  final _api = CheckLandDetailsViewMOdel();
  final landData = CheckLandDetailsResponseModel().obs;
  final loading = false.obs;
  final rxRequestStatus = Status.LOADING.obs;
  RxInt landId = 0.obs;
  final _prefs = AppPreferences();
  void setRxRequestStatus(Status _value) => rxRequestStatus.value = _value;
  void setRxRequestData(CheckLandDetailsResponseModel _value) =>
      landData.value = _value;

  Future landDetails(int landId) async {
    loading.value = true;
    _api.landDetails({
      "Authorization": 'Bearer ${await _prefs.getUserAccessToken()}',
      "Content-Type": "application/json"
    }, landId).then((value) {
      controller.getLandDetails(landId);
      loading.value = false;
      setRxRequestData(value);
    }).onError((error, stackTrace) {});
  }
}
