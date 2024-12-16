import 'package:farm_easy/ApiUrls/api_urls.dart';
import 'package:farm_easy/Screens/Auth/UserResgister/Model/AgriProviderResponseModel.dart';
import 'package:farm_easy/Screens/Auth/UserResgister/Model/service_area_response_model.dart';
import 'package:farm_easy/Screens/Partners/Model/services_model.dart';
import 'package:farm_easy/Services/network/network_api_services.dart';

class AgriProviderViewModel {
  final _agriService = NetworkApiServices();
  Future<AgriProviderResponseModel> agriProvider() async {
    dynamic response =
        await _agriService.getApi(ApiUrls.PARTNER_SERVICES, false, {});
    return AgriProviderResponseModel.fromJson(response);
  }
}

class AgriProvideServicesListViewModel {
  final _agriService = NetworkApiServices();
  Future<ListPartnerServices> agriProvider() async {
    dynamic response =
        await _agriService.getApi(ApiUrls.PARTNER_SERVICES, false, {});
    return ListPartnerServices.fromJson(response);
  }
}

class ServiceAreaViewModel {
  final _agriService = NetworkApiServices();
  Future<ServiceableAreaResponseModel> agriProvider(String url) async {
    dynamic response = await _agriService.getApi(url, false, {});
    return ServiceableAreaResponseModel.fromJson(response);
  }
}
