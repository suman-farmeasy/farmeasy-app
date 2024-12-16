import 'dart:convert';

import 'package:farm_easy/Constants/custom_snackbar.dart';
import 'package:farm_easy/Screens/LandSection/LandAdd/Controller/map_controller.dart';
import 'package:farm_easy/Screens/LandSection/LandAdd/Model/AddLandResponseModel.dart';
import 'package:farm_easy/Screens/LandSection/LandAdd/Model/CropResponseModel.dart';
import 'package:farm_easy/Screens/LandSection/LandAdd/Model/LandPurposeResponse.dart';
import 'package:farm_easy/Screens/LandSection/LandAdd/ViewModel/land_view_model.dart';
import 'package:farm_easy/Screens/LandSection/LandDetails/View/land_details.dart';
import 'package:farm_easy/Services/network/status.dart';
import 'package:farm_easy/SharedPreferences/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

class LandController extends GetxController {
  final mapController = Get.put(MapController());

  @override
  void onInit() {
    // TODO: implement onInit

    super.onInit();
    purposeFunc();
    cropData();

    ever(latiTude, (_) => validateFields());
    ever(longiTude, (_) => validateFields());
    ever(landArea, (_) => validateFields());
    ever(selectedPurposeid, (_) => validateFields());
    ever(cropAdded, (_) => validateFields());
    ever(otherCropAddedName, (_) => validateFields());

    addressLine.value.addListener(() => validateFields());
    city.value.addListener(() => validateFields());
    state.value.addListener(() => validateFields());
    county.value.addListener(() => validateFields());
    landTitleController.value.addListener(() => validateFields());
  }

  RxBool useNeverScrollPhysics = true.obs;

  ///FOR ADDRESS
  final addressLine = TextEditingController().obs;
  final city = TextEditingController().obs;
  final state = TextEditingController().obs;
  final county = TextEditingController().obs;
  RxString latiTude = "".obs;
  RxString longiTude = "".obs;

  //RxBool isAllAddresscontentfill = false.obs;

  void addresstostMsg() {
    Fluttertoast.showToast(
        msg: "Please fill the details",
        backgroundColor: Colors.grey.shade300,
        timeInSecForIosWeb: 1,
        textColor: Colors.black45,
        fontSize: 16.0);
  }

  RxString displayedAddress = "".obs;
  RxBool isAdded = false.obs;
  RxBool isaddressAdded = false.obs;
  void addAddress() {
    isaddressAdded.value = true;
    displayedAddress.value =
        "${addressLine.value.text}, ${city.value.text}, ${state.value.text}, ${county.value.text}";
  }

  void add() {
    isAdded.value = true;
  }

  ///FOR_ LAND_INFORMATION

  RxBool landSizeValue = false.obs;
  RxBool landleaseValue = false.obs;
  RxBool landleaseAmountvalue = false.obs;
  RxBool isLandAdded = false.obs;
  RxBool isLandleaseAdded = false.obs;
  RxBool islandleaseAmountvalue = false.obs;
  RxBool landtitleValue = false.obs;
  RxBool isTitleAdded = false.obs;
  RxString landArea = "".obs;
  final RxBool isleaseAvailable = true.obs;
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
    leaseAmount..value = " ${amount.value}  ${isleaseAmount.value.text}";
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

  RxString selectedUnit = "Acres".obs;
  RxString selectedleaseUinit = "Months".obs;
  RxString amount = "Select Type".obs;

  RxList<String> units =
      ["Acres", "Square Meters", "Square Feets", "Hectare", "Bigha"].obs;
  RxList<String> leaseunits = ["Months", "Years"].obs;
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
  RxBool isPurposeAdded = false.obs;
  RxBool addPurpose = false.obs;
  RxString selectedPurposeid = ''.obs;
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

