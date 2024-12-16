import 'package:farm_easy/Screens/Dashboard/controller/current_location_controller.dart';
import 'package:farm_easy/Screens/WeatherScreen/Model/CurrentWeatherResponseModel.dart';
import 'package:farm_easy/Screens/WeatherScreen/ViewModel/weather_view_model.dart';
import 'package:farm_easy/API/Services/network/status.dart';
import 'package:farm_easy/utils/SharedPreferences/shared_preferences.dart';
import 'package:get/get.dart';

class CurrentWeatherController extends GetxController {
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    currentWeather();
  }

  final _api = CurrentWeatherViewModel();
  final currentWeatherData = CurrentWeatherResponseModel().obs;
  final loading = true.obs;
  final titleText = "".obs;
  RxString weatherKey = "a790a08f1a23d0c5210f148bebc147da".obs;
  final rxRequestStatus = Status.LOADING.obs;
  final currentLocation = Get.put(CurrentLocation());
  void setRxRequestStatus(Status _value) => rxRequestStatus.value = _value;
  void setRxRequestData(CurrentWeatherResponseModel _value) =>
      currentWeatherData.value = _value;
  void currentWeather() {
    _api
        .currentWeather(currentLocation.lat.value, currentLocation.long.value,
            weatherKey.value)
        .then((value) {
      loading.value = false;
      setRxRequestData(value);
    }).onError((error, stackTrace) {
      print(error);
      loading.value = false;
      print("errors Comming");
    });
  }
}
