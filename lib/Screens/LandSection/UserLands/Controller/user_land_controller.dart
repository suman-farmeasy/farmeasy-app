import 'package:farm_easy/Screens/Directory/Model/AllLandResponseModel.dart';
import 'package:farm_easy/Screens/LandSection/UserLands/ViewModel/user_land_view_model.dart';
import 'package:farm_easy/API/Services/network/status.dart';
import 'package:farm_easy/utils/SharedPreferences/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

class UserLandsController extends GetxController {
  RxInt currentPage = 1.obs;
  RxInt totalPages = 0.obs;

  final prefs = AppPreferences();
  final _api = UserLandListViewModel();
  final landlist = AllLandResponseModel().obs;
  RxList<Data> landData = <Data>[].obs;
  final loading = false.obs;
  final rxRequestStatus = Status.LOADING.obs;
  void setRxRequestStatus(Status _value) => rxRequestStatus.value = _value;
  void setRxRequestData(AllLandResponseModel _value) => landlist.value = _value;
  RxString searchlands = "".obs;
  final searchController = TextEditingController();
  void searchLandsData(String query, int userId) {
    landData.clear();
    searchlands.value = query;
    allLandList(userId);
  }

  void clearSearch(int userId) {
    searchController.clear();
    searchLandsData("", userId);
  }

  Future allLandList(int userId) async {
    loading.value = true;
    Status.LOADING;
    _api.listlands(
      userId,
      currentPage.value,
      searchlands.value,
      {
        "Authorization": 'Bearer ${await prefs.getUserAccessToken()}',
        "Content-Type": "application/json"
      },
    ).then((value) {
      loading.value = false;
      setRxRequestData(value);
      setRxRequestStatus(Status.SUCCESS);
      if (landlist.value.result?.data != null) {
        totalPages.value = landlist.value.result!.pageInfo!.totalPage!.toInt();
        landData.addAll(landlist.value.result!.data!);
      }
    }).onError((error, stackTrace) {
      loading.value = false;
      Status.ERROR;
      print("=====================================${error}");
      print("=====================================${stackTrace}");
    });
  }

  void loadMoreData(int userId) {
    if (currentPage.value < totalPages.value) {
      currentPage.value++;
      allLandList(userId);
    } else {
      print('Already on the last page');
    }
  }

  Future<void> refreshAllLandData(int userId) async {
    currentPage.value = 1;
    landData.clear();
    await allLandList(userId);
  }
}
