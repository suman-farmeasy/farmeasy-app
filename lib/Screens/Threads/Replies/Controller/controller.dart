import 'package:farm_easy/Screens/Auth/CompleteProfile/Controller/get_profile_controller.dart';
import 'package:farm_easy/Screens/Threads/Replies/Model/RepliesListResponseModel.dart';
import 'package:farm_easy/Screens/Threads/Replies/ViewModel/thread_section_view_model.dart';
import 'package:farm_easy/Services/network/status.dart';
import 'package:farm_easy/SharedPreferences/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/get_rx.dart';

class RespliesController extends GetxController {

 final getProfileController = Get.put(GetProfileController());

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    repliesList();
    print("==================oninit");
    scrollController = ScrollController();
    scrollController.addListener(scrollListener);
    getProfileController.getProfile();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    scrollController.removeListener(scrollListener);
    scrollController.dispose();
  }

  void scrollListener() {
    if (scrollController.position.pixels ==
        scrollController.position.maxScrollExtent) {
      loadMoreData();
    }
  }

  void loadMoreData() {
    if (!loading.value && currentPage.value <
        repliesData.value.result!.pageInfo!.totalPage!.toInt()) {
      currentPage.value++;
      fetchRepliesDataAndUpdateList();
    }
  }


  RxDouble opacity = 1.0.obs;
  final replyController = TextEditingController().obs;
  final _api = RepliesListViewModel();
  ScrollController scrollController = ScrollController();
  final repliesData = RepliesListResponseModel().obs;
  final loading = false.obs;
  final _prefs = AppPreferences();
  RxInt currentPage = 1.obs;
  RxInt threadId = 0.obs;
  final rxRequestStatus = Status.LOADING.obs;

  void setRxRequestStatus(Status _value) => rxRequestStatus.value = _value;

  void setRxRequestData(RepliesListResponseModel _value) =>
      repliesData.value = _value;

  Future<void> repliesList() async {
    loading.value = true;
    _api.repliesList(
        {
          "Authorization": 'Bearer ${ await _prefs.getUserAccessToken()}',
          "Content-Type": "application/json"
        }
        , threadId.value, currentPage.value).then((value) {
      loading.value = false;
      setRxRequestData(value);
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (scrollController.hasClients) {
          scrollController.jumpTo(scrollController.position.maxScrollExtent);
        }
      });
    }).onError((error, stackTrace) {
      print(error);
      print(stackTrace);
    });
  }

  Future<void> fetchRepliesDataAndUpdateList() async {
    try {
      final value = await _api.repliesList(
        {
          "Authorization": 'Bearer ${await _prefs.getUserAccessToken()}',
          "Content-Type": "application/json"
        },
        threadId.value,
        currentPage.value,
      );
      repliesData.update((val) {
        val!.result!.data!.addAll(value.result!.data!);
      });
    } catch (error) {
      print(error);
    }
  }
}