import 'package:farm_easy/Screens/Auth/UserResgister/ViewModel/agri_provider_response_model.dart';
import 'package:farm_easy/Screens/LandSection/MatchingAgriProvider/Model/MatchingAgriProviderResponseModel.dart';
import 'package:farm_easy/Screens/LandSection/MatchingAgriProvider/ViewModel/agri_service_view_model.dart';
import 'package:farm_easy/API/Services/network/status.dart';
import 'package:farm_easy/Utils/SharedPreferences/shared_preferences.dart';
import 'package:get/get.dart';

class AgriController extends GetxController {
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    getAgriData();
  }

  final _agriApi = MatchingAgriServiceViewModel();
  final agriProviderData = MatchingAgriProviderResponseModel().obs;
  final agriLoding = false.obs;
  final rxRequestStatus = Status.LOADING.obs;
  RxInt landId = 0.obs;
  void setRequest(Status _vlue) => rxRequestStatus.value = _vlue;
  void setRxRequestData(MatchingAgriProviderResponseModel _value) =>
      agriProviderData.value = _value;
  final _prefs = AppPreferences();
  Future getAgriData() async {
    agriLoding.value = true;
    _agriApi.matchingAgriProvider(
      {
        "Authorization": 'Bearer ${await _prefs.getUserAccessToken()}',
        "Content-Type": "application/json"
      },
      landId.value,
    ).then((value) {
      agriLoding.value = false;
      setRxRequestData(value);
    }).onError((error, stackTrace) {});
  }
}
