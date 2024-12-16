import 'package:farm_easy/ApiUrls/api_urls.dart';
import 'package:farm_easy/Screens/Auth/EmailLogin/Model/EmailResponseModel.dart';
import 'package:farm_easy/Services/network/network_api_services.dart';

class EmailViewModel{
  final _emailVerify= NetworkApiServices();
  Future<EmailResponseModel>emailData(var data)async{
    dynamic response= await _emailVerify.postApi(ApiUrls.SEND_OTP, data, false,
        {});
    return EmailResponseModel.fromJson(response);
  }
}