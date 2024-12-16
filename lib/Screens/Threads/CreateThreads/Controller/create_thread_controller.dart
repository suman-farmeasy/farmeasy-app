import 'dart:convert';

import 'package:farm_easy/Constants/custom_snackbar.dart';
import 'package:farm_easy/Screens/Dashboard/controller/dashboard_controller.dart';
import 'package:farm_easy/Screens/Threads/Controller/threads_controller.dart';
import 'package:farm_easy/Screens/Threads/CreateThreads/Controller/list_tags_controller.dart';
import 'package:farm_easy/Screens/Threads/CreateThreads/Controller/thread_image_controller.dart';
import 'package:farm_easy/Screens/Threads/CreateThreads/Model/ThreadCreatedResponseModel.dart';
import 'package:farm_easy/Screens/Threads/CreateThreads/ViewModel/createthreads_view_model.dart';
import 'package:farm_easy/Services/network/status.dart';
import 'package:farm_easy/SharedPreferences/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CreateThreadController extends GetxController {
  final dahboardController = Get.put(DashboardController());
  final threadController = Get.put(ThreadsController());
  final _api = CreateThreadsViewModel();
  final threadData = ThreadCreatedResponseModel().obs;
  final titleController = TextEditingController().obs;
  final descriptionController = TextEditingController().obs;
  final tagController = Get.put(ListTagsController());
  final imageController = Get.put(ThreadsImageController());
  final loading = false.obs;
  final _prefs = AppPreferences();
  final rxRequestStatus = Status.LOADING.obs;
  final RxInt wordCount = 0.obs;
  void setRxRequestStatus(Status _value) => rxRequestStatus.value = _value;
  void setRxRequestData(ThreadCreatedResponseModel _value) =>
      threadData.value = _value;

  // Clears all fields after successful post
  void clearAllFields() {
    titleController.value.clear();
    descriptionController.value.clear();
    tagController.tags.clear();
    imageController.uploadedIds.clear();
  }

  Future threadDataUpload() async {
    loading.value = true;
    _api.createThread(
        jsonEncode({
          "title": "${titleController.value.text}",
          "description": "${descriptionController.value.text}",
          "tags": tagController.tags.toList(),
          "image_id": imageController.uploadedIds.toList()
        }),
        {
          "Authorization": 'Bearer ${await _prefs.getUserAccessToken()}',
          "Content-Type": "application/json"
        }).then((value) {
      loading.value = false;
      setRxRequestData(value);
      clearAllFields();
      Get.back();
      threadController.refreshAllThread();
    }).onError((error, stackTrace) {
      loading.value = false;
      showErrorCustomSnackbar(
        title: 'Message',
        message: "Please fill all the mandatory section",
      );

      print(error);
      print(stackTrace);
    });
  }
}
