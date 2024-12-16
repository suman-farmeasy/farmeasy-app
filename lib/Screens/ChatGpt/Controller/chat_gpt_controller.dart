import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart'as http;

import '../View/chat_gpt.dart';

class ChatGptController extends GetxController {
  final TextEditingController messageController = TextEditingController();
  final RxList<Message> messages = <Message>[].obs;

  void sendMessage() {
    final messageText = messageController.text;
    if (messageText.isNotEmpty) {
      messages.add(Message(messageText, isMe: true));
      messageController.clear();
      getChatGPTData(messageText);
    }
  }

  void getChatGPTData(String userMessage) async {
    final apiKey = "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"; // Replace this with your API key
    final url = Uri.parse('https://api.openai.com/v1/chat/completions');
    final headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $apiKey',
    };
    final body = jsonEncode({
      "model": "gpt-3.5-turbo-0125",
      "messages": [
        {"role": "user", "content": userMessage}
      ],
      "temperature": 0.7
    });

    final response = await http.post(url, headers: headers, body: body);

    if (response.statusCode == 200) {
      final result = jsonDecode(response.body);
      final gptResponse = result["choices"][0]["message"]["content"];
      messages.add(Message(gptResponse));
    } else {
      print("Error occurred: ${response.statusCode}");
      print("Error message: ${response.body}");
    }
  }
}