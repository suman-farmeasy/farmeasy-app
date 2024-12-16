import 'package:farm_easy/Constants/color_constants.dart';
import 'package:farm_easy/Screens/Threads/Controller/delete_thread_controller.dart';
import 'package:farm_easy/Screens/Threads/Model/ThreadsListResponseModel.dart';
import 'package:farm_easy/Screens/Threads/ViewModel/threads_list_view_model.dart';
import 'package:farm_easy/Services/network/status.dart';
import 'package:farm_easy/SharedPreferences/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class ThreadsController extends GetxController {
  final deleteThreadControllere = Get.put(DeleteThreadController());

  @override
  void onInit() {
    super.onInit();
    threadList();
  }

  RxInt current = (-1).obs;
  RxInt totalPage = 0.obs;
  RxBool isLiked = false.obs;
  final _api = ThreadsListViewModel();
  final threadData = ThreadListResponseModel().obs;
  RxList<Data> threadDataList = <Data>[].obs;

  RxList<int> tags = <int>[].obs;
  final loading = false.obs;
  final _prefs = AppPreferences();
  final rxRequestStatus = Status.LOADING.obs;
  RxInt currentPage = 1.obs;
  void setRxRequestStatus(Status _value) => rxRequestStatus.value = _value;
  void setRxRequestData(ThreadListResponseModel _value) =>
      threadData.value = _value;

  Future<void> threadList({bool clearList = false}) async {
    loading.value = true;
    Status.LOADING;
    if (clearList) {
      threadDataList.clear();
    }
    _api.threadsList({
      "Authorization": 'Bearer ${await _prefs.getUserAccessToken()}',
      "Content-Type": "application/json"
    }, tags.toList(), currentPage.value).then((value) {
      loading.value = false;
      setRxRequestData(value);
      setRxRequestStatus(Status.SUCCESS);

      if (threadData.value.result!.data != null) {
        totalPage.value = threadData.value.result!.pageInfo!.totalPage!.toInt();
        threadDataList.addAll(threadData.value.result!.data!);
      }
    }).onError((error, stackTrace) {
      loading.value = false;
    });
  }

  void loadMoreData() {
    if (currentPage.value < totalPage.value) {
      currentPage.value++;
      threadList();
    } else {
      print('Already on the last page');
    }
  }

  Future<void> refreshAllThread() async {
    currentPage.value = 1;
    threadDataList.clear();
    await threadList();
  }

  void showDeleteDialog(int index, String title, int id) {
    Get.dialog(
      AlertDialog(
        title: Text(
          'Are you sure you want to delete this post',
          style: GoogleFonts.poppins(
              fontSize: 15, fontWeight: FontWeight.w600, color: Colors.black),
        ),
        content: Text(
          title,
          style: GoogleFonts.poppins(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: AppColor.BROWN_TEXT),
        ),
        actions: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TextButton(
                onPressed: () {
                  Get.back();
                },
                child: Text('Cancel'),
              ),
              InkWell(
                onTap: () {
                  deleteThread(index, id);
                  Get.back();
                },
                child: Container(
                    padding: const EdgeInsets.symmetric(
                      vertical: 10,
                      horizontal: 15,
                    ),
                    decoration: ShapeDecoration(
                      color: AppColor.DARK_GREEN,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: Center(
                      child: Text(
                        'Delete',
                        style: TextStyle(
                          color: Color(0xFFFBFBFB),
                          fontSize: 12,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w600,
                          height: 0,
                        ),
                      ),
                    )),
              ),
            ],
          )
        ],
      ),
    );
  }

  void deleteThread(int index, int id) {
    threadDataList.removeAt(index);
    deleteThreadControllere.deleteThread(id);
    update();
  }
}
