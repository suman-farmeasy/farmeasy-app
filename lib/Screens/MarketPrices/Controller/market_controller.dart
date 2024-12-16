import 'package:farm_easy/Screens/MarketPrices/Model/market_crop_img_data.dart';
import 'package:farm_easy/Screens/MarketPrices/Model/market_data_response_model.dart';
import 'package:farm_easy/Screens/MarketPrices/ViewModel/view_model.dart';
import 'package:farm_easy/API/Services/network/status.dart';
import 'package:farm_easy/Utils/SharedPreferences/shared_preferences.dart';
import 'package:get/get.dart';

class MarketController extends GetxController {
  @override
  void onInit() {
    super.onInit();
    marketDataList("", "", "", "");
  }

  RxString state = "".obs;
  RxString market = "".obs;
  var cropImages = {}.obs;
  final prefs = AppPreferences();
  final _api = MarketPriceViewModel();
  final marketData = MarketPriceResponseModel().obs;
  final loading = false.obs;
  final rxRequestStatus = Status.LOADING.obs;

  void setRxRequestStatus(Status value) => rxRequestStatus.value = value;
  void setRxRequestData(MarketPriceResponseModel value) =>
      marketData.value = value;

  Future<void> marketDataList(
      String state, String district, String market, String crop) async {
    loading.value = true;
    try {
      final response = await _api.marketData({
        "Authorization": 'Bearer ${await prefs.getUserAccessToken()}',
        "Content-Type": "application/json"
      }, state, district, market, crop);
      setRxRequestData(response);
      fetchAllCropImages();
    } catch (error) {
      print(error);
    } finally {
      loading.value = false;
    }
  }

  final _cropImg = MarketCropImgViewModel();
  final cropImgData = MarketCropImgResponseModel().obs;
  final imgloading = false.obs;
  final rxImgRequestStatus = Status.LOADING.obs;

  void setImgRxRequestStatus(Status value) => rxImgRequestStatus.value = value;
  void setImgRxRequestData(MarketCropImgResponseModel value) =>
      cropImgData.value = value;

  Future<void> fetchAllCropImages() async {
    final commodities = marketData.value.result ?? [];
    for (var commodity in commodities) {
      final commodityName = commodity.commodity ?? "";
      await marketImgData(commodityName);
    }
  }

  Future<void> marketImgData(String cropName) async {
    imgloading.value = true;
    try {
      final response = await _cropImg.marketImgData(cropName);
      if (response.hits != null && response.hits!.isNotEmpty) {
        cropImages[cropName] = response.hits![2].webformatURL;
      } else {
        cropImages[cropName] = 'assets/default_image.png';
      }
    } catch (error) {
      print(error);
      cropImages[cropName] = 'assets/default_image.png';
    } finally {
      imgloading.value = false;
    }
  }
}
