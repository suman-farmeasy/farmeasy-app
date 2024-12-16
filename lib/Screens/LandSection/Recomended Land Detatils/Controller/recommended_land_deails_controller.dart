import 'package:farm_easy/Screens/LandSection/Recomended%20Land%20Detatils/Controller/recommended_land_weather.dart';
import 'package:farm_easy/Screens/LandSection/Recomended%20Land%20Detatils/Model/RecommendedLandDetailsResponseModel.dart';
import 'package:farm_easy/Screens/LandSection/Recomended%20Land%20Detatils/ViewModel/recomended_land_view_model.dart';
import 'package:farm_easy/API/Services/network/status.dart';
import 'package:farm_easy/Utils/SharedPreferences/shared_preferences.dart';
import 'package:get/get.dart';

class RecommendedLandDetailsController extends GetxController {
  final _api = RecomendedLandDetailsViewModel();
  final loading = false.obs;
  final landDetails = RecommendedLandDetailsResponseModel().obs;
  RxInt landId = 0.obs;
  final rxlandDetailsLoading = Status.LOADING.obs;
  final _prefs = AppPreferences();
  void setRxlandDetails(Status _value) => rxlandDetailsLoading.value = _value;
  void setRxLandDetailsData(RecommendedLandDetailsResponseModel _value) =>
      landDetails.value = _value;
  Future getLandDetails() async {
    loading.value = true;
    _api.landDetails({
      "Authorization": 'Bearer ${await _prefs.getUserAccessToken()}',
      "Content-Type": "application/json"
    }, landId.value.toInt()).then((value) {
      loading.value = false;
      setRxLandDetailsData(value);
      final weatherController = Get.find<RecommendedLandWeatherController>();
      final latitude = double.parse(value.result!.latitude ?? '0');
      final longitude = double.parse(value.result!.longitude ?? '0');

      weatherController.currentWeather(latitude, longitude);
    }).onError((error, stackTrace) {
      loading.value = false;
    });
  }
}
