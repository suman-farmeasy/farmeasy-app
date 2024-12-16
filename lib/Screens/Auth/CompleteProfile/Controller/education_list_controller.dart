

import 'package:country_picker/country_picker.dart';
import 'package:farm_easy/Screens/Auth/CompleteProfile/Model/EducationListResponseModel.dart';
import 'package:farm_easy/Screens/Auth/CompleteProfile/Model/GetProfileResponseModel.dart';
import 'package:farm_easy/Screens/Auth/CompleteProfile/VIewModel/complete_profile_view_model.dart';
import 'package:farm_easy/Services/network/status.dart';
import 'package:farm_easy/SharedPreferences/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EducationListController extends GetxController{

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    getEducationList();
  }
  final textController = TextEditingController().obs;
  final _api =  EducationListViewModel();
  final loading = false.obs;
  RxString education= "".obs;
  RxInt educationId= 0.obs;
  final rxRequestStatus= Status.LOADING.obs;
  final educationData= EducationListResponseModel().obs;
  void setRxRequestStatus(Status _value)=> rxRequestStatus.value=_value;
  void setRxRequestData(EducationListResponseModel _value)=>educationData.value=_value;
  Future<void> getEducationList() async {
    _api.getEducationData(
      textController.value.text,
    ).then((value) {
      loading.value=false;
      setRxRequestData(value);
      setRxRequestStatus(Status.SUCCESS);
    }).onError((error, stackTrace) {
      print(error);
      print(stackTrace);
    });
  }
}