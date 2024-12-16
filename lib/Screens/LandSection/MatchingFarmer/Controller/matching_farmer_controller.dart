import 'package:farm_easy/Screens/LandSection/MatchingFarmer/Model/MatchingFarmerResponseModel.dart';
import 'package:farm_easy/Screens/LandSection/MatchingFarmer/ViewModel/matching_farmer_view_model.dart';
import 'package:farm_easy/Services/network/status.dart';
import 'package:farm_easy/SharedPreferences/shared_preferences.dart';
import 'package:get/get.dart';

class MatchingFarmerController extends GetxController {
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    matchingFarmer(100);
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

  final _matchingApi = MatchingFarmerViewModel();
  final matchingFarmerData = MatchingFarmerResponseModel().obs;
  RxInt landId = 0.obs;
  final farmerLoading = false.obs;
  final rxRequestStatus = Status.LOADING.obs;
  final _prefs = AppPreferences();
  void setRxRequsetValue(Status _value) => rxRequestStatus.value = _value;
  void setRxRequestData(MatchingFarmerResponseModel _value) =>
      matchingFarmerData.value = _value;
  Future matchingFarmer(int distance) async {
    farmerLoading.value = true;
    _matchingApi.matchingFarmerData({
      "Authorization": 'Bearer ${await _prefs.getUserAccessToken()}',
      "Content-Type": "application/json"
    }, landId.value, distance).then((value) {
      farmerLoading.value = false;
      setRxRequestData(value);
    }).onError((error, stackTrace) {});
  }
}
