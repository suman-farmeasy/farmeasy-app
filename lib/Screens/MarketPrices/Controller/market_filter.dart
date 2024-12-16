import 'package:farm_easy/Screens/MarketPrices/Model/market_List_model.dart';
import 'package:farm_easy/Screens/MarketPrices/ViewModel/view_model.dart';
import 'package:farm_easy/Services/network/status.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MarketFilterController extends GetxController {
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    getStateList();
  }

  final textController = TextEditingController().obs;
  final _api = MarketListViewModel();
  final loading = false.obs;
  RxString market = "".obs;
  RxInt marketId = 0.obs;
  final rxRequestStatus = Status.LOADING.obs;
  final stateData = MarketResponseModel().obs;
  void setRxRequestStatus(Status _value) => rxRequestStatus.value = _value;
  void setRxRequestData(MarketResponseModel _value) => stateData.value = _value;
  Future<void> getStateList() async {
    _api
        .marketListData(
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
