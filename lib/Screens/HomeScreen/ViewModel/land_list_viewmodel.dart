import 'package:farm_easy/API/ApiUrls/api_urls.dart';
import 'package:farm_easy/Screens/HomeScreen/Model/FCMTokenResponseModel.dart';
import 'package:farm_easy/Screens/HomeScreen/Model/FarmerListResponseModel.dart';
import 'package:farm_easy/Screens/HomeScreen/Model/LandListResponseModel.dart';
import 'package:farm_easy/Screens/HomeScreen/Model/ListAgriProviderResponseModel.dart';
import 'package:farm_easy/Screens/HomeScreen/Model/crop_details_model.dart';
import 'package:farm_easy/Screens/HomeScreen/Model/crop_fertilizer_data_model.dart';
import 'package:farm_easy/Screens/HomeScreen/Model/crop_search.dart';
import 'package:farm_easy/Screens/HomeScreen/Model/recomended_lands.dart';
import 'package:farm_easy/API/Services/network/network_api_services.dart';

class LandListViewModel {
  final _apiServices = NetworkApiServices();
  Future<LandListResponseModel> landList(var headerMap, int currentPage) async {
    dynamic response = await _apiServices.getApi(
        ApiUrls.LAND_LIST + '$currentPage', true, headerMap);
    return LandListResponseModel.fromJson(response);
  }
}

class RecomendedLandViewModel {
  final _apiServices = NetworkApiServices();
  Future<RecomendedLandResponseModel> landList(var headerMap) async {
    dynamic response =
        await _apiServices.getApi(ApiUrls.RECOMENDED_LANDS, true, headerMap);
    return RecomendedLandResponseModel.fromJson(response);
  }
}

class ListAgriProviderViewModel {
  final _apiServices = NetworkApiServices();
  Future<ListAgriProviderResponseModel> agriProvider(
      var headerMap, int currentPage, String search, int serviceId) async {
    dynamic response = await _apiServices.getApi(
        serviceId == 0
            ? ApiUrls.AGRI_SERVICE_PROVIDER + '$currentPage&search=$search'
            : ApiUrls.AGRI_SERVICE_PROVIDER +
                '$currentPage&search=$search&service=$serviceId',
        true,
        headerMap);
    return ListAgriProviderResponseModel.fromJson(response);
  }
}

class ListFarmerViewModel {
  final _apiServices = NetworkApiServices();
  Future<FarmerListResponseModel> farmer(
      var headerMap, int currentPage, String search) async {
    dynamic response = await _apiServices.getApi(
        ApiUrls.LIST_FARMER + '$currentPage&search=$search', true, headerMap);
    return FarmerListResponseModel.fromJson(response);
  }
}

class FCMTokenViewModel {
  final _apiServices = NetworkApiServices();
  Future<FcmTokenResponseModel> fcmToken(var headerMap, var data) async {
    dynamic response =
        await _apiServices.patchApi(ApiUrls.FCM_TOKEN, data, true, headerMap);
    return FcmTokenResponseModel.fromJson(response);
  }
}

class CropSearchViewModel {
  final _apiServices = NetworkApiServices();
  Future<CropSearchResponseModel> cropSearch(
      var headerMap, String search) async {
    dynamic response = await _apiServices.getApi(
        ApiUrls.SEARCH_CROP + '$search', true, headerMap);
    return CropSearchResponseModel.fromJson(response);
  }
}

class CropDetailsViewModel {
  final _apiServices = NetworkApiServices();
  Future<CropDetailsResponseModel> cropDetails(
      var headerMap, String landSize, String landSizeUnit, List cropId) async {
    String cropData = cropId.join(',');
    dynamic response = await _apiServices.getApi(
        ApiUrls.CROP_SEARCH_DETAILS +
            '$landSize&land_size_unit=$landSizeUnit&crop_ids=$cropData',
        true,
        headerMap);
    return CropDetailsResponseModel.fromJson(response);
  }
}

class CropFertilizerViewModel {
  final _apiServices = NetworkApiServices();
  Future<CropFertilizerDataModel> cropFertilizer(
      int cropId, var headerMap) async {
    dynamic response = await _apiServices.getApi(
        ApiUrls.CROP_FERTILIZER_DATA + '$cropId', true, headerMap);
    return CropFertilizerDataModel.fromJson(response);
  }
}
