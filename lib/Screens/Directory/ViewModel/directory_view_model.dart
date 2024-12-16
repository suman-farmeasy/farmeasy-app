import 'package:farm_easy/API/ApiUrls/api_urls.dart';
import 'package:farm_easy/Screens/Directory/Model/AllLandResponseModel.dart';
import 'package:farm_easy/Screens/Directory/Model/ListLandOwnerResponseModel.dart';
import 'package:farm_easy/API/Services/network/network_api_services.dart';

class ListLandOwnerViewModel {
  final _api = NetworkApiServices();
  Future<ListLandOwnerResponseModel> listLandOwner(
    int currentPage,
    String searchWord,
    var headerMap,
  ) async {
    dynamic response = await _api.getApi(
        ApiUrls.LIST_LAND_OWNER + 'page=$currentPage&search=$searchWord',
        true,
        headerMap);
    return ListLandOwnerResponseModel.fromJson(response);
  }
}

class ListAllLandViewModel {
  final _api = NetworkApiServices();
  Future<AllLandResponseModel> listlands(
    int currentPage,
    String searchData,
    var headerMap,
  ) async {
    dynamic response = await _api.getApi(
        ApiUrls.LIST_ALL_LAND + '$currentPage&search=$searchData',
        true,
        headerMap);
    return AllLandResponseModel.fromJson(response);
  }
}
