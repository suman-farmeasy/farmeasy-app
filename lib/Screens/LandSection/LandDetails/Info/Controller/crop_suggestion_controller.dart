import 'package:farm_easy/Screens/LandSection/LandDetails/Info/Model/CropSuggestionResponseModel.dart';
import 'package:farm_easy/Screens/LandSection/LandDetails/Info/ViewModel/land_info_view_model.dart';
import 'package:farm_easy/API/Services/network/status.dart';
import 'package:farm_easy/Utils/SharedPreferences/shared_preferences.dart';
import 'package:get/get.dart';

class CropSuggestionController extends GetxController {
  RxBool iscropAdded = false.obs;
  RxBool isCropValue = false.obs;
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    cropSuggestion();
  }

  final _api = CropSuggestionViewModel();
  final cropData = CropSuggestionResponseModel().obs;
  final loading = false.obs;
  final rxRequestStatus = Status.LOADING.obs;
  RxInt landId = 0.obs;
  final _prefs = AppPreferences();
  void setRxRequestStatus(Status _value) => rxRequestStatus.value = _value;
  void setRxRequestData(CropSuggestionResponseModel _value) =>
      cropData.value = _value;
  Future cropSuggestion() async {
    loading.value = true;
    _api.cropSuggestionList(
      {
        "Authorization": 'Bearer ${await _prefs.getUserAccessToken()}',
        "Content-Type": "application/json"
      },
      landId.value,
    ).then((value) {
      loading.value = false;
      if (value != null && value.result != null && value.result!.isNotEmpty) {
        setRxRequestData(value);
        setRxRequestStatus(Status.SUCCESS);
      }
    }).onError((error, stackTrace) {
      print(error);
      print(stackTrace);
    });
  }

  void addselectCrop() {
    isCropValue.value = true;
  }

  void cropAdd() {
    iscropAdded.value = true;
  }

  RxList cropAdded = [].obs;
  RxList cropAddedName = [].obs;
}
