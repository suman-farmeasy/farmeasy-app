import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:farm_easy/API/ApiUrls/api_urls.dart';
import 'package:farm_easy/utils/Constants/color_constants.dart';
import 'package:farm_easy/utils/Constants/string_constant.dart';
import 'package:farm_easy/Screens/Auth/CompleteProfile/Controller/get_profile_controller.dart';
import 'package:farm_easy/Screens/Auth/CompleteProfile/Controller/update_profile_controller.dart';
import 'package:farm_easy/utils/SharedPreferences/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
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
        // Compress the cropped image
        File compressedFile = await compressImage(croppedFile);

        setImageFile(compressedFile); // Update state with the compressed image

        // Fetch user role and upload the image based on the role
        String? userRole = await prefs.getUserRole();
        final updateProfileController = Get.find<UpdateProfileController>();

        if (userRole == StringConstatnt.FARMER) {
          await updateProfileController
              .updateFarmerProfileImage(compressedFile);
        } else if (userRole == StringConstatnt.AGRI_PROVIDER) {
          await updateProfileController
              .updateAgriProviderProfileImage(compressedFile);
        } else if (userRole == StringConstatnt.LANDOWNER) {
          await updateProfileController
              .updateLandOwnerProfileImage(compressedFile);
        }

        Get.back(); // Close the bottom sheet or screen after uploading
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

  Future<File> compressImage(File file) async {
    final result = await FlutterImageCompress.compressWithFile(
      file.absolute.path,
      quality: 50,
    );
    // /compressed_image.jpg
    if (result != null) {
      final tempDir = Directory.systemTemp;
      final compressedFile = File(
          '${tempDir.path}/compressed_image${DateTime.now().millisecondsSinceEpoch}.jpg');
      print('Compressed file path: ${compressedFile.path}');
      await compressedFile.writeAsBytes(result);
      return compressedFile;
    } else {
      throw Exception('Image compression failed');
    }
  }

  void setImageFile(File file) {
    imageFile.value = file;
    update();
  }

  final getProfile = Get.find<GetProfileController>();
  Future<void> deleteProfilePic() async {
    try {
      String? accessToken = await prefs.getUserAccessToken();
      if (accessToken == null) {
        print("Access token is null. Cannot proceed with image deletion.");
        return;
      }

      final url = Uri.parse(ApiUrls.REMOVE_PROFILE_IMAGE);
      print("Deleting profile image with URL: $url");

      // Make the API call
      final response = await http.patch(
        url,
        headers: {
          'Authorization': 'Bearer $accessToken',
        },
      );

      // Check the response status
      if (response.statusCode == 200) {
        print("Image deleted successfully.");
        getProfile.getProfile(); // Refresh profile data
      } else {
        // Log detailed error response
        print("Failed to delete image. Status code: ${response.statusCode}");
        print("Reason: ${response.reasonPhrase}");
      }
    } catch (e) {
      print("Error deleting image: $e");
    }
  }

  void openBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          padding: EdgeInsets.only(top: 30),
          height: Get.height * 0.43,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
            color: Colors.white,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "Upload Profile Picture",
                style: GoogleFonts.poppins(
                    fontWeight: FontWeight.w600,
                    fontSize: 18,
                    color: Color(0xFF484848)),
              ),
              SizedBox(height: 10),
              Text(
                "This document will be safe and secure and we’re not",
                style: GoogleFonts.poppins(
                    fontWeight: FontWeight.w400,
                    fontSize: 12,
                    color: Color(0xFF484848).withOpacity(0.7)),
              ),
              Text(
                "going to share anything with anyone.",
                style: GoogleFonts.poppins(
                    fontWeight: FontWeight.w400,
                    fontSize: 12,
                    color: Color(0xFF484848).withOpacity(0.7)),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 30.0, vertical: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    InkWell(
                      onTap: () {
                        pickImage(ImageSource.camera);
                      },
                      child: buildImageOption(
                          context, "assets/img/cam.svg", "Open Camera"),
                    ),
                    InkWell(
                      onTap: () {
                        pickImage(ImageSource.gallery);
                      },
                      child: buildImageOption(
                          context, "assets/img/gal.svg", "Open Gallery"),
                    ),
                  ],
                ),
              ),
              InkWell(
                onTap: () {
                  Get.back();
                },
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 10),
                  margin: EdgeInsets.symmetric(horizontal: 15),
                  decoration: BoxDecoration(
                    border: Border.all(color: AppColor.DARK_GREEN),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Center(
                    child: Text(
                      "Back",
                      style: GoogleFonts.poppins(
                          fontSize: 16,
                          color: AppColor.DARK_GREEN,
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget buildImageOption(
      BuildContext context, String assetPath, String label) {
    return DottedBorder(
      borderType: BorderType.RRect,
      color: Color(0xFFE4E4E4),
      dashPattern: [2, 4],
      radius: Radius.circular(12),
      child: ClipRRect(
        borderRadius: BorderRadius.all(Radius.circular(12)),
        child: Container(
          height: MediaQuery.of(context).size.height * 0.12,
          width: MediaQuery.of(context).size.height * 0.12,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SvgPicture.asset(assetPath),
                SizedBox(height: 10),
                Text(
                  label,
                  style: GoogleFonts.poppins(
                      fontWeight: FontWeight.w400,
                      fontSize: 12,
                      color: Color(0xFF484848)),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
