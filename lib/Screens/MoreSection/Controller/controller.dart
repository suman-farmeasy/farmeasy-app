import 'package:farm_easy/Screens/MoreSection/Model/delete_account_response_model.dart';
import 'package:farm_easy/Screens/MoreSection/ViewModel/view_model.dart';
import 'package:farm_easy/API/Services/network/status.dart';
import 'package:farm_easy/utils/SharedPreferences/shared_preferences.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:get/get.dart';

class MoreController extends GetxController {
  final prefs = AppPreferences();

  final _api = DeleteAccountViewModel();
  final deleteAccountData = DeleateAccountResponseModel().obs;
  final loading = false.obs;

  RxInt userId = 0.obs;
  final rxRequestStatus = Status.LOADING.obs;

  void setRxRequestStatus(Status _value) => rxRequestStatus.value = _value;
  void setRxRequestData(DeleateAccountResponseModel _value) =>
      deleteAccountData.value = _value;

  Future<void> deleteAccount() async {
    loading.value = true;
    _api.deleteAccount(
      {
        "Authorization": 'Bearer ${await prefs.getUserAccessToken()}',
        "Content-Type": "application/json"
      },
    ).then((value) {
      loading.value = false;
      setRxRequestData(value);
      prefs.deleteData();
      clearCache();
    }).onError((error, stackTrace) {
      loading.value = false;
      print(error);
      print(stackTrace);
    });
  }

  Future<void> clearCache() async {
    await DefaultCacheManager().emptyCache();
  }
}
