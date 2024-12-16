import 'dart:convert';
import 'dart:io';

import 'package:farm_easy/API/ApiUrls/api_urls.dart';
import 'package:farm_easy/utils/SharedPreferences/shared_preferences.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';

class ProductImgController extends GetxController {
  RxList<String> photos = <String>[].obs; // Local paths of images
  RxList<int> uploadedIds = <int>[].obs; // IDs of uploaded images
  RxInt photoAddedCount = 0.obs;

  final _prefs = AppPreferences();

  static const int maxImageLimit = 3;

  /// Pick multiple images
  Future<void> pickMultipleImages(ImageSource source) async {
    if (photos.length >= maxImageLimit) {
      print('Maximum image limit reached.');
      return;
    }

    final ImagePicker picker = ImagePicker();
    final images = await picker.pickMultiImage();

    if (images != null && images.isNotEmpty) {
      int remainingSlots = maxImageLimit - photos.length;

      // Add only up to the remaining slots
      for (var i = 0;
          i < images.length && remainingSlots > 0;
          i++, remainingSlots--) {
        String imagePath = images[i].path;
        photos.add(imagePath);
        photoAddedCount++;

        await uploadImage(imagePath); // Upload image immediately
      }

      if (photos.length == maxImageLimit) {
        print('You have reached the maximum limit of 3 images.');
      }
    }
  }

  /// Pick single image
  Future<void> pickSingleImage(ImageSource source) async {
    if (photos.length >= maxImageLimit) {
      print('Maximum image limit reached.');
      return;
    }

    final ImagePicker picker = ImagePicker();
    final image = await picker.pickImage(source: source);

    if (image != null) {
      String imagePath = image.path;
      photos.add(imagePath);
      photoAddedCount++;

      await uploadImage(imagePath); // Upload image immediately

      if (photos.length == maxImageLimit) {
        print('You have reached the maximum limit of 3 images.');
      }
    }
  }

  /// Delete image locally
  void deleteImageLocal(int index) {
    photos.removeAt(index);
    photoAddedCount--;
  }

  /// Upload image to the server
  Future<void> uploadImage(String imagePath) async {
    String? accessToken = await _prefs.getUserAccessToken();
    try {
      final compressedImage = await compressImage(File(imagePath));

      final url = Uri.parse(ApiUrls.PRODUCT_IMAGE);
      final request = http.MultipartRequest('POST', url);
      request.files.add(
        http.MultipartFile.fromBytes(
          'image',
          compressedImage,
          filename: 'compressed_${imagePath.split('/').last}',
        ),
      );
      request.headers['Authorization'] = 'Bearer $accessToken';

      final response = await request.send();
      if (response.statusCode == 200) {
        final responseBody = await response.stream.bytesToString();
        final parsedResponse = jsonDecode(responseBody);
        final id = parsedResponse['result']['id'];
        uploadedIds.add(id);
        print('Image uploaded successfully. ID: $id');
      } else {
        print('Error uploading image: ${response.reasonPhrase}');
      }
    } catch (e) {
      print('Error uploading image: $e');
    }
  }

  /// Delete image from the server
  Future<void> deleteImage(int index) async {
    try {
      String? accessToken = await _prefs.getUserAccessToken();
      int id = uploadedIds[index];
      final url = Uri.parse(ApiUrls.DELETE_PRODUCT_IMAGE + '$id');
      final response = await http.delete(
        url,
        headers: {'Authorization': 'Bearer $accessToken'},
      );
      if (response.statusCode == 200) {
        uploadedIds.removeAt(index);
        deleteImageLocal(index);
        print('Image deleted successfully. ID: $id');
      } else {
        print('Error deleting image: ${response.reasonPhrase}');
      }
    } catch (e) {
      print('Error deleting image: $e');
    }
  }

  /// Compress image before uploading
  Future<List<int>> compressImage(File file) async {
    final result = await FlutterImageCompress.compressWithFile(
      file.absolute.path,
      quality: 50,
    );
    return result ?? [];
  }
}
