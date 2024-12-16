import 'dart:async';

import 'package:farm_easy/Utils/Constants/color_constants.dart';
import 'package:farm_easy/Screens/Auth/LoginPage/OTP/Model/PhoneOtpResponseModel.dart';
import 'package:farm_easy/Screens/Auth/LoginPage/OTP/ViewModel/phone_otp_view_model.dart';
import 'package:farm_easy/Screens/Auth/UserResgister/View/user_registration.dart';
import 'package:farm_easy/Screens/Dashboard/view/dashboard.dart';
import 'package:farm_easy/Screens/SplashScreen/Model/IsUserExist.dart';
import 'package:farm_easy/Screens/SplashScreen/ViewModel/is_user_exist_view_model.dart';
import 'package:farm_easy/API/Services/network/status.dart';
import 'package:farm_easy/Utils/SharedPreferences/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../Role Selection/View/role_selection.dart';

class OtpScreenController extends GetxController {
  var isOtpComplete = false.obs;
  final RxInt timerSecondsRemaining = 30.obs;
  final RxBool timerFinished = false.obs;
  final RxBool isVisible = true.obs;
  late Timer _timer;
  String countryCode = '';
  String phoneNumber = ""; // Example phone number
  final AppPreferences _prefs = AppPreferences();
  final TextEditingController otpController =
      TextEditingController(text: "9524");

  //FocusNode focusNode = FocusNode();

  RxString otpValue = "".obs;

  @override
  void onInit() {
    super.onInit();
    // focusNode.requestFocus();
    startTimer();
  }

  void startTimer() {
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (timerSecondsRemaining.value > 0) {
        timerSecondsRemaining.value -= 1;
      } else {
        _timer.cancel();
        timerFinished.value = true;
        hideAfterDelay();
      }
    });
  }

  void hideAfterDelay() {
    Timer(Duration(seconds: 30), () {
      timerSecondsRemaining.value = 0;
    });
  }

  final _api = PhoneOtpViewModel();
  final loading = false.obs;
  final authData = PhoneOtpResponseModel().obs;
  final rxRequestStatus = Status.LOADING.obs;

  void setRequestStatus(Status _value) => rxRequestStatus.value = _value;
  void setAuthData(PhoneOtpResponseModel _value) => authData.value = _value;

  void varify() {
    loading.value = true;
    _api.phoneOtpData({
      // "country_code": "$countryCode",
      "country_code": "91",
      "mobile": "$phoneNumber",
      "otp": otpController.value.text
    }).then((value) async {
      loading.value = false;
      setRequestStatus(Status.SUCCESS);
      setAuthData(value);
      Get.snackbar(
        'Message',
        '${value.detail.obs}',
        snackPosition: SnackPosition.TOP,
        duration: Duration(seconds: 3),
        colorText: Colors.black,
        instantInit: true,
        backgroundGradient: AppColor.PRIMARY_GRADIENT,
        maxWidth: double.infinity,
      );
      _prefs.setUserAccessToken(value.result?.access ?? "");
      _prefs.setUserRefreshToken(value.result?.refresh ?? "");
      if (await _prefs.getUserRefreshToken() != "") {
        _prefs.setIsUserLoggedIn();
      }
      await isUserExist();
    }).onError((error, stackTrace) async {
      Get.snackbar(
        'Message',
        'Invalid OTP',
        snackPosition: SnackPosition.TOP,
        duration: Duration(seconds: 3),
        colorText: Colors.black,
        instantInit: true,
        backgroundGradient: AppColor.PRIMARY_GRADIENT,
        maxWidth: double.infinity,
      );

      Status.ERROR.obs;
      loading.value = false;
      print(stackTrace);
    });
  }

  final _userExist = IsUserExistViewModel();
  final userLoading = false.obs;
  final userData = IsUserExist().obs;
  final rxUserRequestStatus = Status.LOADING.obs;
  void setUserRxRequestStatus(Status _value) =>
      rxUserRequestStatus.value = _value;
  void setUserRequestData(IsUserExist _value) => userData.value = _value;

  Future isUserExist() async {
    loading.value = true;
    _userExist.isUserExist(
      {
        "Authorization": 'Bearer ${await _prefs.getUserAccessToken()}',
        "Content-Type": "application/json"
      },
    ).then((value) {
      _prefs.setUserRole(value.result?.userType ?? "");
      _prefs.setUserName(value.result?.name ?? "");
      setUserRequestData(value);
      isLogin();
    }).onError((error, stackTrace) {});
  }

  isLogin() async {
    if (userData.value.result!.isUserType == true &&
        userData.value.result!.isProfile == true) {
      Get.offAll(() => DashBoard());
    } else if (userData.value.result!.isUserType == true &&
        userData.value.result!.isProfile == false) {
      Get.offAll(UserRegistration(userType: "${await _prefs.getUserRole()}"));
    } else {
      Get.offAll(() => RoleSelection());
    }
  }

  @override
  void onClose() {
    otpController.dispose();
    //  focusNode.dispose();
    super.onClose();
  }
}
