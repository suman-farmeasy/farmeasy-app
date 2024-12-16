import 'package:farm_easy/API/ApiUrls/api_urls.dart';
import 'package:farm_easy/Screens/LandSection/MatchingAgriProvider/Model/MatchingAgriProviderResponseModel.dart';
import 'package:farm_easy/API/Services/network/network_api_services.dart';

class MatchingAgriServiceViewModel {
  final _apiServices = NetworkApiServices();
  Future<MatchingAgriProviderResponseModel> matchingAgriProvider(
      var headerMap, int id) async {
    dynamic response = await _apiServices.getApi(
        ApiUrls.GET_MATCHING_AGRIPROVIDER + "$id", true, headerMap);
    return MatchingAgriProviderResponseModel.fromJson(response);
  }
}
