import 'package:farm_easy/API/ApiUrls/api_urls.dart';
import 'package:farm_easy/Screens/Auth/UserResgister/Model/CreateUserResponseModel.dart';
import 'package:farm_easy/API/Services/network/network_api_services.dart';

class CreateUserViewModel {
  final _apiServices = NetworkApiServices();
  Future<CreateUserResponseModel> userTypeData(var data, var headerMap) async {
    dynamic response = await _apiServices.postApi(
        ApiUrls.CREATE_PROFILE, data, true, headerMap);
    return CreateUserResponseModel.fromJson(response);
  }
}
