import 'package:farm_easy/ApiUrls/api_urls.dart';
import 'package:farm_easy/Screens/MyProfile/Model/ListReviewResponseModel.dart';
import 'package:farm_easy/Services/network/network_api_services.dart';

class ReviewListViewModel{
  final _apiServices = NetworkApiServices();
  Future<ListReviewResponseModel>reviewList(var headerMap,int userId)async{
    dynamic response= await _apiServices.getApi(ApiUrls.LIST_USER_REVIEW+'$userId', true, headerMap);
    return ListReviewResponseModel.fromJson(response);
  }
}