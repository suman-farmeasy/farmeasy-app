
import 'package:farm_easy/Screens/HomeScreen/Model/FarmerListResponseModel.dart';
import 'package:farm_easy/Screens/HomeScreen/ViewModel/land_list_viewmodel.dart';
import 'package:farm_easy/Services/network/status.dart';
import 'package:farm_easy/SharedPreferences/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ListFarmerController extends GetxController{

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    farmerList();
  }


  RxInt currentPage= 1.obs;
  RxInt totalPages= 0.obs;
  RxList farmerData= [].obs;
  final prefs = AppPreferences();
  final _api= ListFarmerViewModel();
  final farmer= FarmerListResponseModel().obs;

  final loading= false.obs;
  final rxRequestStatus = Status.LOADING.obs;
  final searchController = TextEditingController();
  RxString searchFarmerName="".obs;
  void searchFarmer(String query) {
    farmerData.clear();
    searchFarmerName.value = query;
    farmerList();
  }
  void clearSearch() {
    searchController.clear();
    searchFarmer("");
  }
  void setRxRequestStatus(Status _value)=>rxRequestStatus.value=_value;
  void setRxRequestData(FarmerListResponseModel _value)=>farmer.value=_value;
  Future<void> farmerList() async {
    loading.value=true;
    rxRequestStatus.value = Status.LOADING;
    _api.farmer(
      {"Authorization":'Bearer ${ await prefs.getUserAccessToken()}',"Content-Type": "application/json"},
      currentPage.value,
      searchFarmerName.value,
    ).then((value) {
      setRxRequestData(value);
      setRxRequestStatus(Status.SUCCESS);
      loading.value=false;
      if (farmer.value.result?.data != null) {
        totalPages.value = farmer.value.result!.pageInfo!.totalPage!.toInt();
        farmerData.addAll(farmer.value.result!.data!);
      }}).onError((error, stackTrace){
      Status.ERROR;
      loading.value=false;
      print("=================================================${error}");
      print("=================================================${stackTrace}");
    });
  }

  void loadMoreData() {
    if (currentPage.value < totalPages.value) {
      currentPage.value++;
      farmerList();
    } else {

      print('Already on the last page');
    }
  }
  Future<void> refreshAllFarmerData() async {
    currentPage.value = 1;
    farmerData.clear();
    await farmerList();
  }
}
