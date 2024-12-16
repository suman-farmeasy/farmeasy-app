import 'dart:convert';

import 'package:farm_easy/API/ApiUrls/api_urls.dart';
import 'package:farm_easy/Screens/HomeScreen/ViewModel/land_list_viewmodel.dart';
import 'package:farm_easy/API/Services/network/status.dart';
import 'package:farm_easy/Utils/SharedPreferences/shared_preferences.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import '../../HomeScreen/Model/LandListResponseModel.dart';

class MyLandController extends GetxController {
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    landListData();
  }

  final prefs = AppPreferences();
  final _api = LandListViewModel();
  final landData = LandListResponseModel().obs;

  RxList<LandDetailsData> alllandListData = <LandDetailsData>[].obs;
  final loading = false.obs;
  RxInt currentPage = 1.obs;
  RxInt totalPages = 0.obs;
  final refreshloading = false.obs;
  final rxRequestStatus = Status.LOADING.obs;
  void setRxRequestStatus(Status _value) => rxRequestStatus.value = _value;
  void setRxRequestData(LandListResponseModel _value) =>
      landData.value = _value;

  Future<void> landListData() async {
    loading.value = true;
    _api.landList({
      "Authorization": 'Bearer ${await prefs.getUserAccessToken()}',
      "Content-Type": "application/json"
    }, currentPage.value).then((value) {
      loading.value = false;
      setRxRequestData(value);
      if (landData.value.result?.data != null) {
        totalPages.value = landData.value.result!.pageInfo!.totalPage!.toInt();
        alllandListData.addAll(landData.value.result!.data!);
      }
    }).onError((error, stackTrace) {
      loading.value = false;
      print(error);
      print(stackTrace);
    });
  }

  void loadMoreData() {
    if (currentPage.value < totalPages.value) {
      currentPage.value++;
      landListData();
    } else {
      print('Already on the last page');
    }
  }

  Future<void> refreshAllLanddata() async {
    currentPage.value = 1;
    alllandListData.clear();
    await landListData();
  }

  /// for image
  var images = <String>[].obs;

  Future<void> pickImage(int index, int landId) async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      uploadImage(pickedFile.path, landId, index);
      // Trigger UI update
    }
  }

  Future uploadImage(String imagePath, int landId, int index) async {
    String? accessToken = await prefs.getUserAccessToken();
    try {
      final url = Uri.parse(ApiUrls.ADD_LAND_IMAGES);
      final request = http.MultipartRequest('POST', url);
      request.files.add(
        await http.MultipartFile.fromPath('image', imagePath),
      );

      request.fields['land'] = landId.toString();
      request.headers['Authorization'] = 'Bearer $accessToken';

      final response = await request.send();
      if (response.statusCode == 200) {
        print("LAND ID${landId.toString()}");

        print('Image uploaded successfully. ');
        alllandListData[index].images?.insert(0, Images(image: imagePath));
        alllandListData.refresh();
        update();
      } else {
        print('Error uploading imagePATH: ${response.reasonPhrase}');
      }
    } catch (e) {
      print('Error uploading image: $e');
    }
  }
}
