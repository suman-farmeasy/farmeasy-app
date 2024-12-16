import 'package:farm_easy/Screens/HomeScreen/Model/LandListResponseModel.dart';
import 'package:farm_easy/Screens/HomeScreen/ViewModel/land_list_viewmodel.dart';
import 'package:farm_easy/API/Services/network/status.dart';
import 'package:farm_easy/Utils/SharedPreferences/shared_preferences.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    landListData();
  }

  final prefs = AppPreferences();
  final _api = LandListViewModel();
  final _apiCrop = CropSearchViewModel();
  final landData = LandListResponseModel().obs;
  final loading = false.obs;
  RxInt currentPage = 1.obs;
  final refreshloading = false.obs;
  final rxRequestStatus = Status.LOADING.obs;
  void setRxRequestStatus(Status _value) => rxRequestStatus.value = _value;
  void setRxRequestData(LandListResponseModel _value) =>
      landData.value = _value;

  Future<void> landListData() async {
    loading.value = true;
    _api.landList(
      {
        "Authorization": 'Bearer ${await prefs.getUserAccessToken()}',
        "Content-Type": "application/json"
      },
      currentPage.value,
    ).then((value) {
      loading.value = false;
      setRxRequestData(value);
    }).onError((error, stackTrace) {
      loading.value = false;
      print(error);
      print(stackTrace);
    });
  }
}
