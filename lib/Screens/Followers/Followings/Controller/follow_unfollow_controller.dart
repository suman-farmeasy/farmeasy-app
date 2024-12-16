import 'dart:convert';

import 'package:farm_easy/Screens/Directory/Model/AllLandResponseModel.dart';
import 'package:farm_easy/Screens/Directory/ViewModel/directory_view_model.dart';
import 'package:farm_easy/Screens/Followers/Followings/ViewModel/followers_view_model.dart';
import 'package:farm_easy/Services/network/status.dart';
import 'package:farm_easy/SharedPreferences/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../Model/follow_unfollow_model.dart';

class FollowUnfollowController extends GetxController{

  final prefs = AppPreferences();
  final _api= FollowUnfollowViewModel();
  final followUnfollowData= FollowUnfollowResponseModel().obs;

  final loading= false.obs;

  final rxRequestStatus = Status.LOADING.obs;
  void setRxRequestStatus(Status _value)=>rxRequestStatus.value=_value;
  void setRxRequestData(FollowUnfollowResponseModel _value)=>followUnfollowData.value=_value;

  Future followUnfollow(int userId) async {
    loading.value=true;
    Status.LOADING;
    _api.followersList(
      {"Authorization":'Bearer ${ await prefs.getUserAccessToken()}',"Content-Type": "application/json"},
      jsonEncode({
        "user_id":userId
      })
    ).then((value) {
      loading.value=false;
      setRxRequestData(value );
      setRxRequestStatus(Status.SUCCESS);

    }).onError((error, stackTrace){
      loading.value=false;
      Status.ERROR;
      print("=====================================${error}");
      print("=====================================${stackTrace}");
    });

  }

}