import 'dart:convert';
import 'dart:io';

import 'package:farm_easy/ApiUrls/api_urls.dart';
import 'package:farm_easy/SharedPreferences/shared_preferences.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';

class ThreadsImageController extends GetxController {
  RxList<String> photos = <String>[].obs;
  RxInt photoadded = 0.obs;
  final _prefs = AppPreferences();
  Future getImage(ImageSource source) async {
    final ImagePicker picker = ImagePicker();
    final image = await picker.pickImage(source: source);

    if (image != null) {
      String imagePath = image.path.toString();
      photos.add(imagePath);
      photoadded++;
      await uploadImage(imagePath);
    }
  }

  void deleteImagelocal(int index) {
    photos.removeAt(index);
    photoadded--;
  }

  RxList<int> uploadedIds = <int>[].obs;
  Future<void> uploadImage(String imagePath) async {
    String? accessToken = await _prefs.getUserAccessToken();
    try {
      // Compress the image
      final compressedImage = await compressImage(File(imagePath));

      final url = Uri.parse(ApiUrls.THREAD_IMAGE);
      final request = http.MultipartRequest('POST', url);
      request.files.add(
        http.MultipartFile.fromBytes(
          'image',
          compressedImage,
          filename:
              'compressed_${imagePath.split('/').last}', // Use a compressed filename
        ),
      );
      request.headers['Authorization'] = 'Bearer $accessToken';

      final response = await request.send();
      if (response.statusCode == 200) {
        final responseBody = await response.stream.bytesToString();
        final parsedResponse = jsonDecode(responseBody);
        final id = parsedResponse['result']['id'];
        print('Image uploaded successfully. ID: $id');
        uploadedIds.add(id);
      } else {
        print('Error uploading image: ${response.reasonPhrase}');
      }
    } catch (e) {
      print('Error uploading image: $e');
    }
  }

  Future<List<int>> compressImage(File file) async {
    final result = await FlutterImageCompress.compressWithFile(
      file.absolute.path,
      quality: 50,
    );
    return result ?? [];
  }

  Future<void> deleteImage(int index) async {
    try {
      String? accessToken = await _prefs.getUserAccessToken();
      int id = uploadedIds[index];
      final url = Uri.parse(ApiUrls.DELETE_THREAD_IMAGE + '$id');
      final response = await http.delete(
        url,
        headers: {'Authorization': 'Bearer $accessToken'},
      );
      if (response.statusCode == 200) {
        print('Image deleted successfully. ID: $id');
        uploadedIds.removeAt(index);
      } else {
        print('Error deleting image: ${response.reasonPhrase}');
      }
    } catch (e) {
      print('Error deleting image: $e');
    }
  }
}
