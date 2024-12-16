import 'package:farm_easy/ApiUrls/api_urls.dart';
import 'package:farm_easy/Screens/FertilizerCalculator/Model/fertilizer_calculated_model.dart';
import 'package:farm_easy/Services/network/network_api_services.dart';

class FertilizerCalculatedViewModel {
  final _apiServices = NetworkApiServices();
  Future<FertilizerCalculatedValueModel> fertilizer(
      var headerMap,
      String landSize,
      String landUnit,
      int nitrogen,
      int phosphorus,
      int potassium,
      int cropId) async {
    dynamic response = await _apiServices.getApi(
        ApiUrls.CALCULATED_FERTILIZER +
            'land_size=$landSize&land_size_unit=$landUnit&nitrogen=$nitrogen&phosphorus=$phosphorus&potassium=$potassium&crop_id=$cropId',
        true,
        headerMap);
    return FertilizerCalculatedValueModel.fromJson(response);
  }
}
