import 'package:farm_easy/Screens/Directory/Model/AllLandResponseModel.dart';
import 'package:farm_easy/Screens/Directory/ViewModel/directory_view_model.dart';
import 'package:farm_easy/API/Services/network/status.dart';
import 'package:farm_easy/utils/SharedPreferences/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ListAllLandsController extends GetxController {
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    allLandList();
  }

  RxInt currentPage = 1.obs;
  RxInt totalPages = 0.obs;

  final prefs = AppPreferences();
  final _api = ListAllLandViewModel();
  final landlist = AllLandResponseModel().obs;
  RxList<Data> landData = <Data>[].obs;
  final loading = false.obs;
  final rxRequestStatus = Status.LOADING.obs;
  void setRxRequestStatus(Status _value) => rxRequestStatus.value = _value;
  void setRxRequestData(AllLandResponseModel _value) => landlist.value = _value;
  RxString searchlands = "".obs;
  final searchController = TextEditingController();
  void searchLandsData(String query) {
    landData.clear();
    searchlands.value = query;
    allLandList();
  }

  void clearSearch() {
    searchController.clear();
    searchLandsData("");
  }

  Future allLandList({bool isPagination = false}) async {
    loading.value = true;
    if (isPagination) {
      landData.clear();
    }
    Status.LOADING;
    _api.listlands(
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

  void loadMoreData() {
    if (currentPage.value < totalPages.value) {
      currentPage.value++;
      allLandList();
    } else {
      print('Already on the last page');
    }
  }

  Future<void> refreshAllLandData() async {
    currentPage.value = 1;
    landData.clear();
    await allLandList();
  }
}
