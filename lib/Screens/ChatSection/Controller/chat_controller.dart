import 'package:farm_easy/Screens/ChatSection/Model/ChatsResponseModel.dart';
import 'package:farm_easy/Screens/ChatSection/ViewModel/chat_view_model.dart';
import 'package:farm_easy/API/Services/network/status.dart';
import 'package:farm_easy/utils/SharedPreferences/shared_preferences.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class ChatController extends GetxController {
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    chatsData();
    scrollController = ScrollController();
    scrollController.addListener(scrollListener);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    scrollController.removeListener(scrollListener);
    scrollController.dispose();
  }

  void scrollListener() {
    if (scrollController.position.pixels ==
        scrollController.position.minScrollExtent) {
      loadMoreData();
    }
  }

  void loadMoreData() {
    if (!loading.value &&
        currentPage.value <
            chatData.value.result!.pageInfo!.totalPage!.toInt()) {
      currentPage.value++;
      fetchChatDataAndUpdateList();
    }
  }

  ScrollController scrollController = ScrollController();
  RxInt enquiryId = 0.obs;
  RxInt currentPage = 1.obs;
  final chatController = TextEditingController().obs;
  final _api = ChatViewModel();
  final chatData = ChatsResponseModel().obs;
  final loading = false.obs;
  final _prefs = AppPreferences();
  final rxRequestStatus = Status.LOADING.obs;
  void setRxRequestStatus(Status _value) => rxRequestStatus.value = _value;
  void setRxRequestData(ChatsResponseModel _value) => chatData.value = _value;
  Future<void> chatsData() async {
    loading.value = true;
    _api.chatData(
      {
        "Authorization": 'Bearer ${await _prefs.getUserAccessToken()}',
        "Content-Type": "application/json"
      },
      enquiryId.value,
      currentPage.value,
    ).then((value) {
      loading.value = false;
      setRxRequestData(value);
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (scrollController.hasClients) {
          scrollController.jumpTo(scrollController.position.maxScrollExtent);
        }
      });
    }).onError((error, stackTrace) {
      print(error);
      print(stackTrace);
    });
  }

  Future<void> reloadChatsData() async {
    loading.value = true;
    _api.chatData(
      {
        "Authorization": 'Bearer ${await _prefs.getUserAccessToken()}',
        "Content-Type": "application/json"
      },
      enquiryId.value,
      currentPage.value,
    ).then((value) {
      loading.value = false;
      setRxRequestData(value);
    }).onError((error, stackTrace) {
      print(error);
      print(stackTrace);
    });
  }

  Future<void> fetchChatDataAndUpdateList() async {
    try {
      // Get the initial scroll offset
      double initialScrollOffset = scrollController.position.pixels;

      // Fetch new chat data
      final value = await _api.chatData(
        {
          "Authorization": 'Bearer ${await _prefs.getUserAccessToken()}',
          "Content-Type": "application/json"
        },
        enquiryId.value,
        currentPage.value,
      );

      // Update the chat data list with the new page of messages
      chatData.update((val) {
        val!.result!.data!.addAll(value.result!.data!);
      });

      // Use a post frame callback to set the scroll position back
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (scrollController.hasClients) {
          scrollController.jumpTo(initialScrollOffset);
        }
      });
    } catch (error) {
      print(error);
    }
  }
}
