import 'package:farm_easy/ApiUrls/api_urls.dart';
import 'package:farm_easy/Screens/HomeScreen/ProfielSection/Model/ProfilePercentageResponseModel.dart';
import 'package:farm_easy/Services/network/network_api_services.dart';
import 'package:get/get.dart';

class ProfileCompleteViewModel{
  final _api = NetworkApiServices();
  Future<ProfilePercentageResponseModel>profilePercentage(var headerMap) async{
    dynamic response= await _api.getApi(ApiUrls.PROFILE_COMPLETE_PERCENTAGE, true, headerMap);
    return ProfilePercentageResponseModel.fromJson(response);
  }
}