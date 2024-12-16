import 'package:farm_easy/Screens/Auth/UserResgister/Model/crops_model.dart';
import 'package:farm_easy/Screens/Auth/UserResgister/ViewModel/farmer_experties_view_model.dart';
import 'package:farm_easy/API/Services/network/status.dart';
import 'package:get/get.dart';

class CropGridCalculator extends GetxController {
  @override
  void onInit() {
    super.onInit();
    farmerCrop();
  }

  RxList<String> selectedCropsName = <String>[].obs;
  RxList<String> selectedCropsImages = <String>[].obs;
  RxList<int> selectedCropsId = <int>[].obs;

  final int _maxSelection = 2;

  void selectCrop(String name, int id, String image) {
    if (selectedCropsId.length <= _maxSelection) {
      if (!selectedCropsId.contains(id)) {
        selectedCropsId.add(id);
        selectedCropsName.add(name);
        selectedCropsImages.add(image);
      }
    } else {
      print('Maximum selection reached');
    }
  }

  void removeCrop(String name, int id, String image) {
    selectedCropsId.remove(id);
    selectedCropsName.remove(name);
    selectedCropsImages.remove(image);
  }

  final _farmerCrops = FarmerCropViewModel();
  final farmerCropLoading = false.obs;
  final farmerCropData = FarmerCropsData().obs;
  final rxRequestStatusFarmerCrop = Status.LOADING.obs;

  void setRequestStatusFarmerCrop(Status _value) =>
      rxRequestStatusFarmerCrop.value = _value;

  void setFarmerCropData(FarmerCropsData _value) =>
      farmerCropData.value = _value;

  void farmerCrop() {
    farmerCropLoading.value = true;
    _farmerCrops.farmerCrop().then((value) {
      setFarmerCropData(value);
      setRequestStatusFarmerCrop(Status.SUCCESS);
    }).onError((error, stackTrace) {
      setRequestStatusFarmerCrop(Status.ERROR);
      print(error);
      print(stackTrace);
    });
  }
}
