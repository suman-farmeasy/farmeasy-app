import 'package:farm_easy/ApiUrls/api_urls.dart';
import 'package:farm_easy/Screens/LandSection/MatchingFarmer/Model/MatchingFarmerResponseModel.dart';
import 'package:farm_easy/Services/network/network_api_services.dart';

class MatchingFarmerViewModel {
  final _api = NetworkApiServices();
  Future<MatchingFarmerResponseModel> matchingFarmerData(
      var headerMap, int id, int distance) async {
    dynamic response = await _api.getApi(
      ApiUrls.GET_MATCHING_FARMER + "$id&distance=$distance",
      true,
      headerMap,
    );
    return MatchingFarmerResponseModel.fromJson(response);
  }
}
