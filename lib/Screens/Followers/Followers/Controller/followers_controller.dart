import 'package:farm_easy/Screens/Directory/Model/AllLandResponseModel.dart';
import 'package:farm_easy/Screens/Directory/ViewModel/directory_view_model.dart';
import 'package:farm_easy/Screens/Followers/Followers/Model/followers_list_response_model.dart';
import 'package:farm_easy/Screens/Followers/Followers/ViewModel/followers_view_model.dart';
import 'package:farm_easy/Screens/Followers/Followings/Model/FollowingListResponseModel.dart';
import 'package:farm_easy/Screens/Followers/Followings/ViewModel/followers_view_model.dart';
import 'package:farm_easy/API/Services/network/status.dart';
import 'package:farm_easy/Utils/SharedPreferences/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FollowersController extends GetxController {
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    allFollowersList();
  }

  RxInt currentPage = 1.obs;
  RxInt totalPages = 0.obs;
  RxInt userId = 0.obs;

  final prefs = AppPreferences();
  final _api = FollowersListViewModel();
  final followerslist = FollowersListResponseModel().obs;
  RxList followersData = [].obs;
  final loading = false.obs;
  final isFollow = false.obs;
  final rxRequestStatus = Status.LOADING.obs;
  void setRxRequestStatus(Status _value) => rxRequestStatus.value = _value;
  void setRxRequestData(FollowersListResponseModel _value) =>
      followerslist.value = _value;

  Future allFollowersList() async {
    final token = await prefs.getUserAccessToken();
    print("TOKEN: $token");
    loading.value = true;
    Status.LOADING;
    _api.followersList(
      {
        "Authorization": 'Bearer ${await prefs.getUserAccessToken()}',
        "Content-Type": "application/json"
      },
      userId.value,
      currentPage.value,
    ).then((value) {
      loading.value = false;
      setRxRequestData(value);
      setRxRequestStatus(Status.SUCCESS);
      print("TOKEN:${token}");
      // if(landlist.value.result?.data !=null){
      //   totalPages.value= landlist.value.result!.pageInfo!.totalPage!.toInt();
      //   landData.addAll(landlist.value.result!.data!);
      // }
    }).onError((error, stackTrace) {
      loading.value = false;
      Status.ERROR;
      print("=====================================${error}");
      print("=====================================${stackTrace}");
    });
  }

// void loadMoreData() {
//   if (currentPage.value < totalPages.value) {
//     currentPage.value++;
//     allLandList();
//   } else {
//
//     print('Already on the last page');
//   }
// }
// Future<void> refreshAllLandData() async {
//   currentPage.value = 1;
//   landData.clear();
//   await allLandList();
// }
}
