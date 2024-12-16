
import 'package:farm_easy/Screens/LandSection/LandDetails/Info/Model/WaterResourceResponseModel.dart';
import 'package:farm_easy/Screens/LandSection/LandDetails/Info/ViewModel/land_info_view_model.dart';
import 'package:farm_easy/Services/network/status.dart';
import 'package:farm_easy/SharedPreferences/shared_preferences.dart';
import 'package:get/get.dart';

class WaterResourceController  extends GetxController{

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    waterResourceList();
  }
 final waterSourceVisible = true.obs;
  final _api = WaterResourceViewModel();
  final waterResource = WaterResourceResponseModel().obs;
  final loading = false.obs;
  final rxRequestStatus = Status.LOADING.obs;
  RxInt waterId=0.obs;
  RxString waterResourceId= "".obs;
  RxString selectedValue = 'Available'.obs;
  void setSelectedValue(String value) {
    selectedValue.value = value;
    waterSourceVisible.value = false;
  }
  void setRxRequestStatus(Status _value)=>rxRequestStatus.value=_value;
  void setRxRequestData(WaterResourceResponseModel _value)=>waterResource.value=_value;


  Future waterResourceList() async {
    loading.value=true;
    _api.waterResource().then((value) {
      loading.value=false;
      setRxRequestData(value);
    }).onError((error, stackTrace) {});

  }
}