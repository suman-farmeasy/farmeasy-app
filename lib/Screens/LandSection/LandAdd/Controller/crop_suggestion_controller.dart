import 'package:farm_easy/Screens/LandSection/LandDetails/Info/Model/ChatGptCropSuggestionResponseModel.dart';
import 'package:farm_easy/Screens/LandSection/LandDetails/Info/ViewModel/land_info_view_model.dart';
import 'package:farm_easy/API/Services/network/status.dart';
import 'package:farm_easy/Utils/SharedPreferences/shared_preferences.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

class ChatGPTCropSuggestionController extends GetxController {
  final _api = ChatGPTCropSuggestionViewModel();
  final cropData = ChatGptCropSuggestionResponseModel().obs;
  final loading = false.obs;
  final rxRequestStatus = Status.LOADING.obs;
  RxInt landId = 0.obs;
  final _prefs = AppPreferences();
  void setRxRequestStatus(Status _value) => rxRequestStatus.value = _value;
  void setRxRequestData(ChatGptCropSuggestionResponseModel _value) =>
      cropData.value = _value;
  Future cropSuggestion(String city, String state, String country) async {
    loading.value = true;
    _api.cropSuggestionList({
      "Authorization": 'Bearer ${await _prefs.getUserAccessToken()}',
      "Content-Type": "application/json"
    }, city, state, country).then((value) {
      if (value != null && value.result != null && value.result!.isNotEmpty) {
        setRxRequestData(value);
        setRxRequestStatus(Status.SUCCESS);
      }
    }).onError((error, stackTrace) {
      print(error);
      print(stackTrace);
    });
  }
}
