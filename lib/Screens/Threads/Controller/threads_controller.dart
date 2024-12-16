import 'package:farm_easy/Screens/Threads/Model/ThreadsListResponseModel.dart';
import 'package:farm_easy/Screens/Threads/ViewModel/threads_list_view_model.dart';
import 'package:farm_easy/API/Services/network/status.dart';
import 'package:farm_easy/Utils/SharedPreferences/shared_preferences.dart';
import 'package:get/get.dart';

class ThreadsController extends GetxController {
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    threadList();
  }

  void resetPageToFirst() {
    currentPage.value = 1;
  }

  RxInt current = (-1).obs;
  RxInt totalPage = 0.obs;
  RxBool isLiked = false.obs;
  final _api = ThreadsListViewModel();
  final threadData = ThreadListResponseModel().obs;
  RxList threadDataList = [].obs;

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
}
