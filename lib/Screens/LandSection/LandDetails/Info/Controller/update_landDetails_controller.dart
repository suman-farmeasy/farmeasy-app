import 'dart:convert';
import 'dart:io';

import 'package:farm_easy/API/ApiUrls/api_urls.dart';
import 'package:farm_easy/utils/Constants/custom_snackbar.dart';
import 'package:farm_easy/Screens/LandSection/LandDetails/Info/Controller/check_land_details_controller.dart';
import 'package:farm_easy/Screens/LandSection/LandDetails/Info/Model/LandUpdateResponseModel.dart';
import 'package:farm_easy/Screens/LandSection/LandDetails/Info/ViewModel/land_info_view_model.dart';
import 'package:farm_easy/API/Services/network/status.dart';
import 'package:farm_easy/utils/SharedPreferences/shared_preferences.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class UpdateLandDetailsController extends GetxController {
  final landdetailController = Get.find<ChecklandDetailsController>();

  final _apiService = UpdateLandDetailsViewModel();
  final updateData = LandUpdateResponseModel().obs;
  final rxRequestStatus = Status.LOADING.obs;
  RxInt landId = 0.obs;
  void setRxRequestStatus(Status _value) => rxRequestStatus.value = _value;
  void setRxRequestData(LandUpdateResponseModel _value) =>
      updateData.value = _value;
  RxString landType = "".obs;
  final _prefs = AppPreferences();
  RxString waterResource = "".obs;
  RxInt waterId = RxInt(-1);
  final accomodationController = TextEditingController().obs;
  final equipmentController = TextEditingController().obs;

  final RxBool isWaterAvailable = true.obs;
  final RxBool isAccomodationAvailable = true.obs;
  final RxBool isEquipmentAvailable = true.obs;
  final RxBool isRoadAvailable = true.obs;

  final RxBool isLandFarm = true.obs;
  final RxBool isCertified = true.obs;

  final waterloading = false.obs;

  final landloading = false.obs;
  final accomodationloading = false.obs;
  final equipmentloading = false.obs;
  final croploading = false.obs;
  final roadloading = false.obs;
  final certificationloading = false.obs;
  final pdfloading = false.obs;

  RxList crops = [].obs;
  Future<void> removeCertificate() async {
    try {
      final uri = Uri.parse(ApiUrls.REMOVE_CERTIFICATE).replace(
        queryParameters: {'land_id': landId.value.toString()},
      );

      print("URL: $uri"); // Debugging the constructed URL

      final response = await http.put(
        uri,
        headers: {
          'Authorization': 'Bearer ${await _prefs.getUserAccessToken()}',
          "Content-Type": "application/json",
        },
      );

      if (response.statusCode == 200) {
        print("Success: Certificate removed successfully");
        selectedPdf.value = null; // Reset the selected PDF
      } else {
        print("FAILED: ${response.body}");
      }
    } catch (e) {
      print("Error: $e");
    }
  }

  Rx<File?> selectedPdf = Rx<File?>(null);

  Future<void> pickPdf() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf'],
    );

    if (result != null) {
      selectedPdf.value = File(result.files.single.path!);
    }
  }

  void initializeCertificate(String certificatePath) {
    if (certificatePath.isNotEmpty) {
      selectedPdf.value = File(certificatePath);
    }
  }

  Future<void> selectedPDF() async {
    pdfloading.value = true;
    String? accessToken = await _prefs.getUserAccessToken();
    if (accessToken == null) {
      return;
    }

    File? pdfFile = selectedPdf.value;
    if (pdfFile == null) {
      pdfloading.value = false;
      return;
    }

    var request = http.MultipartRequest(
      'PATCH',
      Uri.parse(ApiUrls.UPDATE_LAND_DETAILS + '${landId.value}'),
    );

    request.files.add(http.MultipartFile(
      'certification_documnet',
      pdfFile.readAsBytes().asStream(),
      pdfFile.lengthSync(),
      filename: 'selected_pdf.pdf',
    ));
    request.fields['organic_certification'] = '${isCertified.value}';

    request.headers['Authorization'] = 'Bearer $accessToken';

    try {
      var streamedResponse = await request.send();
      var response = await http.Response.fromStream(streamedResponse);

      print(response.body);

      if (response.statusCode == 201) {
        pdfloading.value = false;
        showSuccessCustomSnackbar(
          title: 'Updated Successfully',
          message: 'The updated information is saved.',
        );
        setRxRequestData(LandUpdateResponseModel.fromJson(response.body));
        print(response.statusCode);
      } else {
        pdfloading.value = false;
      }
    } catch (e) {
      pdfloading.value = false;
      print(e);
    }
  }

  Future updateLandType() async {
    landloading.value = true;
    _apiService.landUpdate(
      {
        "Authorization": 'Bearer ${await _prefs.getUserAccessToken()}',
        "Content-Type": "application/json"
      },
      landId.value,
      jsonEncode({
        "land_type": landType.value,
      }),
    ).then((value) {
      landloading.value = false;
      showSuccessCustomSnackbar(
        title: 'Updated Successfully',
        message: 'The updated information is saved.',
      );
      print(value.result.toString());
      setRxRequestData(value);
    }).onError((error, stackTrace) {});
  }

  Future updateLandNickname(String landNickName) async {
    landloading.value = true;
    _apiService.landUpdate(
      {
        "Authorization": 'Bearer ${await _prefs.getUserAccessToken()}',
        "Content-Type": "application/json"
      },
      landId.value,
      jsonEncode({
        "land_title": landNickName,
      }),
    ).then((value) {
      showSuccessCustomSnackbar(
        title: 'Updated Successfully',
        message: 'The updated information is saved.',
      );
      landloading.value = false;
      print(value.result.toString());
      setRxRequestData(value);
    }).onError((error, stackTrace) {
      print(error);
      print(stackTrace);
    });
  }

  Future updateLandSize(String landArea) async {
    landloading.value = true;
    _apiService.landUpdate(
      {
        "Authorization": 'Bearer ${await _prefs.getUserAccessToken()}',
        "Content-Type": "application/json"
      },
      landId.value,
      jsonEncode({
        "land_size": "${landArea}",
      }),
    ).then((value) {
      showSuccessCustomSnackbar(
        title: 'Updated Successfully',
        message: 'The updated information is saved.',
      );
      landloading.value = false;
      print(value.result.toString());
      setRxRequestData(value);
    }).onError((error, stackTrace) {
      print(error);
      print(stackTrace);
    });
  }

  Future updateLandPurpose(int selectedPurposeid) async {
    landloading.value = true;
    _apiService.landUpdate(
      {
        "Authorization": 'Bearer ${await _prefs.getUserAccessToken()}',
        "Content-Type": "application/json"
      },
      landId.value,
      jsonEncode({
        "purpose": "${selectedPurposeid}",
      }),
    ).then((value) {
      showSuccessCustomSnackbar(
        title: 'Updated Successfully',
        message: 'The updated information is saved.',
      );
      landloading.value = false;
      print(value.result.toString());
      setRxRequestData(value);
    }).onError((error, stackTrace) {
      print(error);
      print(stackTrace);
    });
  }

  Future updateLandLeaseDuration(String leaseDuration) async {
    landloading.value = true;
    _apiService.landUpdate(
      {
        "Authorization": 'Bearer ${await _prefs.getUserAccessToken()}',
        "Content-Type": "application/json"
      },
      landId.value,
      jsonEncode({
        "lease_duration": "${leaseDuration}",
      }),
    ).then((value) {
      landloading.value = false;
      print(value.result.toString());
      setRxRequestData(value);
    }).onError((error, stackTrace) {
      print(error);
      print(stackTrace);
    });
  }

  Future updateLandLeaseType(String leaseType, String leaseAmount) async {
    landloading.value = true;
    _apiService.landUpdate(
      {
        "Authorization": 'Bearer ${await _prefs.getUserAccessToken()}',
        "Content-Type": "application/json"
      },
      landId.value,
      jsonEncode({
        "lease_type": "${leaseType}",
        "expected_lease_amount": "${leaseAmount}",
      }),
    ).then((value) {
      landloading.value = false;
      print(value.result.toString());
      setRxRequestData(value);
    }).onError((error, stackTrace) {
      print(error);
      print(stackTrace);
    });
  }

  Future updateLandsCrop(List cropAdded, List otherCropAddedName) async {
    landloading.value = true;
    _apiService.landUpdate(
      {
        "Authorization": 'Bearer ${await _prefs.getUserAccessToken()}',
        "Content-Type": "application/json"
      },
      landId.value,
      jsonEncode(
          {"crop_to_grow": cropAdded, "other_crops": otherCropAddedName}),
    ).then((value) {
      landloading.value = false;
      print(value.result.toString());
      setRxRequestData(value);
      showSuccessCustomSnackbar(
        title: 'Updated Successfully',
        message: 'The updated information is saved.',
      );
    }).onError((error, stackTrace) {
      print(error);
      print(stackTrace);
    });
  }

  Future updateLandCropsToGrow(int selectedPurposeid) async {
    landloading.value = true;
    _apiService.landUpdate(
      {
        "Authorization": 'Bearer ${await _prefs.getUserAccessToken()}',
        "Content-Type": "application/json"
      },
      landId.value,
      jsonEncode({
        "purpose": "${selectedPurposeid}",
      }),
    ).then((value) {
      landloading.value = false;
      print(value.result.toString());
      setRxRequestData(value);
    }).onError((error, stackTrace) {
      print(error);
      print(stackTrace);
    });
  }

  Future updateWaterResource() async {
    waterloading.value = true;
    _apiService.landUpdate(
      {
        "Authorization": 'Bearer ${await _prefs.getUserAccessToken()}',
        "Content-Type": "application/json"
      },
      landId.value,
      jsonEncode({
        "water_source_available": "${isWaterAvailable.value}",
        "water_source": "${waterResource.value}",
      }),
    ).then((value) {
      waterloading.value = false;
      showSuccessCustomSnackbar(
        title: 'Updated Successfully',
        message: 'The updated information is saved.',
      );
      setRxRequestData(value);
    }).onError((error, stackTrace) {});
  }

  Future updateWaterisAvailable() async {
    waterloading.value = true;
    _apiService.landUpdate(
      {
        "Authorization": 'Bearer ${await _prefs.getUserAccessToken()}',
        "Content-Type": "application/json"
      },
      landId.value,
      jsonEncode({
        "water_source_available": "${isWaterAvailable.value}",
      }),
    ).then((value) {
      waterloading.value = false;
      showSuccessCustomSnackbar(
        title: 'Updated Successfully',
        message: 'The updated information is saved.',
      );
      setRxRequestData(value);
    }).onError((error, stackTrace) {});
  }

  Future updateAccomodationAvailable() async {
    accomodationloading.value = true;
    _apiService.landUpdate(
      {
        "Authorization": 'Bearer ${await _prefs.getUserAccessToken()}',
        "Content-Type": "application/json"
      },
      landId.value,
      jsonEncode({
        "accomodation_available": "${isAccomodationAvailable.value}",
        "accomodation": "${accomodationController.value.text}",
      }),
    ).then((value) {
      accomodationloading.value = false;
      showSuccessCustomSnackbar(
        title: 'Updated Successfully',
        message: 'The updated information is saved.',
      );
      setRxRequestData(value);
    }).onError((error, stackTrace) {});
  }

  Future isaccomodationAvailable() async {
    accomodationloading.value = true;
    _apiService.landUpdate(
      {
        "Authorization": 'Bearer ${await _prefs.getUserAccessToken()}',
        "Content-Type": "application/json"
      },
      landId.value,
      jsonEncode({
        "accomodation_available": "${isAccomodationAvailable.value}",
      }),
    ).then((value) {
      accomodationloading.value = false;
      showSuccessCustomSnackbar(
        title: 'Updated Successfully',
        message: 'The updated information is saved.',
      );
      setRxRequestData(value);
    }).onError((error, stackTrace) {});
  }

  Future updateEquipmentAvailable() async {
    equipmentloading.value = true;
    _apiService.landUpdate(
      {
        "Authorization": 'Bearer ${await _prefs.getUserAccessToken()}',
        "Content-Type": "application/json"
      },
      landId.value,
      jsonEncode({
        "equipment_available": "${isEquipmentAvailable.value}",
        "equipment": "${equipmentController.value.text}",
      }),
    ).then((value) {
      equipmentloading.value = false;
      showSuccessCustomSnackbar(
        title: 'Updated Successfully',
        message: 'The updated information is saved.',
      );
      setRxRequestData(value);
    }).onError((error, stackTrace) {});
  }

  Future isequipmentAvailable() async {
    equipmentloading.value = true;
    _apiService.landUpdate(
      {
        "Authorization": 'Bearer ${await _prefs.getUserAccessToken()}',
        "Content-Type": "application/json"
      },
      landId.value,
      jsonEncode({
        "equipment_available": "${isEquipmentAvailable.value}",
      }),
    ).then((value) {
      equipmentloading.value = false;
      setRxRequestData(value);
      showSuccessCustomSnackbar(
        title: 'Updated Successfully',
        message: 'The updated information is saved.',
      );
    }).onError((error, stackTrace) {});
  }

  Future updateCropData() async {
    croploading.value = true;
    _apiService.landUpdate(
      {
        "Authorization": 'Bearer ${await _prefs.getUserAccessToken()}',
        "Content-Type": "application/json"
      },
      landId.value,
      jsonEncode({
        "land_farmed_before": "${isLandFarm.value}",
        "crops_grown": crops.toList(),
      }),
    ).then((value) {
      croploading.value = false;
      showSuccessCustomSnackbar(
        title: 'Updated Successfully',
        message: 'The updated information is saved.',
      );
      setRxRequestData(value);
    }).onError((error, stackTrace) {});
  }

  Future updateCrop() async {
    croploading.value = true;
    _apiService.landUpdate(
      {
        "Authorization": 'Bearer ${await _prefs.getUserAccessToken()}',
        "Content-Type": "application/json"
      },
      landId.value,
      jsonEncode({
        "land_farmed_before": "${isLandFarm.value}",
      }),
    ).then((value) {
      croploading.value = false;
      showSuccessCustomSnackbar(
        title: 'Updated Successfully',
        message: 'The updated information is saved.',
      );
      setRxRequestData(value);
    }).onError((error, stackTrace) {
      print(error);
      print(stackTrace);
    });
  }

  Future roadAvailable() async {
    roadloading.value = true;
    _apiService.landUpdate(
      {
        "Authorization": 'Bearer ${await _prefs.getUserAccessToken()}',
        "Content-Type": "application/json"
      },
      landId.value,
      jsonEncode({
        "road_access": "${isRoadAvailable.value}",
      }),
    ).then((value) {
      roadloading.value = false;
      showSuccessCustomSnackbar(
        title: 'Updated Successfully',
        message: 'The updated information is saved.',
      );
      setRxRequestData(value);
    }).onError((error, stackTrace) {});
  }

  Future certificationValue() async {
    certificationloading.value = true;
    _apiService.landUpdate(
      {
        "Authorization": 'Bearer ${await _prefs.getUserAccessToken()}',
        "Content-Type": "application/json"
      },
      landId.value,
      jsonEncode({
        "organic_certification": "${isCertified.value}",
      }),
    ).then((value) {
      showSuccessCustomSnackbar(
        title: 'Updated Successfully',
        message: 'The updated information is saved.',
      );
      certificationloading.value = false;
      setRxRequestData(value);
    }).onError((error, stackTrace) {});
  }
}
