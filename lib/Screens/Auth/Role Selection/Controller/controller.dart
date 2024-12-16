import 'package:farm_easy/Screens/Auth/Role%20Selection/Model/UserTypeResponseModel.dart';
import 'package:farm_easy/Screens/Auth/Role%20Selection/ViewModel/user_type_view_model.dart';
import 'package:farm_easy/Screens/Auth/UserResgister/View/user_registration.dart';

import 'package:farm_easy/API/Services/network/status.dart';
import 'package:farm_easy/Utils/SharedPreferences/shared_preferences.dart';
import 'package:get/get.dart';

class RoleSelectionController extends GetxController {
  RxList title = [
    'I’m a land-owner',
    'I’m a farmer',
    'I’m a Partner',
  ].obs;
  RxList subtitle = [
    'I have a land, and looking for farmer to cultivate my land.',
    'I’m a farmer and looking for a job.',
    'I can contribute to farmer or landowner as service or machinery provider',
  ].obs;
  RxList img = [
    'assets/img/landowner.svg',
    'assets/img/farmer.svg',
    'assets/img/agriprovider.svg',
  ].obs;
  RxList selection = [
    'Land Owner',
    'Farmer',
    'Agri Service Provider',
  ].obs;
  String userSelection = '';
  final _api = UserTypeViewModel();
  final userData = UserTypeResponseModel().obs;
  final loading = false.obs;
  final rxRequestStatus = Status.LOADING.obs;
  void setRequestStatus(Status _value) => rxRequestStatus.value = _value;
  void setAuthData(UserTypeResponseModel _value) => userData.value = _value;
  final AppPreferences _prefs = AppPreferences();

  Future userType() async {
    loading.value = true;
    _api.userData({
      "user_type": "${userSelection}",
    }, {
      "Authorization": 'Bearer ${await _prefs.getUserAccessToken()}',
    }).then((value) async {
      loading.value = false;
      if (await _prefs.getUserRefreshToken() != "") {
        _prefs.setUserRole(userSelection.toString() ?? "");

        Get.to(() => UserRegistration(userType: '${userSelection.toString()}'));
      }

      print(
          "==============================================={$userSelection}==================================================");
      // _prefs.setUserType(value.)
    }).onError((error, stackTrace) {
      print(error);
      print(stackTrace);
    });
  }
}
