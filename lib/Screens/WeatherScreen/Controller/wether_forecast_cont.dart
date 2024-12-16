import 'package:farm_easy/Screens/Dashboard/controller/current_location_controller.dart';
import 'package:farm_easy/Screens/WeatherScreen/Model/WeatherForecastResponseModel.dart';
import 'package:farm_easy/Screens/WeatherScreen/ViewModel/weather_view_model.dart';
import 'package:farm_easy/API/Services/network/status.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class WeatherForecastController extends GetxController {
  final _api = WeatherForecastViewModel();
  final weatherForecast = WeatherForecastResponseModel().obs;
  final loading = true.obs;

  final titleText = "".obs;
  RxString weatherKey = "a790a08f1a23d0c5210f148bebc147da".obs;
  final rxRequestStatus = Status.LOADING.obs;
  final currentLocation = Get.put(CurrentLocation());

  void setRxRequestStatus(Status _value) => rxRequestStatus.value = _value;

  void setRxRequestData(WeatherForecastResponseModel _value) =>
      weatherForecast.value = _value;

  void weatherForecastData(double lat, double long) {
    _api.weatherForecast(lat, long, weatherKey.value).then((value) {
      loading.value = false;
      setRxRequestData(value);
    }).onError((error, stackTrace) {
      print(stackTrace);
      print(error);
      loading.value = false;
      print("errors Comming");
    });
  }

  // Function to convert Unix timestamp to day and date
  List<Map<String, String>> convertUnixTimestampToDayAndDate() {
    List<Map<String, String>> dayAndDateList = [];

    if (weatherForecast.value.listWeather != null) {
      weatherForecast.value.listWeather!.forEach((weather) {
        int unixTimestamp = weather.dt ?? 0;
        DateTime dateTime =
            DateTime.fromMillisecondsSinceEpoch(unixTimestamp * 1000);
        String day = DateFormat('EEEE').format(dateTime);
        String date = DateFormat('d MMM').format(dateTime);

        dayAndDateList.add({
          'day': day,
          'date': date,
        });
      });
    }

    return dayAndDateList;
  }
}
