import 'dart:convert';

import 'package:farm_easy/Screens/UserProfile/Model/ReviewResponseMdoel.dart';
import 'package:farm_easy/Screens/UserProfile/ViewModel/user_profile_view_model.dart';
import 'package:farm_easy/Services/network/status.dart';
import 'package:farm_easy/SharedPreferences/shared_preferences.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class RateReviewController extends GetxController{
  RxInt selectedRating = 0.obs;

  void onStarTap(int index) {
    selectedRating.value = index;

  }

  final _api = ReviewCreateViewModel();
  final reviewData= ReviewResponseMdoel().obs;

  final reviewController = TextEditingController().obs;
  final loading = false.obs;
  final rxRequestStatus= Status.LOADING.obs;

  final _prefs= AppPreferences();

  void setRxRequestStatus(Status _value)=>rxRequestStatus.value=_value;
  void setRxRequestData(ReviewResponseMdoel _value)=>reviewData.value=_value;
  Future<void> postReview(int userId, int rating,String comment) async {
    loading.value=true;
    _api.reviewUser(
      jsonEncode({
        "reviewed_user":userId,
        "rating":rating,
        "description":comment,
      }),
        {"Authorization":'Bearer ${ await _prefs.getUserAccessToken()}',"Content-Type": "application/json"},
        ).then((value) {
      setRxRequestData(value);
      loading.value=false;

    }).onError((error, stackTrace) {
      loading.value=false;
      print(error);
      print(stackTrace);
    });
  }

}