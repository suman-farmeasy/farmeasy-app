import 'package:farm_easy/utils/Constants/custom_snackbar.dart';
import 'package:farm_easy/Screens/Auth/EmailLogin/Model/EmailResponseModel.dart';
import 'package:farm_easy/Screens/Auth/EmailLogin/OTP/View/otp_screen.dart';
import 'package:farm_easy/Screens/Auth/EmailLogin/ViewModel/email_view_model.dart';
import 'package:farm_easy/API/Services/network/status.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EmailController extends GetxController {
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    focusNode.requestFocus();
  }

  final Rx<TextEditingController> emailController = TextEditingController().obs;
  RxBool emailFill = false.obs;
  final _api = EmailViewModel();
  final loading = false.obs;
  final authData = EmailResponseModel().obs;
  final rxRequestStatus = Status.LOADING.obs;
  FocusNode focusNode = FocusNode();

  void setRxRequestStatus(Status _value) => rxRequestStatus.value = _value;
  void setAuthData(EmailResponseModel _value) => authData.value = _value;

  void login() {
    loading.value = true;
    String lowerCaseEmail = emailController.value.text.toLowerCase();
    _api.emailData({
      "email": lowerCaseEmail,
    }).then((value) async {
      loading.value = false;
      setRxRequestStatus(Status.SUCCESS);
      setAuthData(value);
      showSuccessCustomSnackbar(
        title: 'Message',
        message: '${value.result.obs}',
      );

      Get.to(() => EmailOtpScreen(email: lowerCaseEmail));
    }).onError((error, stackTrace) {
      loading.value = false;
      setRxRequestStatus(Status.ERROR);
      // Get.snackbar(
      //   'Error',
      //   'Failed to login',
      //   snackPosition: SnackPosition.TOP,
      //   duration: Duration(seconds: 3),
      //   colorText: Colors.red,
      //   instantInit: true,
      //   backgroundGradient: AppColor.PRIMARY_GRADIENT,
      //   maxWidth: double.infinity,
      // );
    });
  }
}
