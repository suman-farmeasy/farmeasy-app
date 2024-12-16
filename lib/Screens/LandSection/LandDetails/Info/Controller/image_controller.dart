import 'dart:convert';

import 'package:farm_easy/API/ApiUrls/api_urls.dart';
import 'package:farm_easy/Screens/LandSection/LandDetails/Info/Model/LandImageResponseModel.dart';
import 'package:farm_easy/Screens/LandSection/LandDetails/Info/ViewModel/land_info_view_model.dart';
import 'package:farm_easy/API/Services/network/status.dart';
import 'package:farm_easy/Utils/SharedPreferences/shared_preferences.dart';
import 'package:file_picker/file_picker.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class ImageController extends GetxController {
  final _api = UploadLandImagesViewModel();
  final landImg = LandImageResponseModel().obs;
  final loading = false.obs;
  final rxRequestStatus = Status.LOADING.obs;
  RxInt landId = 0.obs;
  RxList<String> photos = <String>[].obs;
  RxInt photoAdded = 0.obs;
  RxList<int> uploadedIds = <int>[].obs;
  final _prefs = AppPreferences();

  void setRxRequestStatus(Status _value) => rxRequestStatus.value = _value;
  void setRxRequestData(LandImageResponseModel _value) =>
      landImg.value = _value;

  Future<void> updateImg() async {
    loading.value = true;
    _api.imgUpdate(
        {
          "Authorization": 'Bearer ${await _prefs.getUserAccessToken()}',
          "Content-Type": "application/json"
        },
        jsonEncode(
            {"id": uploadedIds.toList(), "land_id": "${landId.value}"})).then(
        (value) {
      loading.value = false;
      setRxRequestData(value);
    }).onError((error, stackTrace) {
      loading.value = false;
      print(error);
      print(stackTrace);
    });
  }

  Future<void> getImages() async {
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.image,
        allowMultiple: true,
      );

      if (result != null) {
        for (var file in result.files) {
          final filePath = file.path!;
          photos.add(filePath);
          photoAdded++;

          await uploadImage(filePath);
        }
      }
    } catch (e) {
      print(e);
    }
  }

  void deleteImageLocal(int index) {
    photos.removeAt(index);
    photoAdded--;
  }

  Future<void> uploadImage(String imagePath) async {
    String? accessToken = await _prefs.getUserAccessToken();
    try {
      final url = Uri.parse(ApiUrls.UPLOAD_LAND_IMAGES);
      final request = http.MultipartRequest('POST', url);
      request.files.add(
        await http.MultipartFile.fromPath('image', imagePath),
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

  Future<void> deleteImage(int index) async {
    try {
      String? accessToken = await _prefs.getUserAccessToken();
      int id = uploadedIds[index];
      final url = Uri.parse('${ApiUrls.DELETE_LAND_IMAGES}$id');
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
