import 'package:farm_easy/API/ApiUrls/api_urls.dart';
import 'package:farm_easy/Screens/MarketPrices/Model/market_List_model.dart';
import 'package:farm_easy/Screens/MarketPrices/Model/market_crop_img_data.dart';
import 'package:farm_easy/Screens/MarketPrices/Model/market_data_response_model.dart';
import 'package:farm_easy/Screens/MarketPrices/Model/search_comodity_response_model.dart';
import 'package:farm_easy/API/Services/network/network_api_services.dart';

class MarketPriceViewModel {
  final _api = NetworkApiServices();
  Future<MarketPriceResponseModel> marketData(var headerMap, String state,
      String district, String market, String crop) async {
    dynamic response = await _api.getApi(
      ApiUrls.MARKET_DATA +
          '?state=$state&district=$district&market=$market&commodity=$crop',
      true,
      headerMap,
    );
    return MarketPriceResponseModel.fromJson(response);
  }
}

class MarketCropImgViewModel {
  final _api = NetworkApiServices();
  Future<MarketCropImgResponseModel> marketImgData(String crop) async {
    dynamic response = await _api.getApi(
      ApiUrls.MARKET_CROP_IMAGE + '$crop',
      false,
      {},
    );
    return MarketCropImgResponseModel.fromJson(response);
  }
}

class MarketListViewModel {
  final _api = NetworkApiServices();
  Future<MarketResponseModel> marketListData(
    String market,
  ) async {
    dynamic response = await _api.getApi(
      ApiUrls.MARKET_LIST + '$market',
      false,
      {},
    );
    return MarketResponseModel.fromJson(response);
  }
}

class StateListViewModel {
  final _api = NetworkApiServices();
  Future<MarketResponseModel> marketListData(
    String state,
  ) async {
    dynamic response = await _api.getApi(
      ApiUrls.STATE_LIST + '$state',
      false,
      {},
    );
    return MarketResponseModel.fromJson(response);
  }
}

class DistrictListViewModel {
  final _api = NetworkApiServices();
  Future<MarketResponseModel> marketListData(
    String state,
    String district,
  ) async {
    dynamic response = await _api.getApi(
      ApiUrls.DISTRICT_LIST + 'state=$state&search=$district',
      false,
      {},
    );
    return MarketResponseModel.fromJson(response);
  }
}

class SearchComodityListViewModel {
  final _api = NetworkApiServices();
  Future<SearchComodityResponseModel> cropListData(String search) async {
    dynamic response = await _api.getApi(
      ApiUrls.SEARCH_COMODITY + '$search',
      false,
      {},
    );
    return SearchComodityResponseModel.fromJson(response);
  }
}
