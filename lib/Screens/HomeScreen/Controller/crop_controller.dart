import 'package:farm_easy/Screens/Auth/UserResgister/Model/crops_model.dart';
import 'package:farm_easy/Screens/Auth/UserResgister/ViewModel/farmer_experties_view_model.dart';
import 'package:farm_easy/Screens/Crop%20Yield%20Calculator/View/crop_calculator.dart';
import 'package:farm_easy/Screens/HomeScreen/Controller/crop_grid_calculator.dart';
import 'package:farm_easy/Screens/HomeScreen/Model/crop_details_model.dart';
import 'package:farm_easy/Screens/HomeScreen/Model/crop_search.dart';
import 'package:farm_easy/Screens/HomeScreen/ViewModel/land_list_viewmodel.dart';
import 'package:farm_easy/Services/network/status.dart';
import 'package:farm_easy/SharedPreferences/shared_preferences.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class CropController extends GetxController {
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    updateSliderValue(sliderValue.value);
    farmerCrop();
  }

  final cropGridCalculater = Get.put(CropGridCalculator());
  final prefs = AppPreferences();
  final _api = CropSearchViewModel();

  final cropData = CropSearchResponseModel().obs;
  final loading = false.obs;
  RxInt currentPage = 1.obs;
  final refreshloading = false.obs;
  final searchCrop = TextEditingController().obs;
  final rxRequestStatus = Status.LOADING.obs;
  final RxInt maxSelectedItems = 3.obs;
  var selectedItems = <String>[].obs;
  RxList<int> selectedItemsId = <int>[].obs;
  void setRxRequestStatus(Status _value) => rxRequestStatus.value = _value;
  void setRxRequestData(CropSearchResponseModel _value) =>
      cropData.value = _value;

  Future<void> cropListData(String crop) async {
    loading.value = true;
    _api.cropSearch({
      "Authorization": 'Bearer ${await prefs.getUserAccessToken()}',
      "Content-Type": "application/json"
    }, crop).then((value) {
      loading.value = false;
      setRxRequestData(value);
    }).onError((error, stackTrace) {
      loading.value = false;
      print(error);
      print(stackTrace);
    });
  }

  void addItem(String item) {
    if (!selectedItems.contains(item) &&
        selectedItems.length < maxSelectedItems.value) {
      selectedItems.add(item);
      searchCrop.value.clear();
    }
  }

  void addItemId(int item) {
    if (!selectedItemsId.contains(item) &&
        selectedItemsId.length < maxSelectedItems.value) {
      selectedItemsId.add(item);
      searchCrop.value.clear();
    }
  }

  void removeItem(String item) {
    selectedItems.remove(item);
  }

  void removeItemId(int item) {
    selectedItemsId.remove(item);
  }

  ///DROP DOWN
  var selectedValue = Rx<String?>('SQFT');

  // List of dropdown items
  final dropdownItems = ['SQFT', 'Bigha', 'Acre', 'Hectare'];

  // Function to update the selected value
  var sliderValue = Rx<double>(100.0);

  void updateSelectedValue(String? newValue) {
    selectedValue.value = newValue;
    // Reset slider value to a valid value within the new range
    if (newValue == "SQFT") {
      sliderValue.value = sliderValue.value.clamp(100.0, 10000000.0);
    } else {
      sliderValue.value = sliderValue.value.clamp(0.0, 100.0);
    }
  }

  void updateSliderValue(double value) {
    double minValue = selectedValue.value == "SQFT" ? 100.0 : 0.0;
    double maxValue = selectedValue.value == "SQFT" ? 10000000.0 : 100.0;
    sliderValue.value = value.clamp(minValue, maxValue);
  }

  ///DROP DOWN FERTILIZER;
  var selectedValuefertilizer = Rx<String?>('Acre');

  // List of dropdown items
  final dropdownItemsfertilizer = ['Acre', 'Hectare'];

  // Function to update the selected value
  var sliderValuefertilizer = Rx<double>(100.0);

  void updateSelectedValuefertilizer(String? newValue) {
    selectedValuefertilizer.value = newValue;
    // Reset slider value to a valid value within the new range
    if (newValue == "SQFT") {
      sliderValuefertilizer.value =
          sliderValuefertilizer.value.clamp(100.0, 10000000.0);
    } else {
      sliderValuefertilizer.value =
          sliderValuefertilizer.value.clamp(0.0, 100.0);
    }
  }

  void updateSliderValuefertilizer(double value) {
    double minValue = selectedValuefertilizer.value == "SQFT" ? 100.0 : 0.0;
    double maxValue =
        selectedValuefertilizer.value == "SQFT" ? 10000000.0 : 100.0;
    sliderValuefertilizer.value = value.clamp(minValue, maxValue);
  }

  ///------------
  final _cropApi = CropDetailsViewModel();
  final cropDetails = CropDetailsResponseModel().obs;
  final cropLoading = false.obs;
  final rxcropRequestStatus = Status.LOADING.obs;

  void setcropRxRequestStatus(Status _value) =>
      rxcropRequestStatus.value = _value;
  void setcropRxRequestData(CropDetailsResponseModel _value) =>
      cropDetails.value = _value;

  Future<void> cropdetailsData() async {
    cropLoading.value = true;
    _cropApi.cropDetails({
      "Authorization": 'Bearer ${await prefs.getUserAccessToken()}',
      "Content-Type": "application/json"
    },
        sliderValue.value.toStringAsFixed(2).toString(),
        selectedValue.value.toString(),
        cropGridCalculater.selectedCropsId.toList()).then((value) {
      Get.to(() => CropDetailsScreen());
      cropLoading.value = false;
      setcropRxRequestData(value);
    }).onError((error, stackTrace) {
      cropLoading.value = false;
      print(error);
      print(stackTrace);
    });
  }

  ///Fertilizer crop

  // RxList<String> selectedCropsName = <String>[].obs;
  // RxList<String> selectedCropsImages = <String>[].obs;
  // RxList<int> selectedCropsId = <int>[].obs;
  RxString selectedCropsName = "".obs;
  RxString selectedCropsImages = "".obs;
  RxInt selectedCropsId = 0.obs;

  // final int _maxSelection = 0;

  // void removeCrop(String name, int id, String image) {
  //   selectedCropsId.remove(id);
  //   selectedCropsName.remove(name);
  //   selectedCropsImages.remove(image);
  // }

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
