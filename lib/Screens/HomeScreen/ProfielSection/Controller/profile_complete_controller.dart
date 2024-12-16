import 'package:farm_easy/Screens/HomeScreen/ProfielSection/Model/ProfilePercentageResponseModel.dart';
import 'package:farm_easy/Screens/HomeScreen/ProfielSection/ViewModel/prfile_complete_view_model.dart';
import 'package:farm_easy/Services/network/status.dart';
import 'package:farm_easy/SharedPreferences/shared_preferences.dart';
import 'package:get/get.dart';

class ProfilePercentageController extends GetxController{

@override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    profilePercentage();
  }

  final _api = ProfileCompleteViewModel();
  final profileData = ProfilePercentageResponseModel().obs;
  final loading = false.obs;
  final rxRequestStatus= Status.LOADING.obs;
  void setRxRequestStatus(Status _value)=>rxRequestStatus.value=_value;
  void setRxRequestData(ProfilePercentageResponseModel _value)=>profileData.value=_value;
  final _prefs = AppPreferences();


  Future<void> profilePercentage() async {
    loading.value= true;
    _api.profilePercentage(  {"Authorization":'Bearer ${ await _prefs.getUserAccessToken()}',"Content-Type": "application/json"}
    ).then((value) {
      loading.value= false;
      setRxRequestData(value);

    }).onError((error, stackTrace) {
      loading.value= false;
      print(error);
      print(stackTrace);

    });

  }

}