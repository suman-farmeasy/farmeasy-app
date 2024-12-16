import 'package:farm_easy/Screens/UserProfile/Model/UserDetailsResponseModel.dart';
import 'package:farm_easy/Screens/UserProfile/ViewModel/user_profile_view_model.dart';
import 'package:farm_easy/API/Services/network/status.dart';
import 'package:farm_easy/utils/SharedPreferences/shared_preferences.dart';
import 'package:get/get.dart';

class UserProfileController extends GetxController {
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
  }

  final _api = UserProfileDetailsViewModel();
  final userData = UserDetailsResponseModel().obs;

  final loading = false.obs;
  final rxRequestStatus = Status.LOADING.obs;
  RxString userType = "".obs;
  final _prefs = AppPreferences();
  RxInt userId = 0.obs;
  void setRxRequestStatus(Status _value) => rxRequestStatus.value = _value;
  void setRxRequestData(UserDetailsResponseModel _value) =>
      userData.value = _value;
  Future<void> userDetails(int userId, String userType) async {
    loading.value = true;
    _api.usrDetails({
      "Authorization": 'Bearer ${await _prefs.getUserAccessToken()}',
      "Content-Type": "application/json"
    }, userId, userType).then((value) {
      setRxRequestData(value);
      loading.value = false;
    }).onError((error, stackTrace) {
      loading.value = false;
      print(error);
      print(stackTrace);
    });
  }
}
