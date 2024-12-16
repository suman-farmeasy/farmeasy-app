import 'package:farm_easy/API/ApiUrls/api_urls.dart';
import 'package:farm_easy/Screens/LandSection/LandDetails/Enquiries/Model/EnquiriesListResponseModel.dart';
import 'package:farm_easy/API/Services/network/network_api_services.dart';

class EnquiriesViewModel {
  final _apiServices = NetworkApiServices();
  Future<EnquiriesListResponseModel> enquiriesList(
      var headerMap, int id, int pageCount) async {
    dynamic response = await _apiServices.getApi(
        ApiUrls.ENQUIRIES_LIST + '$id&page=$pageCount', true, headerMap);
    return EnquiriesListResponseModel.fromJson(response);
  }
}
