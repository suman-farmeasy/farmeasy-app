import 'package:farm_easy/Screens/HomeScreen/Model/ListAgriProviderResponseModel.dart';
import 'package:farm_easy/Screens/HomeScreen/ViewModel/land_list_viewmodel.dart';
import 'package:farm_easy/API/Services/network/status.dart';
import 'package:farm_easy/Utils/SharedPreferences/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ListAgriProviderController extends GetxController {
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    agriDataList();
  }

  RxInt currentPage = 1.obs;
  RxInt totalPages = 0.obs;
  RxList<Data> agriProviderData = <Data>[].obs;
  RxList<Data> agriProviderDataId = <Data>[].obs;
  final prefs = AppPreferences();
  final _api = ListAgriProviderViewModel();
  final agriData = ListAgriProviderResponseModel().obs;
  final loading = false.obs;
  final searchController = TextEditingController();
  RxString searchAgriProvider = "".obs;
  void searchAgri(String query) {
    agriProviderData.clear();
    searchAgriProvider.value = query;
    agriDataList();
  }

  void clearSearch() {
    searchController.clear();
    searchAgri("");
  }

  RxInt serviceID = 0.obs;
  final rxRequestStatus = Status.LOADING.obs;
  void setRxRequestStatus(Status _value) => rxRequestStatus.value = _value;
  void setRxRequestData(ListAgriProviderResponseModel _value) =>
      agriData.value = _value;
  Future<void> agriDataList() async {
    loading.value = true;
    rxRequestStatus.value = Status.LOADING;
    _api.agriProvider({
      "Authorization": 'Bearer ${await prefs.getUserAccessToken()}',
      "Content-Type": "application/json"
    }, currentPage.value, searchAgriProvider.value, serviceID.value).then(
        (value) {
      setRxRequestData(value);
      setRxRequestStatus(Status.SUCCESS);
      loading.value = false;
      if (agriData.value.result?.data != null) {
        totalPages.value = agriData.value.result!.pageInfo!.totalPage!.toInt();
        agriProviderData.addAll(agriData.value.result!.data!);
      }
    }).onError((error, stackTrace) {
      Status.ERROR;
      loading.value = false;
      print("=================================================${error}");
      print("=================================================${stackTrace}");
    });
  }

  Future<void> agriDataListId(int serviceId) async {
    loading.value = true;
    rxRequestStatus.value = Status.LOADING;
    _api.agriProvider({
      "Authorization": 'Bearer ${await prefs.getUserAccessToken()}',
      "Content-Type": "application/json"
    }, currentPage.value, searchAgriProvider.value, serviceId).then((value) {
      setRxRequestData(value);
      setRxRequestStatus(Status.SUCCESS);
      loading.value = false;

      if (agriData.value.result?.data != null) {
        totalPages.value = agriData.value.result!.pageInfo!.totalPage!.toInt();
        agriProviderDataId.addAll(agriData.value.result!.data!);
      }
    }).onError((error, stackTrace) {
      Status.ERROR;
      loading.value = false;
      print("=================================================${error}");
      print("=================================================${stackTrace}");
    });
  }

  void loadMoreData() {
    if (currentPage.value < totalPages.value) {
      currentPage.value++;
      agriDataList();
    } else {
      print('Already on the last page');
    }
  }

  Future<void> refreshAllagriProvider() async {
    currentPage.value = 1;
    agriProviderData.clear();
    await agriDataList();
  }

  Future<void> refreshAllagriProviderId() async {
    currentPage.value = 1;
    agriProviderDataId.clear();
  }
}
