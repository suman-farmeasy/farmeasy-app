import 'package:farm_easy/ApiUrls/api_urls.dart';
import 'package:farm_easy/Screens/ChatSection/Model/ChatsResponseModel.dart';
import 'package:farm_easy/Screens/ChatSection/Model/MessageSeenResponseModel.dart';
import 'package:farm_easy/Screens/ChatSection/Model/SendMessageResponseModel.dart';
import 'package:farm_easy/Services/network/network_api_services.dart';

class ChatViewModel{
  final _api = NetworkApiServices();
  Future<ChatsResponseModel>chatData(var headermap , int id, int currentPage)async{
  dynamic response = await _api.getApi(ApiUrls.CHAT_DATA+'$id&page=$currentPage', true, headermap);
      return ChatsResponseModel.fromJson(response);
  }
}
class SendMessageViewModel{
  final _api = NetworkApiServices();
  Future<SendMessageResponseModel>sendMessage(var headerMap, var data)async{
    dynamic response = await _api.postApi(ApiUrls.SEND_MESSGAE, data, true, headerMap);
    return SendMessageResponseModel.fromJson(response);
  }
}
class IsMessageSeenViewModel{
  final _api = NetworkApiServices();
  Future<MessageSeenResponseModel>isMessageSeen(var headerMap,int id )async{
    dynamic response = await _api.putApi(ApiUrls.IS_MESSAGE_SEEN+'$id', true, headerMap);
    return MessageSeenResponseModel.fromJson(response);
  }
}