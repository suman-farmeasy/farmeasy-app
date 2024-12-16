import 'package:farm_easy/API/ApiUrls/api_urls.dart';
import 'package:farm_easy/Screens/MoreSection/Model/delete_account_response_model.dart';
import 'package:farm_easy/API/Services/network/network_api_services.dart';

class DeleteAccountViewModel {
  final _apiServices = NetworkApiServices();
  Future<DeleateAccountResponseModel> deleteAccount(
    var headerMap,
  ) async {
    dynamic response =
        await _apiServices.deleteApi(ApiUrls.DELETE_ACCOUNT, true, headerMap);
    return DeleateAccountResponseModel.fromJson(response);
  }
}
