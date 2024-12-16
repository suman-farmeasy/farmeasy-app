import 'dart:convert';
import 'dart:io';

import 'package:farm_easy/API/ApiUrls/api_urls.dart';
import 'package:farm_easy/utils/SharedPreferences/shared_preferences.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';

class EditProductImgController extends GetxController {
  RxList<String> photos = <String>[].obs; // URLs of photos
  RxList<int> uploadedIds = <int>[].obs; // Uploaded image IDs

  final _prefs = AppPreferences();

  /// Fetch and add image from gallery
  Future<void> getImage(ImageSource source, int productId) async {
    try {
      final ImagePicker picker = ImagePicker();
      final XFile? image = await picker.pickImage(source: source);

      if (image != null) {
        String imagePath = image.path;

        // Show image locally before uploading
        photos.add(imagePath);

        // Upload image to server
        await uploadImage(imagePath, productId);
      }
    } catch (e) {
      print("Error selecting image: $e");
    }
  }

  Future<void> uploadImage(String imagePath, int productId) async {
    try {
      String? accessToken = await _prefs.getUserAccessToken();

      // Compress the image
      final compressedImage = await compressImage(File(imagePath));

      // Create the request
      final url = Uri.parse(ApiUrls.ADD_MORE_PRODUCTS);
      final request = http.MultipartRequest('POST', url)
        ..headers['Authorization'] = 'Bearer $accessToken'
        ..files.add(
          http.MultipartFile.fromBytes(
            'image',
            compressedImage,
            filename: 'compressed_${imagePath.split('/').last}',
          ),
        );

      request.fields['product'] = productId.toString();

      // Debugging - Print the request URL, headers, and payload
      print("Request URL: $url");
      print("Request Headers: ${request.headers}");

      // Send the request
      final response = await request.send();

      // Check if response status code is 200
      if (response.statusCode == 200) {
        final responseBody = await response.stream.bytesToString();
        final parsedResponse = jsonDecode(responseBody);

        // Debugging - Print response body
        print("Response Body: $responseBody");

        // Check for the image ID in the response
        final int imageId = parsedResponse['result']['id'];
        uploadedIds.add(imageId);
        print("Image uploaded successfully with ID: $imageId");
      } else {
        // Debugging - Print reason if not successful
        print("Failed to upload image: ${response.reasonPhrase}");
      }
    } catch (e, stackTrace) {
      // Debugging - Print error information
      print("Error uploading image: $e");
      print("Stack trace: $stackTrace");
    }
  }

  /// Delete image from the server and local state
  Future<void> deleteImage(int index) async {
    try {
      String? accessToken = await _prefs.getUserAccessToken();
      int id = uploadedIds[index];

      final url = Uri.parse("${ApiUrls.DELETE_PRODUCT_IMAGE}$id");
      final response = await http.delete(url, headers: {
        'Authorization': 'Bearer $accessToken',
      });

      if (response.statusCode == 200) {
        print("Image deleted successfully. ID: $id");
        photos.removeAt(index);
        uploadedIds.removeAt(index);
      } else {
        print("Error deleting image: ${response.reasonPhrase}");
      }
    } catch (e) {
      print("Error deleting image: $e");
    }
  }

  /// Compress image
  Future<List<int>> compressImage(File file) async {
    return await FlutterImageCompress.compressWithFile(
          file.absolute.path,
          quality: 50,
        ) ??
        [];
  }
}
