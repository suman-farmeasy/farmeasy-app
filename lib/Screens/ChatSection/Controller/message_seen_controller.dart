import 'package:farm_easy/Screens/ChatSection/Model/MessageSeenResponseModel.dart';
import 'package:farm_easy/Screens/ChatSection/ViewModel/chat_view_model.dart';
import 'package:farm_easy/API/Services/network/status.dart';
import 'package:farm_easy/Utils/SharedPreferences/shared_preferences.dart';
import 'package:get/get.dart';

class MessageSeenController extends GetxController {
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    isMessageSeen();
  }

  RxInt enquiryId = 0.obs;

  final _api = IsMessageSeenViewModel();
  final isMessageSeenData = MessageSeenResponseModel().obs;
  final loading = false.obs;
  final _prefs = AppPreferences();
  final rxRequestStatus = Status.LOADING.obs;
  void setRxRequestStatus(Status _value) => rxRequestStatus.value = _value;
  void setRxRequestData(MessageSeenResponseModel _value) =>
      isMessageSeenData.value = _value;
  Future<void> isMessageSeen() async {
    _api.isMessageSeen({
      "Authorization": 'Bearer ${await _prefs.getUserAccessToken()}',
      "Content-Type": "application/json"
    }, enquiryId.value).then((value) {
      loading.value = false;
    }).onError((error, stackTrace) {});
  }
}
