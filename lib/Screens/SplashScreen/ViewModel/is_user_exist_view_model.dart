import 'package:farm_easy/API/ApiUrls/api_urls.dart';
import 'package:farm_easy/Screens/SplashScreen/Model/IsUserExist.dart';
import 'package:farm_easy/Screens/SplashScreen/Model/forceUpdateModel.dart';
import 'package:farm_easy/API/Services/network/network_api_services.dart';

class IsUserExistViewModel {
  final _api = NetworkApiServices();
  Future<IsUserExist> isUserExist(var headerMap) async {
    dynamic response =
        await _api.getApi(ApiUrls.IS_USER_EXIST, true, headerMap);
    return IsUserExist.fromJson(response);
  }
}

class SplashViewModel {
  final _api = NetworkApiServices();
  Future<ForceUpdateModel> forceUpdate(
    String platform,
  ) async {
    dynamic response =
        await _api.getApi(ApiUrls.FORCE_UPDATE + '$platform', false, {});
    return ForceUpdateModel.fromJson(response);
  }
}
