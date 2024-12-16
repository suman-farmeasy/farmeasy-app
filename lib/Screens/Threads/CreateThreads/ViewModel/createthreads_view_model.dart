import 'package:farm_easy/ApiUrls/api_urls.dart';
import 'package:farm_easy/Screens/Threads/CreateThreads/Model/ListTagsResponseModel.dart';
import 'package:farm_easy/Screens/Threads/CreateThreads/Model/ThreadCreatedResponseModel.dart';
import 'package:farm_easy/Screens/Threads/CreateThreads/Model/ThreadsImageResponseModel.dart';
import 'package:farm_easy/Services/network/network_api_services.dart';


class CreateThreadsViewModel{
  final _api = NetworkApiServices();
  Future<ThreadCreatedResponseModel> createThread(var data, var headerMap)async{
    dynamic response = await _api.postApi(ApiUrls.CREATE_THREADS, data,true, headerMap);
    return ThreadCreatedResponseModel.fromJson(response);
  }
}

class ListTagsViewModel{
  final _api = NetworkApiServices();
  Future<ListTagsResponseModel>listTags()async{
    dynamic response = await _api.getApi(ApiUrls.TAGS_LIST, false, {});
    return ListTagsResponseModel.fromJson(response);
  }
}
class ThreadImageViewModel{
  final _api = NetworkApiServices();
  Future<ThreadsImageResponseModel>listTags(var headerMap)async{
    dynamic response = await _api.getApi(ApiUrls.THREAD_IMAGE, true, headerMap);
    return ThreadsImageResponseModel.fromJson(response);
  }
}