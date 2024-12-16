import 'package:farm_easy/API/ApiUrls/api_urls.dart';
import 'package:farm_easy/Screens/Auth/LoginPage/OTP/Model/PhoneOtpResponseModel.dart';

import 'package:farm_easy/API/Services/network/network_api_services.dart';

class PhoneOtpViewModel {
  final _phoneOtpServices = NetworkApiServices();
  Future<PhoneOtpResponseModel> phoneOtpData(var data) async {
    dynamic response =
        await _phoneOtpServices.postApi(ApiUrls.VERIFY_OTP, data, false, {});
    return PhoneOtpResponseModel.fromJson(response);
  }
}
