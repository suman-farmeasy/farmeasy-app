import 'package:farm_easy/ApiUrls/api_urls.dart';
import 'package:farm_easy/Screens/Threads/Replies/Model/RepliesListResponseModel.dart';
import 'package:farm_easy/Screens/Threads/Replies/Model/ReplyDataResponseModel.dart';
import 'package:farm_easy/Services/network/network_api_services.dart';

class RepliesListViewModel{
  final _api = NetworkApiServices();
  Future<RepliesListResponseModel>repliesList(var headerMap, int id, int currentPage)async{
    dynamic response = await _api.getApi(ApiUrls.REPLIES_LIST+'$id&page=$currentPage', true, headerMap, );
    return RepliesListResponseModel.fromJson(response);
  }
}
class ReplyViewModel{
  final _api = NetworkApiServices();
  Future<ReplyDataResponseModel>reply(var data,var headerMap)async{
    dynamic response = await _api.postApi(ApiUrls.REPLY_THREAD,data, true, headerMap, );
    return ReplyDataResponseModel.fromJson(response);
  }
}