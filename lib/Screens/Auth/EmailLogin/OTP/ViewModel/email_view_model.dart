import 'package:farm_easy/API/ApiUrls/api_urls.dart';
import 'package:farm_easy/Screens/Auth/EmailLogin/OTP/Model/EmailOtpResponseModel.dart';
import 'package:farm_easy/API/Services/network/network_api_services.dart';

class EmailOtpViewModel {
  final _emailOtpServices = NetworkApiServices();
  Future<EmailOtpResponseModel> emailOtpData(var data) async {
    dynamic response =
        await _emailOtpServices.postApi(ApiUrls.VERIFY_OTP, data, false, {});
    return EmailOtpResponseModel.fromJson(response);
  }
}
