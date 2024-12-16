import 'dart:convert';
import 'dart:io';

import 'package:farm_easy/ApiUrls/api_urls.dart';
import 'package:farm_easy/Screens/Auth/CompleteProfile/Controller/get_profile_controller.dart';
import 'package:farm_easy/Screens/Auth/CompleteProfile/Model/UpdateProfileResponseModel.dart';
import 'package:farm_easy/Screens/Auth/CompleteProfile/VIewModel/complete_profile_view_model.dart';
import 'package:farm_easy/Screens/Dashboard/controller/dashboard_controller.dart';
import 'package:farm_easy/Services/network/status.dart';
import 'package:farm_easy/SharedPreferences/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class UpdateProfileController extends GetxController {
  final loading = false.obs;
  final bioController = TextEditingController().obs;
  final updateData = UpdateProfileResponseModel().obs;
  final _prefs = AppPreferences();
  final _api = UpdateProfileViewModel();
  final rxRequestStatus = Status.LOADING.obs;

  void setRxRequestStatus(Status _value) => rxRequestStatus.value = _value;

  void setRxRequestData(UpdateProfileResponseModel _value) =>
      updateData.value = _value;

  RxString newName = "".obs;
  RxString mobileNumber = "".obs;
  RxString bio = "".obs;
  RxString insta = "".obs;
  RxString fb = "".obs;
  RxString twitter = "".obs;
  RxString linkdin = "".obs;
  RxInt experience = 0.obs;
  RxDouble minSalary = 20000.0.obs;
  RxDouble maxSalary = 100000.0.obs;

  void setMinSalary(double value) {
    if (value < maxSalary.value) {
      minSalary.value = value;
    }
  }

  void setMaxSalary(double value) {
    if (value > minSalary.value) {
      maxSalary.value = value;
    }
  }

  var isChecked = false.obs;

  void toggleCheckbox() {
    isChecked.value = !isChecked.value;
    print(isChecked.value);
  }

  RxInt selectedYear = 0.obs;
  RxInt selectedMonths = 0.obs;
  RxInt selectedDate = 0.obs;

  RxList<int> years = [for (int year = 00; year <= 40; year++) year].obs;
  RxList<int> months = [for (int month = 00; month <= 12; month++) month].obs;
  RxList<int> date = [for (int date = 01; date <= 31; date++) date].obs;

  Future<void> updateAgriProviderProfileImage(
    File image,
  ) async {
    loading.value = true;

    final request =
        http.MultipartRequest('PATCH', Uri.parse(ApiUrls.UPDATE_PROFILE));

    final headers = {
      'Authorization': 'Bearer ${await _prefs.getUserAccessToken()}',
      'Content-Type': 'multipart/form-data',
    };
    request.headers.addAll(headers);
    request.files.add(await http.MultipartFile.fromPath('image', image.path));

    try {
      final streamedResponse = await request.send();
      final response = await http.Response.fromStream(streamedResponse);

      if (response.statusCode == 200) {
        final responseData =
            UpdateProfileResponseModel.fromJson(json.decode(response.body));
        loading.value = false;
        setRxRequestStatus(Status.SUCCESS);
        setRxRequestData(responseData);
      } else {
        print('Error: ${response.statusCode}');
        loading.value = false;
        setRxRequestStatus(Status.ERROR);
      }
    } catch (error) {
      print('Error: $error');
      loading.value = false;
      setRxRequestStatus(Status.ERROR);
    }
  }

  Future<void> updateLandOwnerProfileImage(
    File image,
  ) async {
    loading.value = true;

    final request =
        http.MultipartRequest('PATCH', Uri.parse(ApiUrls.UPDATE_PROFILE));

    final headers = {
      'Authorization': 'Bearer ${await _prefs.getUserAccessToken()}',
      'Content-Type': 'multipart/form-data',
    };
    request.headers.addAll(headers);
    request.files.add(await http.MultipartFile.fromPath('image', image.path));

    try {
      final streamedResponse = await request.send();
      final response = await http.Response.fromStream(streamedResponse);

      if (response.statusCode == 200) {
        final responseData =
            UpdateProfileResponseModel.fromJson(json.decode(response.body));
        loading.value = false;
        setRxRequestStatus(Status.SUCCESS);
        setRxRequestData(responseData);
      } else {
        print('Error: ${response.statusCode}');
        loading.value = false;
        setRxRequestStatus(Status.ERROR);
      }
    } catch (error) {
      print('Error: $error');
      loading.value = false;
      setRxRequestStatus(Status.ERROR);
    }
  }

  Future<void> updateFarmerProfileImage(
    File image,
  ) async {
    loading.value = true;

    final request =
        http.MultipartRequest('PATCH', Uri.parse(ApiUrls.UPDATE_PROFILE));

    final headers = {
      'Authorization': 'Bearer ${await _prefs.getUserAccessToken()}',
      'Content-Type': 'multipart/form-data',
    };
    request.headers.addAll(headers);
    request.files.add(await http.MultipartFile.fromPath('image', image.path));
    try {
      final streamedResponse = await request.send();
      final response = await http.Response.fromStream(streamedResponse);

      if (response.statusCode == 200) {
        final responseData =
            UpdateProfileResponseModel.fromJson(json.decode(response.body));
        loading.value = false;
        setRxRequestStatus(Status.SUCCESS);
        setRxRequestData(responseData);
        // final dashboardControllers = Get.find<DashboardController>();
        // dashboardControllers.homecontroller.landListData();
        // Get.back();
      } else {
        print('Error: ${response.statusCode}');
        loading.value = false;
        print('Request Payload: ${request.fields}');
        setRxRequestStatus(Status.ERROR);
      }
    } catch (error) {
      print('Error: $error');
      loading.value = false;
      setRxRequestStatus(Status.ERROR);
    }
  }

  Future<void> updateLandOwnerProfile(
    String name,
    String bio,
    String profileType,
    String phoneNo,
    String insta,
    String fb,
    String twitter,
    String linkdin,
    int educationId,
  ) async {
    loading.value = true;

    final request =
        http.MultipartRequest('PATCH', Uri.parse(ApiUrls.UPDATE_PROFILE));

    final headers = {
      'Authorization': 'Bearer ${await _prefs.getUserAccessToken()}',
      'Content-Type': 'multipart/form-data',
    };
    request.headers.addAll(headers);
    if (educationId == 0) {
    } else {
      request.fields['education'] = educationId.toString();
    }
    request.fields['country_code'] = '91';
    request.fields['full_name'] = name;
    request.fields['bio'] = bio;
    request.fields['profile_type'] = profileType;

    request.fields['mobile'] = phoneNo;
    request.fields['facebook_url'] = fb;
    request.fields['instagram_url'] = insta;
    request.fields['linkedin_url'] = linkdin;
    request.fields['twitter_url'] = twitter;

    try {
      final streamedResponse = await request.send();
      final response = await http.Response.fromStream(streamedResponse);

      if (response.statusCode == 200) {
        final responseData =
            UpdateProfileResponseModel.fromJson(json.decode(response.body));
        loading.value = false;
        setRxRequestStatus(Status.SUCCESS);
        setRxRequestData(responseData);
        await _prefs.setUserName(name);
        final dashboardControllers = Get.find<DashboardController>();
        dashboardControllers.profileController.profilePercentage();
        final getProfileControllers = Get.find<GetProfileController>();
        getProfileControllers.getProfile();
        Get.back();
      } else {
        print('Error: ${response.statusCode}');

        loading.value = false;
        setRxRequestStatus(Status.ERROR);
      }
    } catch (error, stackTrace) {
      print('Stack trace: $stackTrace');
      print('Error: $error');
      loading.value = false;
      setRxRequestStatus(Status.ERROR);
    }
  }

  Future<void> updateFarmerDetails(
    String name,
    List experties,
    String bio,
    String phoneNo,
    String insta,
    String fb,
    String twitter,
    String linkdin,
    int education,
    int experience,
    int experienceYear,
    int experienceMonths,
    int minSalary,
    int maxSalary,
    bool salaryShow,
  ) async {
    loading.value = true;
    Map<String, dynamic> data = {
      'full_name': name,
      'expertise': experties.toList(),
      'bio': bio,
      'country_code': '91',
      'mobile': phoneNo,
      'facebook_url': fb,
      'instagram_url': insta,
      'linkedin_url': linkdin,
      'twitter_url': twitter,
      'education': education,
      'experience': experience,
      'experience_in_years': experienceYear,
      'experience_in_months': experienceMonths,
      'min_salary': minSalary,
      'max_salary': maxSalary,
      'is_salary_visible': salaryShow
    };
    data.removeWhere((key, value) => value == "" || value == 0);
    _api.updateProfile({
      "Authorization": 'Bearer ${await _prefs.getUserAccessToken()}',
      "Content-Type": "application/json"
    }, jsonEncode(data)).then((value) async {
      loading.value = false;
      setRxRequestData(value);
      if (newName.value != "") {
        await _prefs.setUserName(newName.value);
      }
      Get.back();
      final dashboardControllers = Get.find<DashboardController>();
      final getProfileControllers = Get.find<GetProfileController>();
      getProfileControllers.getProfile();
      dashboardControllers.profileController.profilePercentage();

      Get.back();
    }).onError((error, stackTrace) {
      print(error);
      print(stackTrace);
    });
  }

  Future<void> updateAgriServiceDetails(
      String name,
      List roles,
      String bio,
      String phoneNo,
      String insta,
      String fb,
      String twitter,
      String linkdin,
      int experience) async {
    loading.value = true;
    Map<String, dynamic> data = {
      'full_name': name,
      'roles': roles.toList(),
      'bio': bio,
      'country_code': '91',
      'mobile': phoneNo,
      'facebook_url': fb,
      'instagram_url': insta,
      'linkedin_url': linkdin,
      'twitter_url': twitter,
      'experience': experience,
    };
    data.removeWhere((key, value) => value == "" || value == 0);
    _api.updateProfile(
      {
        "Authorization": 'Bearer ${await _prefs.getUserAccessToken()}',
        "Content-Type": "application/json"
      },
      jsonEncode(data),
    ).then((value) async {
      loading.value = false;
      print("DATA:$data");
      setRxRequestData(value);
      if (newName.value != "") {
        await _prefs.setUserName(newName.value);
      }
      Get.back();
      final dashboardControllers = Get.find<DashboardController>();
      final getProfileControllers = Get.find<GetProfileController>();
      getProfileControllers.getProfile();
      dashboardControllers.profileController.profilePercentage();
      Get.back();
    }).onError((error, stackTrace) {
      print(error);
      print(stackTrace);
    });
  }
}
