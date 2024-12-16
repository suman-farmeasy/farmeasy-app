import 'package:farm_easy/API/ApiUrls/api_urls.dart';
import 'package:farm_easy/Screens/UserProfile/Model/ReviewResponseMdoel.dart';
import 'package:farm_easy/Screens/UserProfile/Model/UserDetailsResponseModel.dart';
import 'package:farm_easy/API/Services/network/network_api_services.dart';

class UserProfileDetailsViewModel {
  final _apiservices = NetworkApiServices();
  Future<UserDetailsResponseModel> usrDetails(
      var heraderMap, int userId, String userType) async {
    dynamic response = await _apiservices.getApi(
        ApiUrls.USER_DETAILS + "$userId&user_type=$userType", true, heraderMap);
    return UserDetailsResponseModel.fromJson(response);
  }
}

class ReviewCreateViewModel {
  final _apiservices = NetworkApiServices();
  Future<ReviewResponseMdoel> reviewUser(
    var data,
    var heraderMap,
  ) async {
    dynamic response =
        await _apiservices.postApi(ApiUrls.REVIEW_POST, data, true, heraderMap);
    return ReviewResponseMdoel.fromJson(response);
  }
}
