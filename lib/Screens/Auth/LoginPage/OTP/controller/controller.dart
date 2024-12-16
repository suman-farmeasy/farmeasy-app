import 'dart:async';

import 'package:farm_easy/Constants/custom_snackbar.dart';
import 'package:farm_easy/Screens/Auth/LoginPage/OTP/Model/PhoneOtpResponseModel.dart';
import 'package:farm_easy/Screens/Auth/LoginPage/OTP/ViewModel/phone_otp_view_model.dart';
import 'package:farm_easy/Screens/Auth/UserResgister/View/user_registration.dart';
import 'package:farm_easy/Screens/Dashboard/view/dashboard.dart';
import 'package:farm_easy/Screens/SplashScreen/Model/IsUserExist.dart';
import 'package:farm_easy/Screens/SplashScreen/ViewModel/is_user_exist_view_model.dart';
import 'package:farm_easy/Services/network/status.dart';
import 'package:farm_easy/SharedPreferences/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sms_autofill/sms_autofill.dart';

import '../../../Role Selection/View/role_selection.dart';

class OtpScreenController extends GetxController with CodeAutoFill {
  var isOtpComplete = false.obs;
  final RxInt timerSecondsRemaining = 60.obs;
  final RxBool timerFinished = false.obs;
  var resendAttempts = 0.obs; // Counter for resend attempts
  final RxBool isVisible = true.obs;
  late Timer _timer;
  String countryCode = '';
  String phoneNumber = ""; // Example phone number
  final AppPreferences _prefs = AppPreferences();
  final otpController = TextEditingController().obs;

  FocusNode focusNode = FocusNode();
  RxString otpValue = "".obs;

  @override
  void onInit() {
    super.onInit();
    focusNode.requestFocus();
    startTimer();
    listenForOtp();
  }

  void listenForOtp() async {
    await SmsAutoFill().listenForCode();
  }

  void generateAppHash() async {
    String? appSignature = await SmsAutoFill().getAppSignature;
    print("App Hash: $appSignature");
  }

  @override
  void codeUpdated() {
    String code =
        this.code ?? ""; // Get the OTP code from CodeAutoFill's code property
    otpController.value.text = code; // Autofill OTP field
    otpValue.value = code; // Update OTP value
    isOtpComplete.value = code.length == 4; // Example: assuming 6-digit OTP
    if (isOtpComplete.value) {
      verify(); // Automatically trigger verification if OTP is complete
    }
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
    Timer(Duration(seconds: 60), () {
      timerSecondsRemaining.value = 0;
    });
  }

  final _api = PhoneOtpViewModel();
  final loading = false.obs;
  final authData = PhoneOtpResponseModel().obs;
  final rxRequestStatus = Status.LOADING.obs;

  void setRequestStatus(Status _value) => rxRequestStatus.value = _value;
  void setAuthData(PhoneOtpResponseModel _value) => authData.value = _value;

  // Method to handle OTP verification
  void verify() {
    loading.value = true;
    _api.phoneOtpData({
      "country_code": "91",
      "mobile": "$phoneNumber",
      "otp": otpController.value.text
    }).then((value) async {
      loading.value = false;
      setRequestStatus(Status.SUCCESS);
      setAuthData(value);

      _prefs.setUserAccessToken(value.result?.access ?? "");
      _prefs.setUserRefreshToken(value.result?.refresh ?? "");
      if (await _prefs.getUserRefreshToken() != "") {
        _prefs.setIsUserLoggedIn();
      }
      await isUserExist();
    }).onError((error, stackTrace) async {
      showErrorCustomSnackbar(
        title: 'Message',
        message: 'Invalid OTP',
      );

      Status.ERROR.obs;
      loading.value = false;
      print(stackTrace);
    });
  }

  // Method to handle the resend OTP logic
  void resendOtp() {
    if (resendAttempts.value < 5) {
      verify();
      resendAttempts.value++;
      startTimer();
      print("Resend OTP, attempt: ${resendAttempts.value}");
      // Call your API to resend OTP here
    } else {
      showErrorCustomSnackbar(
        title: 'Limit Reached',
        message: 'You can only resend the OTP 5 times.',
      );
    }
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
    otpController.value.dispose();
    SmsAutoFill().unregisterListener(); // Stop listening for OTP SMS
    super.onClose();
  }
}
