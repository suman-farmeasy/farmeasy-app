import 'package:farm_easy/ApiUrls/api_urls.dart';
import 'package:farm_easy/Screens/WeatherScreen/Model/CurrentWeatherResponseModel.dart';
import 'package:farm_easy/Screens/WeatherScreen/Model/WeatherForecastResponseModel.dart';
import 'package:farm_easy/Services/network/network_api_services.dart';

class CurrentWeatherViewModel{
  final _api = NetworkApiServices();
  Future<CurrentWeatherResponseModel>currentWeather(double latitude, double longitude, String key)async{
    dynamic response = await _api.getApi(ApiUrls.CURRENT_WEATHER_API+'lat=$latitude&lon=$longitude&appid=$key&units=metric', false , {});
    return CurrentWeatherResponseModel.fromJson(response);
  }
}
class WeatherForecastViewModel{
  final _api = NetworkApiServices();
  Future<WeatherForecastResponseModel>weatherForecast(double latitude, double longitude, String key)async{
    dynamic response = await _api.getApi(ApiUrls.WEATHER_FORECAST+'lat=$latitude&lon=$longitude&appid=$key&cnt=8&units=metric', false , {});
    return WeatherForecastResponseModel.fromJson(response);
  }
}