  RxBool iscropAdded = false.obs;
  RxBool isCropValue = false.obs;
  final _cropApi = CroupViewModel();
  final cropResponseData = CropResponseModel().obs;
  final cropDataloading = false.obs;
  final rxCroprequestStatus = Status.LOADING.obs;
  void setCropRequest(Status _value) => rxCroprequestStatus.value = _value;
  void setCropData(CropResponseModel _value) => cropResponseData.value = _value;
  void cropData() {
    cropDataloading.value = true;
    _cropApi.cropData().then((value) {
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

  RxList cropAdded = [].obs;
  RxList cropAddedName = [].obs;
  RxList otherCropAdded = [].obs;
  RxList otherCropAddedName = [].obs;

  // RxInt currentCrop = 0.obs;
  RxBool areFieldsValid = false.obs;

  void validateFields() {
    print("Are fields valid: ${otherCropAddedName}");
    areFieldsValid.value = latiTude.value.isNotEmpty &&
        longiTude.value.isNotEmpty &&
        addressLine.value.text.isNotEmpty &&
        city.value.text.isNotEmpty &&
        state.value.text.isNotEmpty &&
        county.value.text.isNotEmpty &&
        landArea.value.isNotEmpty &&
        selectedPurposeid.value.isNotEmpty &&
        (cropAdded.isNotEmpty || otherCropAddedName.isNotEmpty) &&
        landTitleController.value.text.isNotEmpty;

    print("Are fields valid: ${areFieldsValid.value}");
  }

  /// ADD_LAND
  final _landAddApi = AddLandViewModel();
  final landData = AddLandResponseModel().obs;
  final rxAddLandRequestStatus = Status.LOADING.obs;
  void setRxaddRequest(Status _value) => rxAddLandRequestStatus.value = _value;
  void setAddLanddata(AddLandResponseModel _value) => landData.value = _value;
  final addLandLoading = false.obs;
  final AppPreferences _prefs = AppPreferences();
  RxInt landId = 0.obs;
  Future addLandData() async {
    addLandLoading.value = true;
    _landAddApi.addLand(
        jsonEncode({
          "latitude": "${latiTude.value}",
          "longitude": "${longiTude.value}",
          "address": "${addressLine.value.text}",
          "city": "${city.value.text}",
          "state": "${state.value.text}",
          "country": "${county.value.text}",
          "land_size": "${landArea.value}",
          "purpose": "${selectedPurposeid.value}",
          "crop_to_grow": cropAdded.toList(),
          "land_title": "${landTitleController.value.text}",
          "lease_type": "${lease_type.value}",
          "lease_duration": "${leaseDUration.value}",
          "expected_lease_amount": "${leaseAmount.value}",
          "other_crops": otherCropAddedName.toList()
        }),
        {
          "Authorization": 'Bearer ${await _prefs.getUserAccessToken()}',
          "Content-Type": "application/json"
        }).then((value) async {
      addLandLoading.value = false;
      rxAddLandRequestStatus(Status.SUCCESS);
      print(value);
      setAddLanddata(value);
      landId.value = value.result!.id!.toInt();
      addressLine.value.clear();
      city.value.clear();
      state.value.clear();
      county.value.clear();
      landSize.value.clear();
      otherCropAddedName.clear();
      mapController.showMap.value = true;
      useNeverScrollPhysics.value = true;
      current.value = -1;
      displayedAddress.value = '';
      landArea.value = '';
      selectedPurposeName.value = '';
      cropAdded.clear();
      cropAddedName.clear();
      isAdded.value = false;
      isaddressAdded.value = false;
      landSizeValue.value = false;
      isLandAdded.value = false;
      isPurposeAdded.value = false;
      addPurpose.value = false;
      iscropAdded.value = false;
      isCropValue.value = false;

      // await _prefs.setLandID(landData.value.result!.id!.toInt());
      print(
          "=============================@@@@@@@@@@@@@@@@@@@@@@@@@@=================                      ${landId}");
      // landData.value.result!.id == ;
      showSuccessCustomSnackbar(
          title: 'Message', message: 'Land Added Successfully');

      Get.to(() => LandDetails(id: landId.value));
    }).onError((error, stackTrace) {
      addLandLoading.value = false;
      showErrorCustomSnackbar(
        title: 'Message',
        message: 'This field may not be blank.',
      );

      print(error);
      print(stackTrace);
    });
  }
}
