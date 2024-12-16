import 'package:farm_easy/ApiUrls/api_urls.dart';
import 'package:farm_easy/Screens/Auth/UserResgister/Model/FarmerExpertiesResponseModel.dart';
import 'package:farm_easy/Screens/Auth/UserResgister/Model/crops_model.dart';
import 'package:farm_easy/Services/network/network_api_services.dart';

class FarmerExpertiesViewModel {
  final _farmerApiServices = NetworkApiServices();
  Future<FarmerExpertiesResponseModel> farmerExperties() async {
    dynamic response =
        await _farmerApiServices.getApi(ApiUrls.FARMER_EXPERTIES, false, {});
    return FarmerExpertiesResponseModel.fromJson(response);
  }
}

class FarmerCropViewModel {
  final _farmerApiServices = NetworkApiServices();
  Future<FarmerCropsData> farmerCrop() async {
    dynamic response =
        await _farmerApiServices.getApi(ApiUrls.FARMER_CROPS, false, {});
    return FarmerCropsData.fromJson(response);
  }
}
