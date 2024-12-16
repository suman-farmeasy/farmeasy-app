import 'package:farm_easy/ApiUrls/api_urls.dart';
import 'package:farm_easy/Screens/Auth/Role%20Selection/Model/UserTypeResponseModel.dart';
import 'package:farm_easy/Services/network/network_api_services.dart';

class UserTypeViewModel{
  final _userTypeServices= NetworkApiServices();
  Future<UserTypeResponseModel>userData(var data, var headerMap) async{
    dynamic response = await _userTypeServices.patchApi(ApiUrls.USER_TYPE, data, true, headerMap);
    return UserTypeResponseModel.fromJson(response);
  }
}