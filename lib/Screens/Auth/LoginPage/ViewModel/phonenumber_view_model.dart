import 'package:farm_easy/ApiUrls/api_urls.dart';
import 'package:farm_easy/Screens/Auth/LoginPage/Model/PhonenumberResponseModel.dart';
import 'package:farm_easy/Services/network/network_api_services.dart';

class PhoneViewMOdel{
  final _phoneapiServices = NetworkApiServices();
 Future<PhonenumberResponseModel> phoneDetails(var data) async{
  dynamic response = await _phoneapiServices.postApi(ApiUrls.SEND_OTP, data, false,
      {});
  return PhonenumberResponseModel.fromJson(response);
 }
}