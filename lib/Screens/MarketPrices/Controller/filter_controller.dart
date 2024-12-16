import 'package:farm_easy/Screens/MarketPrices/Model/search_comodity_response_model.dart';
import 'package:farm_easy/Screens/MarketPrices/ViewModel/view_model.dart';
import 'package:farm_easy/Services/network/status.dart';
import 'package:farm_easy/SharedPreferences/shared_preferences.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class FilterController extends GetxController {
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    getCropList("");
  }

  final cropController = TextEditingController().obs;
  final prefs = AppPreferences();
  final _api = SearchComodityListViewModel();
  final cropData = SearchComodityResponseModel().obs;
  final loading = false.obs;
  final rxRequestStatus = Status.LOADING.obs;
  RxString crop = "".obs;
  RxInt cropId = 0.obs;
  void setRxRequestStatus(Status value) => rxRequestStatus.value = value;
  void setRxRequestData(SearchComodityResponseModel value) =>
      cropData.value = value;
  Future<void> getCropList(String crop) async {
    loading.value = true;
    _api.cropListData(crop).then((value) {
      loading.value = false;

      setRxRequestData(value);
    }).onError((error, stackTrace) {
      loading.value = false;
      print(error);
      print(stackTrace);
    });
  }
}
