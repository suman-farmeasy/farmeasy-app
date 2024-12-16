import 'package:farm_easy/ApiUrls/api_urls.dart';
import 'package:farm_easy/Screens/LandSection/LandAdd/Model/AddLandResponseModel.dart';
import 'package:farm_easy/Screens/LandSection/LandAdd/Model/CropResponseModel.dart';
import 'package:farm_easy/Screens/LandSection/LandAdd/Model/LandPurposeResponse.dart';

import 'package:farm_easy/Services/network/network_api_services.dart';

class PurposeViewModel{
  final _purpose = NetworkApiServices();
   Future<LandPurposeResponse>purposeData()async{
     dynamic response = await _purpose.getApi(ApiUrls.PURPOSE_LIST,false,
         {});
     return LandPurposeResponse.fromJson(response);
   }
}

class CroupViewModel{
  final _cropServices = NetworkApiServices();
  Future<CropResponseModel>cropData() async{
    dynamic response = await _cropServices.getApi(ApiUrls.CROP_LIST,false, {});
    return CropResponseModel.fromJson(response);
  }
}
class AddLandViewModel{
  final _addLand = NetworkApiServices();
  Future<AddLandResponseModel>addLand(var data ,var headerMap) async{
    dynamic response = await _addLand.postApi(ApiUrls.ADD_LAND, data, true, headerMap);
    return AddLandResponseModel.fromJson(response);
  }
}