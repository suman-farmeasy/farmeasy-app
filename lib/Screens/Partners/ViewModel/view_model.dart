import 'package:farm_easy/ApiUrls/api_urls.dart';
import 'package:farm_easy/Screens/Partners/Model/nearby_partner_view_mdoel.dart';
import 'package:farm_easy/Screens/Partners/Model/services_model.dart';
import 'package:farm_easy/Services/network/network_api_services.dart';

class PartnerServicesViewModel {
  final _apiServices = NetworkApiServices();
  Future<ListPartnerServices> partnerServices(
    var headerMap,
  ) async {
    dynamic response =
        await _apiServices.getApi(ApiUrls.PARTNER_SERVICES, true, headerMap);
    return ListPartnerServices.fromJson(response);
  }
}

class NearbyPartnerServicesViewModel {
  final _apiServices = NetworkApiServices();
  Future<NearbyPartnersResponseModel> nearbyPartner(
      var headerMap, int serviceId, String search) async {
    dynamic response = await _apiServices.getApi(
        serviceId != 0
            ? ApiUrls.NEARBY_PARTNER + 'service=$serviceId&search=$search'
            : ApiUrls.NEARBY_PARTNER + '&search=$search',
        true,
        headerMap);
    return NearbyPartnersResponseModel.fromJson(response);
  }
}
