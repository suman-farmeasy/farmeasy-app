import 'package:farm_easy/API/ApiUrls/api_urls.dart';
import 'package:farm_easy/Screens/UserProfile/Model/ReviewResponseMdoel.dart';
import 'package:farm_easy/API/Services/network/network_api_services.dart';

class AddFeedbackViewModel {
  final _apiservices = NetworkApiServices();
  Future<ReviewResponseMdoel> addFeedback(
    var data,
    var heraderMap,
  ) async {
    dynamic response = await _apiservices.postApi(
        ApiUrls.ADD_FEEDBACK, data, true, heraderMap);
    return ReviewResponseMdoel.fromJson(response);
  }
}
