import 'dart:convert';

import 'package:farm_easy/API/ApiUrls/api_urls.dart';
import 'package:farm_easy/Screens/ChatSection/Controller/chat_controller.dart';
import 'package:http/http.dart' as http;
import 'package:farm_easy/Screens/ChatSection/Model/SendMessageResponseModel.dart';
import 'package:farm_easy/Screens/ChatSection/ViewModel/chat_view_model.dart';
import 'package:farm_easy/API/Services/network/status.dart';
import 'package:farm_easy/Utils/SharedPreferences/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class SendMessageController extends GetxController {
  final sendMessageController = TextEditingController().obs;
  final _api = SendMessageViewModel();
  final sendMessage = SendMessageResponseModel().obs;
  RxInt landId = 0.obs;
  RxInt userId = 0.obs;

  final loading = false.obs;
  final _prefs = AppPreferences();
  final chatList = Get.put(ChatController());
  RxList messages = [].obs;
  FocusNode? focusController;

  final rxRequestStatus = Status.LOADING.obs;
  void setRxRequestStatus(Status _value) => rxRequestStatus.value = _value;
  void setRxRequestData(SendMessageResponseModel _value) =>
      sendMessage.value = _value;
  void sendmessage() async {
    await sendMsg();
    sendMessageController.value.clear();

    print("=====================${chatList.enquiryId.value}");
  }

  Future getImage(ImageSource source) async {
    final ImagePicker picker = ImagePicker();
    final image = await picker.pickImage(source: source);

    if (image != null) {
      String imagePath = image.path.toString();
      uploadImage(imagePath);
    }
  }
  // chatList.enquiryId.value=sendMessage.value.result?.enquiryId?.toInt()??0;

  Future<void> uploadImage(String imagePath) async {
    String? accessToken = await _prefs.getUserAccessToken();
    try {
      final url = Uri.parse("${ApiUrls.SEND_MESSGAE}");
      final request = http.MultipartRequest('POST', url);
      request.files.add(
        await http.MultipartFile.fromPath('media', imagePath),
      );
      request.headers['Authorization'] = 'Bearer $accessToken';
      if (landId.value != 0) {
        request.fields['land_id'] = '${landId.value}';
      }
      request.fields['user_id'] = '${userId.value}';
      print('Sending image upload request...');

      final response = await request.send();
      print('Response status code: ${response.statusCode}');
      print("=====================================${userId.value}");
      if (response.statusCode == 200) {
        final responseBody = await response.stream.bytesToString();
        print('Image uploaded successfully.');
        final jsonResponse = json.decode(responseBody);
        final result = jsonResponse['result'];
        final enquiryId = result['enquiry_id'];
        print("===============================${enquiryId}");
        chatList.enquiryId.value = enquiryId ?? 0;
        chatList.chatsData();
      } else {
        print('Error uploading image: ${response.reasonPhrase}');
        print("===============================${landId.value}");
        print(url);
      }
    } catch (e) {
      print('Error uploading image: $e');
    }
  }

  Future<void> sendMsg() async {
    loading.value = true;
    _api.sendMessage(
        {
          "Authorization": 'Bearer ${await _prefs.getUserAccessToken()}',
          "Content-Type": "application/json"
        },
        jsonEncode({
          "content": sendMessageController.value.text,
          "land_id": landId.value,
          "user_id": userId.value,
        })).then((value) {
      loading.value = false;
      setRxRequestData(value);
      chatList.enquiryId.value =
          sendMessage.value.result?.enquiryId?.toInt() ?? 0;
      chatList.chatsData();
    }).onError((error, stackTrace) {});
  }
}
