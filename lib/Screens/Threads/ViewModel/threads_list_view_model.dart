import 'package:farm_easy/ApiUrls/api_urls.dart';
import 'package:farm_easy/Screens/Threads/Model/LikeUnilkeResponseModel.dart';
import 'package:farm_easy/Screens/Threads/Model/ThreadsListResponseModel.dart';
import 'package:farm_easy/Screens/Threads/ParticularThread/Model/thread_response_model.dart';
import 'package:farm_easy/Services/network/network_api_services.dart';

class ThreadsListViewModel {
  final _api = NetworkApiServices();
  Future<ThreadListResponseModel> threadsList(
      var headerMap, List<int> tags, int currentPage) async {
    String tagsQueryParam = tags.join(',');
    dynamic response = await _api.getApi(
        ApiUrls.THREADS_LIST + '$tagsQueryParam&page=$currentPage',
        true,
        headerMap);
    return ThreadListResponseModel.fromJson(response);
  }
}

class LikeUnlikeViewModel {
  final _api = NetworkApiServices();
  Future<LikeUnilkeResponseModel> likeUnlike(var data, var headerMap) async {
    dynamic response = await _api.postApi(
      ApiUrls.LIKE_UNLIKE_THREAD,
      data,
      true,
      headerMap,
    );
    return LikeUnilkeResponseModel.fromJson(response);
  }
}

class ParticularThreadViewModel {
  final _api = NetworkApiServices();
  Future<ParticularThreadResponseModel> particularThread(
      var headerMap, int threadId) async {
    dynamic response = await _api.getApi(
      ApiUrls.PARTICULAR_THREAD + '$threadId',
      true,
      headerMap,
    );
    return ParticularThreadResponseModel.fromJson(response);
  }
}
