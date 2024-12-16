import 'package:farm_easy/ApiUrls/api_urls.dart';
import 'package:farm_easy/Screens/LandSection/MatchingAgriProvider/Model/MatchingAgriProviderResponseModel.dart';
import 'package:farm_easy/Services/network/network_api_services.dart';

class MatchingAgriServiceViewModel {
  final _apiServices = NetworkApiServices();
  Future<MatchingAgriProviderResponseModel> matchingAgriProvider(
      var headerMap, int id, int distance) async {
    dynamic response = await _apiServices.getApi(
        ApiUrls.GET_MATCHING_AGRIPROVIDER + "$id&distance=$distance",
        true,
        headerMap);
    return MatchingAgriProviderResponseModel.fromJson(response);
  }
}
