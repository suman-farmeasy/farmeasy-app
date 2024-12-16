import 'package:country_picker/country_picker.dart';
import 'package:farm_easy/Screens/Auth/CompleteProfile/Controller/update_profile_controller.dart';
import 'package:farm_easy/Screens/Auth/CompleteProfile/Model/GetProfileResponseModel.dart';
import 'package:farm_easy/Screens/Auth/CompleteProfile/VIewModel/complete_profile_view_model.dart';
import 'package:farm_easy/Services/network/status.dart';
import 'package:farm_easy/SharedPreferences/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class GetProfileController extends GetxController {
  final updateControlle = Get.put(UpdateProfileController());
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
        countryCode.value = country.phoneCode;
        displayCountryName.value =
            country.name ?? ''; // Update the displayed country name
        // Future.delayed(Duration(milliseconds: 100), () {
        //   countryCodeController.value.clear();
        // });
      },
      showPhoneCode: true,
    );
  }

  final _api = GetProfileDetailsViewModel();
  final _prefs = AppPreferences();
  final loading = false.obs;
  //final RxList<int> expertiseIds = <int>[].obs;
  RxList farmerExpertiseList = [].obs;
  RxList agriRolesList = [].obs;
  RxString profileType = "".obs;

  final rxRequestStatus = Status.LOADING.obs;
  final getProfileData = GetProfileResponseModel().obs;
  void setRxRequestStatus(Status _value) => rxRequestStatus.value = _value;
  void setRxRequestData(GetProfileResponseModel _value) =>
      getProfileData.value = _value;
  Future<void> getProfile() async {
    String tokenKey = await _prefs.getUserAccessToken();
    print("GET PROFILE");
    print("tokenKey :$tokenKey");
    loading.value = true;
    _api.getProfile(
      {
        "Authorization": 'Bearer ${await _prefs.getUserAccessToken()}',
        "Content-Type": "application/json"
      },
    ).then((value) {
      loading.value = false;
      setRxRequestData(value);
      setRxRequestStatus(Status.SUCCESS);
      _prefs.setUserId(value.result?.userId ?? 0);
      profileType.value = value.result?.profileType ?? "";
      updateControlle.selectedYear.value = value.result?.yearExperience ?? 0;
      updateControlle.selectedMonths.value = value.result?.monthExperience ?? 0;
      updateControlle.maxSalary.value =
          value.result?.maxSalary?.toDouble() ?? 0.0;
      updateControlle.minSalary.value =
          value.result?.minsalary?.toDouble() ?? 0.0;
      updateControlle.isChecked.value = value.result?.isSalaryVissible ?? false;
      value.result?.expertise?.forEach((expertise) {
        final int? ExpertiseId = expertise.id;
        if (ExpertiseId != null) {
          farmerExpertiseList.add(ExpertiseId);
        }
      });
      value.result?.roles?.forEach((roles) {
        final int? RolesId = roles.id;
        if (RolesId != null) {
          agriRolesList.add(RolesId);
        }
      });
    }).onError((error, stackTrace) {
      print(error);
      print(stackTrace);
    });
  }
}
