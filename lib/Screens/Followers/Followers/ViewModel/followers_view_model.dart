import 'package:farm_easy/API/ApiUrls/api_urls.dart';
import 'package:farm_easy/Screens/Followers/Followers/Model/followers_list_response_model.dart';
import 'package:farm_easy/API/Services/network/network_api_services.dart';

class FollowersListViewModel {
  final _api = NetworkApiServices();
  Future<FollowersListResponseModel> followersList(
      var headerMap, int userId, int currentPage) async {
    dynamic response = await _api.getApi(
        ApiUrls.FOLLOWERS_LIST + '$userId&page=$currentPage', true, headerMap);
    return FollowersListResponseModel.fromJson(response);
  }
}
