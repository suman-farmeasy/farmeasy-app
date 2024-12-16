import 'package:country_picker/country_picker.dart';
import 'package:farm_easy/Constants/color_constants.dart';
import 'package:farm_easy/Screens/Auth/LoginPage/Model/PhonenumberResponseModel.dart';
import 'package:farm_easy/Screens/Auth/LoginPage/OTP/View/otp_screen.dart';
import 'package:farm_easy/Screens/Auth/LoginPage/ViewModel/phonenumber_view_model.dart';
import 'package:farm_easy/Services/network/status.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AuthController extends GetxController {
  final Rx<Country?> selectedCountry = Rx<Country?>(null);
  final phoneController = TextEditingController().obs;
  final RxString displayCountryName = ''.obs;
  RxBool isCountrySelected = false.obs;
  RxString countryCode = ''.obs;
  void selectCountry() {
    showCountryPicker(
      context: Get.context!,
      onSelect: (Country country) {
        selectedCountry.value = country;
        // countryCodeController.text = country.phoneCode ?? '';
        countryCode = country.phoneCode.obs;
        displayCountryName.value =
            country.name ?? ''; // Update the displayed country name
        // Future.delayed(Duration(milliseconds: 100), () {
        //   countryCodeController.value.clear();
        // });
      },
      showPhoneCode: true,
    );
  }

  final _api = PhoneViewMOdel();
  final loading = false.obs;
  final authData = PhonenumberResponseModel().obs;
  final rxRequestStatus = Status.LOADING.obs;
  void setRxRequestStatus(Status _value) => rxRequestStatus.value = _value;
  void setAuthData(PhonenumberResponseModel _value) => authData.value = _value;

  void login() {
    loading.value = true;
    _api.phoneDetails({
      //"country_code": "${countryCode.value}",
      "country_code": "91",
      "mobile": "${phoneController.value.text}"
    }).then((value) async {
      loading.value = false;
      setRxRequestStatus(Status.SUCCESS);
      setAuthData(value);
      Get.snackbar(
        'Message',
        '${value.result.obs}',
        snackPosition: SnackPosition.TOP,
        duration: Duration(seconds: 3),
        colorText: Colors.black,
        instantInit: true,
        backgroundGradient: AppColor.PRIMARY_GRADIENT,
        maxWidth: double.infinity,
      );
      Get.to(OtpScreen(
        phoneNumber: '${phoneController.value.text}',
        countryCode: '${countryCode.value}',
      ));
    }).onError((error, stackTrace) {
      loading.value = false;
    });
  }
}
