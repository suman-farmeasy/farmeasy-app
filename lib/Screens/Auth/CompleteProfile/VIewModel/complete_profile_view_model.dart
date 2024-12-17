import 'package:farm_easy/API/ApiUrls/api_urls.dart';
import 'package:farm_easy/Screens/Auth/CompleteProfile/Model/EducationListResponseModel.dart';
import 'package:farm_easy/Screens/Auth/CompleteProfile/Model/GetProfileResponseModel.dart';
import 'package:farm_easy/Screens/Auth/CompleteProfile/Model/UpdateProfileResponseModel.dart';
import 'package:farm_easy/API/Services/network/network_api_services.dart';

class GetProfileDetailsViewModel {
  final _api = NetworkApiServices();
  Future<GetProfileResponseModel> getProfile(headerMap) async {
    dynamic response =
        await _api.getApi(ApiUrls.GET_PROFILE_DETAILS, true, headerMap);
    return GetProfileResponseModel.fromJson(response);
  }
}

class UpdateProfileViewModel {
  final _api = NetworkApiServices();
  Future<UpdateProfileResponseModel> updateProfile(
      var headerMap, var data) async {
    dynamic response =
        await _api.patchApi(ApiUrls.UPDATE_PROFILE, data, true, headerMap);
    return UpdateProfileResponseModel.fromJson(response);
  }
}

class EducationListViewModel {
  final _api = NetworkApiServices();
  Future<EducationListResponseModel> getEducationData(String search) async {
    dynamic response =
        await _api.getApi('${ApiUrls.EDUCATION_LIST}$search', false, {});
    return EducationListResponseModel.fromJson(response);
  }
}
