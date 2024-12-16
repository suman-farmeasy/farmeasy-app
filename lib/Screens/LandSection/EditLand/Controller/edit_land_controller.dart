import 'package:farm_easy/Screens/LandSection/LandAdd/Model/CropResponseModel.dart';
import 'package:farm_easy/Screens/LandSection/LandAdd/Model/LandPurposeResponse.dart';
import 'package:farm_easy/Screens/LandSection/LandAdd/ViewModel/land_view_model.dart';
import 'package:farm_easy/Services/network/status.dart';
import 'package:farm_easy/SharedPreferences/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EditLandController extends GetxController {
  RxBool landSizeValue = true.obs;
  RxBool landleaseValue = true.obs;
  RxBool landleaseAmountvalue = true.obs;
  RxBool isLandAdded = true.obs;
  RxBool isLandleaseAdded = true.obs;
  RxBool islandleaseAmountvalue = true.obs;
  RxBool landtitleValue = true.obs;
  RxBool isTitleAdded = true.obs;
  RxString landArea = "".obs;
  RxBool isleaseAvailable = true.obs;
  final isleaseAmount = TextEditingController().obs;
  RxString leaseDUration = "".obs;
  RxString leaseAmount = "".obs;
  RxString lease_type = "".obs;
  RxString landTitle = "".obs;
  RxString landUnit = "".obs;
  final landSize = TextEditingController().obs;
  final landlease = TextEditingController().obs;
  final landTitleController = TextEditingController().obs;
  void addLand() {
    isLandAdded.value = true;
    landArea.value = "${landSize.value.text} ${selectedUnit.value}";
  }

  void addLease() {
    isLandleaseAdded.value = true;
    leaseDUration.value = "${landlease.value.text} ${selectedleaseUinit.value}";
  }

  void addAmount() {
    islandleaseAmountvalue.value = true;
    leaseAmount.value = " ${amount.value}  ${isleaseAmount.value.text}";
  }

  void addTitle() {
    isTitleAdded.value = true;
    landTitle.value = "${landTitleController.value.text}";
  }

  void landValue() {
    landSizeValue.value = true;
  }

  void leaseValue() {
    landleaseValue.value = true;
  }

  void leaseAmountValue() {
    landleaseAmountvalue.value = true;
  }

  void landTitleValue() {
    landtitleValue.value = true;
  }

  RxString selectedUnit = "Select Type".obs;
  RxString selectedleaseUinit = "Months".obs;

  RxList<String> units = [
    "Select Type",
    "Acres",
    "Square Meters",
    "Square Feets",
    "Hectare",
    "Bigha"
  ].obs;
  RxList<String> leaseunits = ["Months", "Years"].obs;
  RxString amount = "Select Type".obs;
  RxList<String> amountType = ["Select Type", '\$', "₹"].obs;

  void updateSelectedUnit(String unit) {
    selectedUnit.value = unit;
  }

  void updateSelectedleaseUnit(String unit) {
    selectedleaseUinit.value = unit;
  }

  void updateSelectedamount(String unit) {
    amount.value = unit;
  }

  /// FOR PURPOSE
  RxBool isPurposeAdded = true.obs;
  RxBool addPurpose = true.obs;
  RxInt selectedPurposeid = 0.obs;
  RxString selectedPurposeName = ''.obs;
  final _puporseApi = PurposeViewModel();
  final purposeData = LandPurposeResponse().obs;
  final rxPurposeRequestStatus = Status.LOADING.obs;
  void setPurposeRequest(Status _value) =>
      rxPurposeRequestStatus.value = _value;
  void setPurposeData(LandPurposeResponse _value) => purposeData.value = _value;

  RxBool purposeLoading = false.obs;
  void purposeFunc() {
    purposeLoading.value = true;
    _puporseApi.purposeData().then((value) {
      if (value != null && value.result != null && value.result!.isNotEmpty) {
        setPurposeData(value);
        setPurposeRequest(Status.SUCCESS);
      }
    }).onError((error, stackTrace) {
      print(error);
      print(stackTrace);
    });
  }

  RxInt current = (-1).obs;

  void purposeAdded() {
    isPurposeAdded.value = true;
    selectedPurposeid.value;
  }

  void addPurposeValue() {
    addPurpose.value = true;
  }

  /// FOR CROP
  final _prefs = AppPreferences();
  RxBool iscropAdded = true.obs;
  RxBool isCropValue = true.obs;
  final _cropApi = GetCroupViewModel();
  final cropResponseData = CropResponseModel().obs;
  final cropDataloading = false.obs;
  final rxCroprequestStatus = Status.LOADING.obs;
  void setCropRequest(Status _value) => rxCroprequestStatus.value = _value;
  void setCropData(CropResponseModel _value) => cropResponseData.value = _value;
  Future<void> cropData(int landId) async {
    cropDataloading.value = true;
    _cropApi.cropData(landId, {
      "Authorization": 'Bearer ${await _prefs.getUserAccessToken()}',
      "Content-Type": "application/json"
    }).then((value) {
      if (value != null && value.result != null && value.result!.isNotEmpty) {
        setCropData(value);
        setCropRequest(Status.SUCCESS);
      }
    }).onError((error, stackTrace) {
      print(error);
      print(stackTrace);
    });
  }

  void addselectCrop() {
    isCropValue.value = true;
    Get.back();
  }

  void addselectCropfromContainer() {
    isCropValue.value = true;
  }

  void cropAdd() {
    iscropAdded.value = true;
  }

  RxList<int> cropAdded = <int>[].obs;
  RxList<String> cropAddedName = <String>[].obs;
  RxList otherCropAdded = [].obs;
  RxList otherCropAddedName = [].obs;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    purposeFunc();
  }
}
