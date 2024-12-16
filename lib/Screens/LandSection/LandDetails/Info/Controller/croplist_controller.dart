import 'package:farm_easy/Screens/LandSection/LandAdd/Model/CropResponseModel.dart';
import 'package:farm_easy/Screens/LandSection/LandAdd/ViewModel/land_view_model.dart';
import 'package:farm_easy/API/Services/network/status.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';

class CropListController extends GetxController {
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    cropData();
  }

  RxBool iscropAdded = false.obs;
  RxBool isCropValue = false.obs;
  final _cropApi = CroupViewModel();
  final cropResponseData = CropResponseModel().obs;
  final cropDataloading = false.obs;
  final rxCroprequestStatus = Status.LOADING.obs;
  void setCropRequest(Status _value) => rxCroprequestStatus.value = _value;
  void setCropData(CropResponseModel _value) => cropResponseData.value = _value;
  void cropData() {
    cropDataloading.value = true;
    _cropApi.cropData().then((value) {
      if (value != null && value.result != null && value.result!.isNotEmpty) {
        setCropData(value);
        setCropRequest(Status.SUCCESS);
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
