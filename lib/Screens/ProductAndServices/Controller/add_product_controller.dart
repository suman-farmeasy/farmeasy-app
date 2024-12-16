import 'dart:convert';

import 'package:farm_easy/Screens/Auth/CompleteProfile/Controller/get_profile_controller.dart';
import 'package:farm_easy/Screens/ProductAndServices/Controller/product_img_controller.dart';
import 'package:farm_easy/Screens/ProductAndServices/Controller/product_view_controller.dart';
import 'package:farm_easy/Screens/ProductAndServices/ViewModel/product_view_model.dart';
import 'package:farm_easy/Screens/Threads/CreateThreads/Model/ThreadCreatedResponseModel.dart';
import 'package:farm_easy/API/Services/network/status.dart';
import 'package:farm_easy/utils/SharedPreferences/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddProductController extends GetxController {
  // final dahboardController= Get.put(DashboardController());
  // final threadController = Get.put(ThreadsController());
  final getProfileController = Get.find<GetProfileController>();
  final productController = Get.put(ProductViewController());
  final _api = CreateProductViewModel();
  final _apiUpdate = UpdateProductViewModel();
  final productData = ThreadCreatedResponseModel().obs;
  final productName = TextEditingController().obs;
  final descriptionController = TextEditingController().obs;
  // final tagController = Get.put(ListTagsController());
  RxString currency = "".obs;
  RxString currencySym = "".obs;
  final unitPrice = TextEditingController().obs;
  final unit = "".obs;
  final imageController = Get.put(ProductImgController());
  final loading = false.obs;
  final _prefs = AppPreferences();
  final unitValue = TextEditingController().obs;
  final rxRequestStatus = Status.LOADING.obs;
  void setRxRequestStatus(Status _value) => rxRequestStatus.value = _value;
  void setRxRequestData(ThreadCreatedResponseModel _value) =>
      productData.value = _value;

  RxList<String> unitsList = <String>[
    "Gram",
    "Kilogram",
    "Quintal",
    "Ton",
    "Piece(s)",
    "Hour(s)",
    "Day(s)",
    "Month(s)",
    "Acre",
    "Sq. m",
    "Bigha",
    "Sq. ft",
    "Hectare"
  ].obs;
  RxList<String> currencyList = <String>["Dollar", "Rupees"].obs;
  RxList<String> currencySymbol = <String>['\$', "INR"].obs;

  Future productUpload() async {
    loading.value = true;
    _api.createProduct(
        jsonEncode({
          "name": "${productName.value.text}",
          "description": "${descriptionController.value.text}",
          "currency": currencySym.value,
          "image_ids": imageController.uploadedIds.toList(),
          "unit_price": unitPrice.value.text,
          "unit_value": unitValue.value.text,
          "unit": unit.value,
        }),
        {
          "Authorization": 'Bearer ${await _prefs.getUserAccessToken()}',
          "Content-Type": "application/json"
        }).then((value) {
      loading.value = false;
      setRxRequestData(value);
      Get.back();
      productController.productDataList.clear();
      productController.productList(
          userId:
              getProfileController.getProfileData.value.result?.userId ?? 0);
    }).onError((error, stackTrace) {
      loading.value = false;
      print(error);
      print(stackTrace);
    });
  }

  Future updateProduct(int productId) async {
    loading.value = true;
    _apiUpdate.updateProduct(
        productId,
        jsonEncode({
          "name": "${productName.value.text}",
          "description": "${descriptionController.value.text}",
          "currency": currencySym.value,
          "image_ids": imageController.uploadedIds.toList(),
          "unit_price": unitPrice.value.text,
          "unit_value": unitValue.value.text,
          "unit": unit.value,
        }),
        {
          "Authorization": 'Bearer ${await _prefs.getUserAccessToken()}',
          "Content-Type": "application/json"
        }).then((value) {
      loading.value = false;
      setRxRequestData(value);
      Get.back();
      productController.productDataList.clear();
      productController.productList(
          userId:
              getProfileController.getProfileData.value.result?.userId ?? 0);
    }).onError((error, stackTrace) {
      loading.value = false;
      print(error);
      print(stackTrace);
    });
  }
}
