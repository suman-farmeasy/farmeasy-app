import 'package:farm_easy/API/ApiUrls/api_urls.dart';
import 'package:farm_easy/Screens/Followers/Followings/Model/FollowingListResponseModel.dart';
import 'package:farm_easy/Screens/Followers/Followings/Model/follow_unfollow_model.dart';
import 'package:farm_easy/API/Services/network/network_api_services.dart';

class FollowingListViewModel {
  final _api = NetworkApiServices();
  Future<FollowingListResponseModel> followersList(
      var headerMap, int userId, int currentPage) async {
    dynamic response = await _api.getApi(
        ApiUrls.FOLLOWING_LIST + '$userId&page=$currentPage', true, headerMap);
    return FollowingListResponseModel.fromJson(response);
  }
}

class FollowUnfollowViewModel {
  final _api = NetworkApiServices();
  Future<FollowUnfollowResponseModel> followersList(
      var headerMap, var data) async {
    dynamic response =
        await _api.postApi(ApiUrls.FOLLWO_UNFOLLOW, data, true, headerMap);
    return FollowUnfollowResponseModel.fromJson(response);
  }
}
