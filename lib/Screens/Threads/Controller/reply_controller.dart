import 'dart:convert';

import 'package:farm_easy/Screens/Threads/Replies/Controller/controller.dart';
import 'package:farm_easy/Screens/Threads/Replies/Model/ReplyDataResponseModel.dart';
import 'package:farm_easy/Screens/Threads/Replies/ViewModel/thread_section_view_model.dart';
import 'package:farm_easy/API/Services/network/status.dart';
import 'package:farm_easy/utils/SharedPreferences/shared_preferences.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class ReplyController extends GetxController {
  final _api = ReplyViewModel();
  final postReply = ReplyDataResponseModel().obs;
  final loading = false.obs;
  final _prefs = AppPreferences();
  final replyController = TextEditingController().obs;
  RxInt threadId = 0.obs;
  final replyList = Get.put(RespliesController());
  final rxRequestStatus = Status.LOADING.obs;
  void setRxRequestStatus(Status _value) => rxRequestStatus.value = _value;
  void setRxRequestData(ReplyDataResponseModel _value) =>
      postReply.value = _value;
  void replyThread() async {
    await reply();
    replyController.value.clear();
  }

  Future<void> reply() async {
    loading.value = true;
    _api.reply(
        jsonEncode({
          "thread": threadId.value,
          "reply": replyController.value.text,
        }),
        {
          "Authorization": 'Bearer ${await _prefs.getUserAccessToken()}',
          "Content-Type": "application/json"
        }).then((value) {
      loading.value = false;
      setRxRequestData(value);
      replyList.repliesList();
    }).onError((error, stackTrace) {
      print(error);
      print(stackTrace);
    });
  }
}
