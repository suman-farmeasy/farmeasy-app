import 'package:farm_easy/Screens/Directory/Model/ListLandOwnerResponseModel.dart';
import 'package:farm_easy/Screens/Directory/ViewModel/directory_view_model.dart';
import 'package:farm_easy/API/Services/network/status.dart';
import 'package:farm_easy/utils/SharedPreferences/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ListLandOwnerController extends GetxController {
  final searchController = TextEditingController();
  final _api = ListLandOwnerViewModel();
  final prefs = AppPreferences();
  final landowner = ListLandOwnerResponseModel().obs;
  RxString searchLandowner = "".obs;
  RxList<Data> landOwnerData = <Data>[].obs;
  RxBool loading = false.obs;
  Rx<Status> rxRequestStatus = Status.LOADING.obs;
  RxInt currentPage = 1.obs;
  RxInt totalPages = 0.obs;
  RxString userRole = "".obs;
  void setRxRequestData(ListLandOwnerResponseModel _value) =>
      landowner.value = _value;
  void setRxRequestStatus(Status _value) => rxRequestStatus.value = _value;
  @override
  void onInit() async {
    super.onInit();
    landOwnerList();
    userRole.value = await prefs.getUserRole();
    print(
        "==================================================${userRole.value}");
  }

  void searchLandOwner(String query) {
    landOwnerData.clear();
    searchLandowner.value = query;
    landOwnerList();
  }

  void clearSearch() {
    searchController.clear();
    searchLandOwner("");
  }

  Future<void> landOwnerList({bool isPagination = false}) async {
    if (isPagination) {
      landOwnerData.clear();
    }
    loading.value = true;
    rxRequestStatus.value = Status.LOADING;

    _api.listLandOwner(currentPage.value, searchLandowner.value, {
      "Authorization": 'Bearer ${await prefs.getUserAccessToken()}',
      "Content-Type": "application/json"
    }).then((value) {
      setRxRequestData(value);
      setRxRequestStatus(Status.SUCCESS);
      loading.value = false;
      if (landowner.value.result!.data != null) {
        totalPages.value = landowner.value.result!.pageInfo!.totalPage!.toInt();
        landOwnerData.addAll(landowner.value.result!.data!);
      }
    }).onError((error, stackTrace) {
      loading.value = false;
      setRxRequestStatus(Status.ERROR);
    });
  }

  void loadMoreData() {
    if (currentPage.value < totalPages.value) {
      currentPage.value++;
      landOwnerList();
    } else {
      print('Already on the last page');
    }
  }

  Future<void> refreshAlllandownerdata() async {
    currentPage.value = 1;
    landOwnerData.clear();
    await landOwnerList();
  }
}
