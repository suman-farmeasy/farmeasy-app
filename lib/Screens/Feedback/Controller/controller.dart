import 'dart:convert';

import 'package:farm_easy/Constants/custom_snackbar.dart';
import 'package:farm_easy/Screens/Feedback/ViewModel/viewmodel.dart';
import 'package:farm_easy/Screens/UserProfile/Model/ReviewResponseMdoel.dart';
import 'package:farm_easy/Services/network/status.dart';
import 'package:farm_easy/SharedPreferences/shared_preferences.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class FeedbackController extends GetxController {
  RxList<String> selectedFeedback = <String>[
    "assets/feedback/1.png",
    "assets/feedback/2.png",
    "assets/feedback/3.png",
    "assets/feedback/4.png",
    "assets/feedback/5.png",
  ].obs;

  final _api = AddFeedbackViewModel();
  final reviewData = ReviewResponseMdoel().obs;

  final reviewController = TextEditingController().obs;
  final loading = false.obs;
  final rxRequestStatus = Status.LOADING.obs;

  final _prefs = AppPreferences();
  final description = TextEditingController().obs;
  void setRxRequestStatus(Status _value) => rxRequestStatus.value = _value;
  void setRxRequestData(ReviewResponseMdoel _value) =>
      reviewData.value = _value;
  Future<void> addFeedback(int rating, String comment) async {
    loading.value = true;
    _api.addFeedback(
      jsonEncode({
        "rating": rating,
        "description": comment,
      }),
      {
        "Authorization": 'Bearer ${await _prefs.getUserAccessToken()}',
        "Content-Type": "application/json"
      },
    ).then((value) {
      setRxRequestData(value);
      loading.value = false;
      reviewController.value.clear();

      Get.back();
      showSuccessCustomSnackbar(
          title: "Updated successfully",
          message: "Feedback updated successfully");
    }).onError((error, stackTrace) {
      loading.value = false;
      print(error);
      print(stackTrace);
    });
  }
}
