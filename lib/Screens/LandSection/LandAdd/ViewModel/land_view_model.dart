import 'package:farm_easy/API/ApiUrls/api_urls.dart';
import 'package:farm_easy/Screens/LandSection/LandAdd/Model/AddLandResponseModel.dart';
import 'package:farm_easy/Screens/LandSection/LandAdd/Model/CropResponseModel.dart';
import 'package:farm_easy/Screens/LandSection/LandAdd/Model/LandPurposeResponse.dart';
import 'package:farm_easy/Screens/LandSection/LandAdd/Model/list_others_crop_response_model.dart';
import 'package:farm_easy/API/Services/network/network_api_services.dart';

class PurposeViewModel {
  final _purpose = NetworkApiServices();
  Future<LandPurposeResponse> purposeData() async {
    dynamic response = await _purpose.getApi(ApiUrls.PURPOSE_LIST, false, {});
    return LandPurposeResponse.fromJson(response);
  }
}

class CroupViewModel {
  final _cropServices = NetworkApiServices();
  Future<CropResponseModel> cropData() async {
    dynamic response = await _cropServices.getApi(ApiUrls.CROP_LIST, false, {});
    return CropResponseModel.fromJson(response);
  }
}

class GetCroupViewModel {
  final _cropServices = NetworkApiServices();
  Future<CropResponseModel> cropData(int landId, var headerMap) async {
    dynamic response = await _cropServices.getApi(
        ApiUrls.GET_CROP_LIST + '$landId', true, headerMap);
    return CropResponseModel.fromJson(response);
  }
}

class AddLandViewModel {
  final _addLand = NetworkApiServices();
  Future<AddLandResponseModel> addLand(var data, var headerMap) async {
    dynamic response =
        await _addLand.postApi(ApiUrls.ADD_LAND, data, true, headerMap);
    return AddLandResponseModel.fromJson(response);
  }
}

class ListOthersCropViewModel {
  final _addLand = NetworkApiServices();
  Future<ListOthersCropsResponseModel> cropData(
      var headerMap, String crop) async {
    dynamic response = await _addLand.getApi(
        ApiUrls.LIST_OTHERS_CROPS + '$crop', true, headerMap);
    return ListOthersCropsResponseModel.fromJson(response);
  }
}
