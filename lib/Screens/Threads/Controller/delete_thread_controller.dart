import 'package:farm_easy/Screens/Threads/ParticularThread/Model/thread_response_model.dart';
import 'package:farm_easy/Screens/Threads/ViewModel/threads_list_view_model.dart';
import 'package:farm_easy/API/Services/network/status.dart';
import 'package:farm_easy/utils/SharedPreferences/shared_preferences.dart';
import 'package:get/get.dart';

class DeleteThreadController extends GetxController {
  RxInt totalPage = 0.obs;

  final _api = DeleteThreadViewModel();
  final threadData = ParticularThreadResponseModel().obs;
  final loading = false.obs;
  final _prefs = AppPreferences();
  final rxRequestStatus = Status.LOADING.obs;

  void setRxRequestStatus(Status _value) => rxRequestStatus.value = _value;
  void setRxRequestData(ParticularThreadResponseModel _value) =>
      threadData.value = _value;
  Future<void> deleteThread(int threadId) async {
    loading.value = true;
    _api.deletedThread({
      "Authorization": 'Bearer ${await _prefs.getUserAccessToken()}',
      "Content-Type": "application/json"
    }, threadId).then((value) {
      loading.value = false;
      setRxRequestData(value);
      setRxRequestStatus(Status.SUCCESS);
    }).onError((error, stackTrace) {
      loading.value = false;
    });
  }
}
