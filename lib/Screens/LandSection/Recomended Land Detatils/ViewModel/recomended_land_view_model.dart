import 'package:farm_easy/API/ApiUrls/api_urls.dart';
import 'package:farm_easy/Screens/LandSection/Recomended%20Land%20Detatils/Model/RecommendedLandDetailsResponseModel.dart';
import 'package:farm_easy/API/Services/network/network_api_services.dart';
import 'package:flutter/cupertino.dart';

class RecomendedLandDetailsViewModel {
  final _api = NetworkApiServices();
  Future<RecommendedLandDetailsResponseModel> landDetails(
      var headerMap, int id) async {
    dynamic response = await _api.getApi(
        ApiUrls.RECOMENDED_LAND_DETAILS + '$id', true, headerMap);
    return RecommendedLandDetailsResponseModel.fromJson(response);
  }
}
