import 'package:farm_easy/Screens/LandSection/MatchingAgriProvider/Model/MatchingAgriProviderResponseModel.dart';
import 'package:farm_easy/Screens/LandSection/MatchingAgriProvider/ViewModel/agri_service_view_model.dart';
import 'package:farm_easy/Services/network/status.dart';
import 'package:farm_easy/SharedPreferences/shared_preferences.dart';
import 'package:get/get.dart';

class AgriController extends GetxController {
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    getAgriData(100);
    Future.delayed(Duration(seconds: 2), () {
      showAnimation.value = false;
    });
  }

  var currentDistance = 100.obs;

  // Update distance based on slider value
  void updateDistance(double value) {
    currentDistance.value = value.toInt();
  }

  RxBool showAnimation = true.obs;
  final _agriApi = MatchingAgriServiceViewModel();
  final agriProviderData = MatchingAgriProviderResponseModel().obs;
  final agriLoding = false.obs;
  final rxRequestStatus = Status.LOADING.obs;
  RxInt landId = 0.obs;
  void setRequest(Status _vlue) => rxRequestStatus.value = _vlue;
  void setRxRequestData(MatchingAgriProviderResponseModel _value) =>
      agriProviderData.value = _value;
  final _prefs = AppPreferences();
  Future getAgriData(int distance) async {
    agriLoding.value = true;
    _agriApi.matchingAgriProvider({
      "Authorization": 'Bearer ${await _prefs.getUserAccessToken()}',
      "Content-Type": "application/json"
    }, landId.value, distance).then((value) {
      agriLoding.value = false;
      setRxRequestData(value);
    }).onError((error, stackTrace) {});
  }
}
