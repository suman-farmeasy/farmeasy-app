import 'package:farm_easy/API/ApiUrls/api_urls.dart';
import 'package:farm_easy/Screens/Auth/UserResgister/Model/AgriProviderResponseModel.dart';
import 'package:farm_easy/Screens/Auth/UserResgister/Model/service_area_response_model.dart';
import 'package:farm_easy/API/Services/network/network_api_services.dart';

class AgriProviderViewModel {
  final _agriService = NetworkApiServices();
  Future<AgriProviderResponseModel> agriProvider() async {
    dynamic response =
        await _agriService.getApi(ApiUrls.PARTNER_SERVICES, false, {});
    return AgriProviderResponseModel.fromJson(response);
  }
}

class ServiceAreaViewModel {
  final _agriService = NetworkApiServices();
  Future<ServiceableAreaResponseModel> agriProvider() async {
    dynamic response =
        await _agriService.getApi(ApiUrls.SERVICE_AREA, false, {});
    return ServiceableAreaResponseModel.fromJson(response);
  }
}
