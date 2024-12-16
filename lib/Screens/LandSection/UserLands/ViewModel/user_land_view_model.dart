import 'package:farm_easy/ApiUrls/api_urls.dart';
import 'package:farm_easy/Screens/Directory/Model/AllLandResponseModel.dart';
import 'package:farm_easy/Services/network/network_api_services.dart';

class UserLandListViewModel {
  final _api = NetworkApiServices();
  Future<AllLandResponseModel> listlands(
    int userId,
    int currentPage,
    String searchData,
    var headerMap,
  ) async {
    dynamic response = await _api.getApi(
        ApiUrls.LIST_USER_LANDS + '$userId&page=$currentPage', true, headerMap);
    return AllLandResponseModel.fromJson(response);
  }
}
