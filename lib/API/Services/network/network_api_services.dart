import 'dart:convert';
import 'dart:io';

import 'package:farm_easy/API/Services/network/base_api_services.dart';
import 'package:farm_easy/API/Services/network/error_handler.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';

class NetworkApiServices extends BaseApiServices {
  @override
  Future getApi(String url, bool sendHeaders, var headerMap) async {
    if (kDebugMode) {
      print(
          "-----------------------------API URL-------------------------------------");
      print(url);
      print(
          "----------------******------------------------------*****----------------");
    }
    dynamic responseJson;
    try {
      final response =
          await http.get(Uri.parse(url), headers: sendHeaders ? headerMap : {});
      // if(kDebugMode){
      print(
          "-------------------------------Raw Response-----------------------------------");
      print(response);
      print(
          "----------------******------------------------------*****------------------");

      //  }
      responseJson = returnResponse(response);
    } on SocketException {
      throw InternetExceptions();
    } on RequestTimeOut {
      throw RequestTimeOut();
    }
    return responseJson;
  }

  Future deleteApi(String url, bool sendHeaders, var headerMap) async {
    if (kDebugMode) {
      print(
          "-----------------------------API URL-------------------------------------");
      print(url);
      print(
          "----------------******------------------------------*****------------------");
    }
    dynamic responseJson;
    try {
      final response = await http.delete(Uri.parse(url),
          headers: sendHeaders ? headerMap : {});
      // if(kDebugMode){
      print(
          "-------------------------------Raw Response-----------------------------------");
      print(response);
      print(
          "----------------******------------------------------*****------------------");

      //  }
      responseJson = returnResponse(response);
    } on SocketException {
      throw InternetExceptions();
    } on RequestTimeOut {
      throw RequestTimeOut();
    }
    return responseJson;
  }

  @override
  Future putApi(String url, bool sendHeaders, var headerMap) async {
    if (kDebugMode) {
      print(
          "-----------------------------API URL-------------------------------------");
      print(url);
      print(
          "----------------******------------------------------*****------------------");
    }
    dynamic responseJson;
    try {
      final response =
          await http.put(Uri.parse(url), headers: sendHeaders ? headerMap : {});
      // if(kDebugMode){
      print(
          "-------------------------------Raw Response-----------------------------------");
      print(response);
      print(
          "----------------******------------------------------*****------------------");

      //  }
      responseJson = returnResponse(response);
    } on SocketException {
      throw InternetExceptions();
    } on RequestTimeOut {
      throw RequestTimeOut();
    }
    return responseJson;
  }

  @override
  Future postApi(String url, var data, bool sendHeaders, var headerMap) async {
    if (kDebugMode) {
      print(
          "-----------------------------${data}-------------------------------------");

      print(
          "-----------------------------API URL-------------------------------------");
      print(url);
      print(
          "----------------******------------------------------*****------------------");
    }
    dynamic responseJson;
    try {
      final response = await http.post(Uri.parse(url),
          body: data, headers: sendHeaders ? headerMap : {});
      if (kDebugMode) {
        print(
            "-------------------------------Raw Response-----------------------------------");
        print(response.body);
        print(
            "----------------******------------------------------*****------------------");
      }
      responseJson = returnResponse(response);
    } on SocketException {
      throw InternetExceptions();
    } on RequestTimeOut {
      throw RequestTimeOut();
    }
    return responseJson;
  }

  @override
  Future patchApi(String url, var data, bool sendHeaders, var headerMap) async {
    if (kDebugMode) {
      print(
          "-----------------------------${data}-------------------------------------");

      print(
          "-----------------------------API URL-------------------------------------");
      print(url);
      print(
          "----------------******------------------------------*****------------------");
    }
    print(
        "=======================================$headerMap=================================");
    dynamic responseJson;
    try {
      final response = await http.patch(Uri.parse(url),
          body: data, headers: sendHeaders ? headerMap : {});
      if (kDebugMode) {
        print(
            "-------------------------------Raw Response-----------------------------------");
        print(response.body);
        print(
            "----------------******------------------------------*****------------------");
      }
      responseJson = returnResponse(response);
    } on SocketException {
      throw InternetExceptions();
    } on RequestTimeOut {
      throw RequestTimeOut();
    }
    return responseJson;
  }

  dynamic returnResponse(http.Response response) {
    switch (response.statusCode) {
      case 200:
        dynamic responseJson = jsonDecode(response.body);
        if (kDebugMode) {
          print(
              "-----------------------------Response Json-------------------------------------");
          print(responseJson);
          print(
              "----------------******------------------------------*****------------------");
        }
        return responseJson;
      case 400:
        throw InValidUrlException;
      default:
        print(response.statusCode);
        throw FetchDataException('Error while fetching data');
    }
  }

  Future uploadImage(
    String url,
    Map<String, String> headers,
    String image,
  ) async {
    print("updateAgriProviderProfileImage 1");
    final request = http.MultipartRequest('PATCH', Uri.parse(url));

    request.headers.addAll(headers);
    request.files.add(await http.MultipartFile.fromPath(
        'profile_picture', image,
        contentType: MediaType('image', 'jpeg')));

    try {
      final streamedResponse = await request.send();
      final response = await http.Response.fromStream(streamedResponse);
      print("updateAgriProviderProfileImage 2");

      if (response.statusCode == 200) {
        returnResponse(response);
      } else {
        print('Error: ${response.statusCode}');
        returnResponse(response);
      }
    } catch (error) {
      print("updateAgriProviderProfileImage 3");

      print('Error: $error');
      // returnResponse(response);
    }
  }
}
