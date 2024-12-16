
import 'package:farm_easy/Screens/LandSection/LandDetails/Enquiries/Model/EnquiriesListResponseModel.dart';
import 'package:farm_easy/Screens/LandSection/LandDetails/Enquiries/ViewModel/enquiries_view_model.dart';
import 'package:farm_easy/Services/network/status.dart';
import 'package:farm_easy/SharedPreferences/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EnquiriesController extends GetxController{

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    enquiriesListData();
    scrollController = ScrollController();
    scrollController.addListener(_scrollListener);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    scrollController.removeListener(_scrollListener);
    scrollController.dispose();
    super.dispose();
  }

  void _scrollListener() {
    if (scrollController.position.pixels == scrollController.position.maxScrollExtent) {
      _loadMoreData();
    }
  }

  void _loadMoreData() {
    if (!loading.value && currentPage.value < enquiriesData.value.result!.pageInfo!.totalPage!.toInt()) {
      currentPage.value++;
      enquiriesListData();
    }
  }

  ScrollController scrollController = ScrollController();
  RxInt landId= 0.obs;
  final loading = false.obs;
  final _api = EnquiriesViewModel();
  final enquiriesData = EnquiriesListResponseModel().obs;
  final rxRequestStatus = Status.LOADING.obs;

  RxInt currentPage = 1.obs;
  void setRxRequestStatus(Status _value)=>rxRequestStatus.value=_value;
  void setRxRequestData(EnquiriesListResponseModel _value) {
    if (currentPage.value == 1) {
      enquiriesData.value = _value;
    } else {
      enquiriesData.value.result?.data?.addAll(_value.result?.data ?? []);
    }
  }

  final _prefs = AppPreferences();
  Future <void> enquiriesListData() async {
    loading.value= true;
    _api.enquiriesList(
        {"Authorization":'Bearer ${ await _prefs.getUserAccessToken()}',"Content-Type": "application/json"}
        , landId.value,
        currentPage.value
    ).then((value) {
      loading.value=false;
      setRxRequestData(value);

    }).onError((error, stackTrace) {});
  }
}