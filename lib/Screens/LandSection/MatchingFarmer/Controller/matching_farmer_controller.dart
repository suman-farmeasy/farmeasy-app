import 'package:farm_easy/Screens/LandSection/MatchingFarmer/Model/MatchingFarmerResponseModel.dart';
import 'package:farm_easy/Screens/LandSection/MatchingFarmer/ViewModel/matching_farmer_view_model.dart';
import 'package:farm_easy/API/Services/network/status.dart';
import 'package:farm_easy/Utils/SharedPreferences/shared_preferences.dart';
import 'package:get/get.dart';

class MatchingFarmerController extends GetxController {
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    matchingFarmer();
  }

  final _matchingApi = MatchingFarmerViewModel();
  final matchingFarmerData = MatchingFarmerResponseModel().obs;
  RxInt landId = 0.obs;
  final farmerLoading = false.obs;
  final rxRequestStatus = Status.LOADING.obs;
  final _prefs = AppPreferences();
  void setRxRequsetValue(Status _value) => rxRequestStatus.value = _value;
  void setRxRequestData(MatchingFarmerResponseModel _value) =>
      matchingFarmerData.value = _value;
  Future matchingFarmer() async {
    farmerLoading.value = true;
    _matchingApi.matchingFarmerData(
      {
        "Authorization": 'Bearer ${await _prefs.getUserAccessToken()}',
        "Content-Type": "application/json"
      },
      landId.value,
    ).then((value) {
      farmerLoading.value = false;
      setRxRequestData(value);
    }).onError((error, stackTrace) {});
  }
}
