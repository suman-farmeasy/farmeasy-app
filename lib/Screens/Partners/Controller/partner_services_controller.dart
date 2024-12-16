import 'package:farm_easy/Screens/Partners/Model/nearby_partner_view_mdoel.dart';
import 'package:farm_easy/Screens/Partners/Model/services_model.dart';
import 'package:farm_easy/Screens/Partners/ViewModel/view_model.dart';
import 'package:farm_easy/Utils/SharedPreferences/shared_preferences.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

import '../../../API/Services/network/status.dart';

class PartnerServicesController extends GetxController {
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    services();
  }

  final prefs = AppPreferences();
  final _api = PartnerServicesViewModel();
  final servicesData = ListPartnerServices().obs;
  RxList agriItems = [].obs;
  final loading = false.obs;
  RxInt selectedIndex = 0.obs;
  void selectItem(int index) {
    selectedIndex.value = index;
  }

  final refreshloading = false.obs;
  final rxRequestStatus = Status.LOADING.obs;
  void setRxRequestStatus(Status _value) => rxRequestStatus.value = _value;
  void setRxRequestData(ListPartnerServices _value) =>
      servicesData.value = _value;

  Future<void> services() async {
    loading.value = true;
    _api.partnerServices({
      "Authorization": 'Bearer ${await prefs.getUserAccessToken()}',
      "Content-Type": "application/json"
    }).then((value) {
      loading.value = false;
      setRxRequestData(value);
      setRxRequestStatus(Status.SUCCESS);
      // if (landData.value.result?.data != null) {
      //   totalPages.value = landData.value.result!.pageInfo!.totalPage!.toInt();
      //   alllandListData.addAll(landData.value.result!.data!);
      // }
    }).onError((error, stackTrace) {
      loading.value = false;
      print(error);
      print(stackTrace);
    });
  }

  ///Near by

  final _apiNearby = NearbyPartnerServicesViewModel();
  final nearbyPartner = NearbyPartnersResponseModel().obs;
  final nearbyLoading = false.obs;
  final searchKeyword = TextEditingController().obs;
  final rxRequestStatusNearby = Status.LOADING.obs;
  void setRxRequestStatusNearby(Status _value) =>
      rxRequestStatus.value = _value;
  void setRxRequestDataNearby(NearbyPartnersResponseModel _value) =>
      nearbyPartner.value = _value;
  Future<void> nearbyPartnerServices(int index) async {
    nearbyLoading.value = true;
    _apiNearby.nearbyPartner(
      {
        "Authorization": 'Bearer ${await prefs.getUserAccessToken()}',
        "Content-Type": "application/json"
      },
      index,
      searchKeyword.value.text,
    ).then((value) {
      nearbyLoading.value = false;
      setRxRequestDataNearby(value);
      // if (landData.value.result?.data != null) {
      //   totalPages.value = landData.value.result!.pageInfo!.totalPage!.toInt();
      //   alllandListData.addAll(landData.value.result!.data!);
      // }
    }).onError((error, stackTrace) {
      nearbyLoading.value = false;
      print(error);
      print(stackTrace);
    });
  }
}
