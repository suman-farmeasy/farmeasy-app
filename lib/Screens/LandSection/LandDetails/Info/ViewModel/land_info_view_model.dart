import 'package:farm_easy/ApiUrls/api_urls.dart';
import 'package:farm_easy/Screens/LandSection/LandDetails/Info/Model/ChatGptCropSuggestionResponseModel.dart';
import 'package:farm_easy/Screens/LandSection/LandDetails/Info/Model/CheckLandDetailsResponseModel.dart';
import 'package:farm_easy/Screens/LandSection/LandDetails/Info/Model/CropSuggestionResponseModel.dart';
import 'package:farm_easy/Screens/LandSection/LandDetails/Info/Model/LandDetailsResponseModel.dart';
import 'package:farm_easy/Screens/LandSection/LandDetails/Info/Model/LandImageResponseModel.dart';
import 'package:farm_easy/Screens/LandSection/LandDetails/Info/Model/LandPercentageResponseModel.dart';
import 'package:farm_easy/Screens/LandSection/LandDetails/Info/Model/LandTypeResponseModel.dart';
import 'package:farm_easy/Screens/LandSection/LandDetails/Info/Model/LandUpdateResponseModel.dart';
import 'package:farm_easy/Screens/LandSection/LandDetails/Info/Model/WaterResourceResponseModel.dart';
import 'package:farm_easy/Services/network/network_api_services.dart';

class LandDetailViewModel{
  final _infoService = NetworkApiServices();
  Future<LandDetailsResponseModel>landInfo(var headerMap,int id)async{
    dynamic response = await _infoService.getApi(ApiUrls.GET_LAND_DETAILS+"${id}", true, headerMap,);
    return LandDetailsResponseModel.fromJson(response);
  }
}

class CheckLandDetailsViewMOdel{
  final _api= NetworkApiServices();
  Future<CheckLandDetailsResponseModel>landDetails(var headerMap, int id)async{
    dynamic response = await _api.getApi(ApiUrls.CHECK_LAND_DETAILS+'$id', true, headerMap);
    return CheckLandDetailsResponseModel.fromJson(response);

  }
}
class LandTypeViewModel {
  final _api = NetworkApiServices();

  Future<LandTypeResponseModel> landType() async {
    dynamic response = await _api.getApi(ApiUrls.LAND_TYPE, false, {});
    return LandTypeResponseModel.fromJson(response);
  }
}
  class WaterResourceViewModel{
  final _api= NetworkApiServices();
  Future<WaterResourceResponseModel>waterResource()async{
  dynamic response = await _api.getApi(ApiUrls.WATER_RTESOURCE, false , {});
  return WaterResourceResponseModel.fromJson(response);

  }
}

class UpdateLandDetailsViewModel{
  final _api = NetworkApiServices();
  Future<LandUpdateResponseModel>landUpdate(var headerMap, int id,var data)async{
    dynamic response = await _api.patchApi(ApiUrls.LAND_DETAILS_UPDATE+'$id', data, true, headerMap);
    return LandUpdateResponseModel.fromJson(response);
  }
}
class UploadLandImagesViewModel{
  final _api = NetworkApiServices();
  Future<LandImageResponseModel>imgUpdate( var headerMap, var data )async{
    dynamic response = await _api.patchApi(ApiUrls.UPDATE_LAND_IMAGES, data, true, headerMap);
    return LandImageResponseModel.fromJson(response);
  }
}
class LandPercentageViewModel{
  final _api = NetworkApiServices();
  Future<LandPercentageResponseModel>landPercentage( var headerMap, int id )async{
    dynamic response = await _api.getApi(ApiUrls.LAND_PERCENTAGE+'$id', true, headerMap);
    return LandPercentageResponseModel.fromJson(response);
  }
}

 class CropSuggestionViewModel{
  final _api = NetworkApiServices();
  Future<CropSuggestionResponseModel>cropSuggestionList( var headerMap,int landId) async{
    dynamic response = await _api.getApi(ApiUrls.CROP_SUGGESTION+'$landId', true, headerMap);
    return CropSuggestionResponseModel.fromJson(response);
  }
 }
class ChatGPTCropSuggestionViewModel{
  final _api = NetworkApiServices();
  Future<ChatGptCropSuggestionResponseModel>cropSuggestionList( var headerMap,String city, String state, String country) async{
    dynamic response = await _api.getApi(ApiUrls.SUGGEST_CROP+'city=$city&state=$state&country=$country', true, headerMap);
    return ChatGptCropSuggestionResponseModel.fromJson(response);
  }
}