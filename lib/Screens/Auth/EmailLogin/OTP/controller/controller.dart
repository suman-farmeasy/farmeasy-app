import 'dart:async';

import 'package:farm_easy/Constants/custom_snackbar.dart';
import 'package:farm_easy/Screens/Auth/EmailLogin/OTP/Model/EmailOtpResponseModel.dart';
import 'package:farm_easy/Screens/Auth/EmailLogin/OTP/ViewModel/email_view_model.dart';
import 'package:farm_easy/Screens/Auth/Role%20Selection/View/role_selection.dart';
import 'package:farm_easy/Screens/Auth/UserResgister/View/user_registration.dart';
import 'package:farm_easy/Screens/Dashboard/view/dashboard.dart';
import 'package:farm_easy/Screens/SplashScreen/Model/IsUserExist.dart';
import 'package:farm_easy/Screens/SplashScreen/ViewModel/is_user_exist_view_model.dart';
import 'package:farm_easy/Services/network/status.dart';
import 'package:farm_easy/SharedPreferences/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EmailOtpScreenController extends GetxController {
  var isOtpComplete = false.obs;
  var timerSecondsRemaining = 30.obs;
  late Timer _timer;
  String email = "";
  final AppPreferences _prefs = AppPreferences();
  final RxBool timerFinished = false.obs;
  final RxBool isVisible = true.obs;
  RxString otpValue = "".obs;
  FocusNode focusNode = FocusNode();
  @override
  void onInit() {
    super.onInit();
    startTimer();
    focusNode.requestFocus();
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

  final _api = EmailOtpViewModel();
  final loading = false.obs;
  final authData = EmailOtpResponseModel().obs;
  final rxRequestStatus = Status.LOADING.obs;
  void setRequestStatus(Status _value) => rxRequestStatus.value = _value;
  void setAuthData(EmailOtpResponseModel _value) => authData.value = _value;
  void varify() {
    loading.value = true;
    _api.emailOtpData({"email": "$email", "otp": otpValue.value}).then(
        (value) async {
      loading.value = false;
      setRequestStatus(Status.SUCCESS);
      setAuthData(value);
      // Get.snackbar(
      //   'Message',
      //   '${value.detail.obs}',
      //   snackPosition: SnackPosition.TOP,
      //   duration: Duration(seconds: 3),
      //   colorText: Colors.black,
      //   instantInit: true,
      //   backgroundGradient: AppColor.PRIMARY_GRADIENT,
      //   maxWidth: double.infinity,
      // );
      _prefs.setUserAccessToken(value.result?.access ?? "");
      _prefs.setUserRefreshToken(value.result?.refresh ?? "");
      if (await _prefs.getUserRefreshToken() != "") {
        _prefs.setIsUserLoggedIn();
      }
      await isUserExist();
    }).onError((error, stackTrace) async {
      showErrorCustomSnackbar(
        title: "Message",
        message: 'Invalid OTP',
      );

      loading.value = false;
      Status.ERROR.obs;
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
      Get.offAll(DashBoard());
    } else if (userData.value.result!.isUserType == true &&
        userData.value.result!.isProfile == false) {
      Get.offAll(UserRegistration(userType: "${await _prefs.getUserRole()}"));
    } else {
      Get.offAll(RoleSelection());
    }
  }
}
