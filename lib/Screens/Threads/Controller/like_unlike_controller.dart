import 'dart:convert';

import 'package:farm_easy/Screens/Threads/Model/LikeUnilkeResponseModel.dart';
import 'package:farm_easy/Screens/Threads/ViewModel/threads_list_view_model.dart';
import 'package:farm_easy/API/Services/network/status.dart';
import 'package:farm_easy/utils/SharedPreferences/shared_preferences.dart';
import 'package:get/get.dart';

class LikeUnlikeController extends GetxController {
  final _api = LikeUnlikeViewModel();
  final likeUnlike = LikeUnilkeResponseModel().obs;
  final loading = false.obs;
  final _prefs = AppPreferences();
  RxInt threadId = 0.obs;
  final rxRequestStatus = Status.LOADING.obs;
  void setRxRequestStatus(Status _value) => rxRequestStatus.value = _value;
  void setRxRequestData(LikeUnilkeResponseModel _value) =>
      likeUnlike.value = _value;
  Future<void> likeUnlikeFunc() async {
    loading.value = true;
    _api.likeUnlike(
      jsonEncode({"id": threadId.value}),
      {
        "Authorization": 'Bearer ${await _prefs.getUserAccessToken()}',
        "Content-Type": "application/json"
      },
    ).then((value) {
      loading.value = false;
      setRxRequestData(value);
    }).onError((error, stackTrace) {
      print(error);
      print(stackTrace);
    });
  }
}
