import 'dart:io';

import 'package:farm_easy/Utils/Constants/color_constants.dart';
import 'package:farm_easy/Utils/Constants/string_constant.dart';
import 'package:farm_easy/Screens/Auth/CompleteProfile/Controller/update_profile_controller.dart';
import 'package:farm_easy/Utils/SharedPreferences/shared_preferences.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

class ProfileController extends GetxController {
  final FocusNode focusNode = FocusNode();
  final locationController = TextEditingController().obs;
  final RxDouble selectedLatitude = 0.0.obs;
  final RxDouble selectedLongitude = 0.0.obs;
  final Rxn<File> imageFile = Rxn<File>();
  RxString userType = ''.obs;
  final prefs = AppPreferences();

  Future<void> pickImage(ImageSource source) async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: source);

    if (pickedFile != null) {
      File? croppedFile = await cropImage(File(pickedFile.path));
      if (croppedFile != null) {
        setImageFile(croppedFile);
        String? userRole = await prefs.getUserRole();
        if (userRole == StringConstatnt.FARMER) {
          final updateProfileController = Get.find<UpdateProfileController>();
          await updateProfileController.updateFarmerProfileImage(croppedFile);
        } else if (userRole == StringConstatnt.AGRI_PROVIDER) {
          final updateProfileController = Get.find<UpdateProfileController>();
          await updateProfileController
              .updateAgriProviderProfileImage(croppedFile);
        } else if (userRole == StringConstatnt.LANDOWNER) {
          final updateProfileController = Get.find<UpdateProfileController>();
          await updateProfileController
              .updateLandOwnerProfileImage(croppedFile);
        }

        Get.back();
      }
    }
  }

  Future<File?> cropImage(File imageFile) async {
    final ImageCropper imageCropper = ImageCropper();
    final CroppedFile? croppedFile = await imageCropper.cropImage(
      sourcePath: imageFile.path,
      uiSettings: [
        AndroidUiSettings(
          toolbarTitle: 'Cropper',
          toolbarColor: AppColor.DARK_GREEN,
          toolbarWidgetColor: Colors.white,
          initAspectRatio: CropAspectRatioPreset.square,
          lockAspectRatio: true,
        ),
        IOSUiSettings(
          title: 'Cropper',
        ),
      ],
    );
    return croppedFile != null ? File(croppedFile.path) : null;
  }

  void setImageFile(File file) {
    imageFile.value = file;
    update();
  }

  void openBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          height: Get.height * 0.13,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
            color: Colors.white,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              IconButton(
                onPressed: () {
                  pickImage(ImageSource.gallery);
                },
                icon: Icon(
                  CupertinoIcons.photo,
                  color: AppColor.DARK_GREEN,
                  size: 40,
                ),
              ),
              IconButton(
                onPressed: () {
                  pickImage(ImageSource.camera);
                },
                icon: Icon(
                  CupertinoIcons.camera,
                  color: AppColor.DARK_GREEN,
                  size: 40,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
