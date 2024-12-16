
import 'package:farm_easy/Screens/LandSection/LandDetails/Info/Model/LandTypeResponseModel.dart';
import 'package:farm_easy/Screens/LandSection/LandDetails/Info/ViewModel/land_info_view_model.dart';
import 'package:farm_easy/Services/network/status.dart';
import 'package:farm_easy/SharedPreferences/shared_preferences.dart';
import 'package:get/get.dart';

class ListLandTypeController extends GetxController{

@override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    landDetails();
  }

  final _api = LandTypeViewModel();
  final landData = LandTypeResponseModel().obs;
  final loading = false.obs;
  final rxRequestStatus = Status.LOADING.obs;
  RxInt selectedId=RxInt(-1);
  RxString selectedid= "".obs;
  final _prefs =AppPreferences();
  void setRxRequestStatus(Status _value)=>rxRequestStatus.value=_value;
  void setRxRequestData(LandTypeResponseModel _value)=>landData.value=_value;


  Future landDetails() async {
    loading.value=true;
    _api.landType().then((value) {
      loading.value=false;
      setRxRequestData(value);
    }).onError((error, stackTrace) {});

  }
}