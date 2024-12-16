import 'package:farm_easy/Screens/HomeScreen/Model/recommended_landowners.dart';
import 'package:farm_easy/Screens/HomeScreen/ViewModel/land_list_viewmodel.dart';
import 'package:farm_easy/API/Services/network/status.dart';
import 'package:farm_easy/utils/SharedPreferences/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

class RecommendedLandownersController extends GetxController {
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    recommendedLandonwers(100);
    print("LANDONWERS");
  }

  RxInt currentPage = 1.obs;
  RxInt totalPages = 0.obs;
  RxList<Data> landOwnerData = <Data>[].obs;
  final prefs = AppPreferences();
  final _api = ListRecommendedLandownersViewModel();
  final farmer = RecommendedLandownersResponseModel().obs;
  var currentDistance = 100.obs; // Initial distance

// Update distance based on slider value
  void updateDistance(double value) {
    currentDistance.value = value.toInt();
  }

  final loading = false.obs;
  final rxRequestStatus = Status.LOADING.obs;
  final searchController = TextEditingController();
  RxString searchFarmerName = "".obs;

  void setRxRequestStatus(Status _value) => rxRequestStatus.value = _value;
  void setRxRequestData(RecommendedLandownersResponseModel _value) =>
      farmer.value = _value;

  Future<void> recommendedLandonwers(int distance) async {
    loading.value = true;
    rxRequestStatus.value = Status.LOADING;

    _api.recommendedLandonwers({
      "Authorization": 'Bearer ${await prefs.getUserAccessToken()}',
      "Content-Type": "application/json"
    }, currentPage.value, searchFarmerName.value, distance).then((value) {
      setRxRequestData(value);
      setRxRequestStatus(Status.SUCCESS);
      // if (farmer.value.result?.data != null) {
      //   totalPages.value = farmer.value.result!!.totalPage!.toInt();
      //   landData.addAll(landlist.value.result!.data!);
      // }
      loading.value = false;
    }).onError((error, stackTrace) {
      Status.ERROR;
      loading.value = false;
      print("=================================================${error}");
      print("=================================================${stackTrace}");
    });
  }

  void loadMoreData(int distance) {
    if (currentPage.value < totalPages.value) {
      currentPage.value++;
      recommendedLandonwers(distance);
    } else {
      print('Already on the last page');
    }
  }

  // Future<void> refreshAllFarmerData() async {
  //   currentPage.value = 1;
  //   farmerData.clear();
  //   await farmerList();
  // }
}
