import 'package:farm_easy/ApiUrls/api_urls.dart';
import 'package:farm_easy/Screens/AllEnquiries/Model/AllEnquiriesResponseModel.dart';
import 'package:farm_easy/Services/network/network_api_services.dart';

class AllEnquiriesViewModel{
  final _addLand = NetworkApiServices();
  Future<AllEnquiriesResponseModel>allEnquiries(var headerMap, int currentPage ) async{
    dynamic response = await _addLand.getApi(ApiUrls.ALL_ENQUIRIES+'?page=$currentPage',  true, headerMap);
    return AllEnquiriesResponseModel.fromJson(response);
  }
}