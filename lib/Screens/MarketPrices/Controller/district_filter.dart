import 'package:farm_easy/Screens/MarketPrices/Controller/state_filter.dart';
import 'package:farm_easy/Screens/MarketPrices/Model/market_List_model.dart';
import 'package:farm_easy/Screens/MarketPrices/ViewModel/view_model.dart';
import 'package:farm_easy/Services/network/status.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DistrictFilterController extends GetxController {
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    getStateList(
      stateController.state.value,
    );
  }

  final stateController = Get.put(StateFilterController());
  final textController = TextEditingController().obs;
  final _api = DistrictListViewModel();
  final loading = false.obs;
  RxString district = "".obs;
  RxInt districtId = 0.obs;
  final rxRequestStatus = Status.LOADING.obs;
  final stateData = MarketResponseModel().obs;
  void setRxRequestStatus(Status _value) => rxRequestStatus.value = _value;
  void setRxRequestData(MarketResponseModel _value) => stateData.value = _value;
  Future<void> getStateList(String state) async {
    _api
        .marketListData(
      stateController.state.value,
      textController.value.text,
    )
        .then((value) {
      loading.value = false;
      setRxRequestData(value);
      setRxRequestStatus(Status.SUCCESS);
    }).onError((error, stackTrace) {
      print(error);
      print(stackTrace);
    });
  }
}
