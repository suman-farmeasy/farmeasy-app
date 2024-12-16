import 'package:farm_easy/Screens/Auth/UserResgister/ViewModel/agri_provider_response_model.dart';
import 'package:farm_easy/Screens/Partners/Model/services_model.dart';
import 'package:farm_easy/Services/network/status.dart';
import 'package:farm_easy/SharedPreferences/shared_preferences.dart';
import 'package:get/get.dart';

class PartnerServicesList extends GetxController {
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    services();
  }

  final prefs = AppPreferences();
  final _api = AgriProvideServicesListViewModel();
  final servicesData = ListPartnerServices().obs;
  RxList agriItems = [].obs;
  final loading = false.obs;
  RxInt selectedIndex = 0.obs;
  void selectItem(int index) {
    selectedIndex.value = index;
  }

  final refreshloading = false.obs;
  final rxRequestStatus = Status.LOADING.obs;
  void setRxRequestStatus(Status _value) => rxRequestStatus.value = _value;
  void setRxRequestData(ListPartnerServices _value) =>
      servicesData.value = _value;

  Future<void> services() async {
    loading.value = true;
    _api.agriProvider().then((value) {
      loading.value = false;
      setRxRequestData(value);
      setRxRequestStatus(Status.SUCCESS);
      // if (landData.value.result?.data != null) {
      //   totalPages.value = landData.value.result!.pageInfo!.totalPage!.toInt();
      //   alllandListData.addAll(landData.value.result!.data!);
      // }
    }).onError((error, stackTrace) {
      loading.value = false;
      print(error);
      print(stackTrace);
    });
  }
}
