
import 'package:farm_easy/Screens/LandSection/MatchingFarmer/Model/MatchingFarmerResponseModel.dart';
import 'package:farm_easy/Screens/LandSection/MatchingFarmer/ViewModel/matching_farmer_view_model.dart';
import 'package:farm_easy/Services/network/status.dart';
import 'package:farm_easy/SharedPreferences/shared_preferences.dart';
import 'package:get/get.dart';

class HomeScreenMatchingFarmerController extends GetxController {
  final MatchingFarmerViewModel _matchingApi = MatchingFarmerViewModel();
  final Rx<MatchingFarmerResponseModel> matchingFarmerData = MatchingFarmerResponseModel().obs;
  final RxBool farmerLoading = false.obs;
  final Rx<Status> rxRequestStatus = Status.LOADING.obs;
  final AppPreferences _prefs = AppPreferences();
  final int landId;

  HomeScreenMatchingFarmerController(this.landId);

  @override
  void onInit() {
    super.onInit();
    matchingFarmer(landId);
  }

  void setRxRequestValue(Status value) => rxRequestStatus.value = value;
  void setRxRequestData(MatchingFarmerResponseModel value) => matchingFarmerData.value = value;

  Future<void> matchingFarmer(int landId) async {
    farmerLoading.value = true;
    _matchingApi.matchingFarmerData({
      "Authorization": 'Bearer ${await _prefs.getUserAccessToken()}',
      "Content-Type": "application/json"
    }, landId).then((value) {
      farmerLoading.value = false;
      setRxRequestData(value);
    }).onError((error, stackTrace) {
      farmerLoading.value = false;
      // Handle error
    });
  }
}


