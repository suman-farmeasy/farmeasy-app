import 'package:farm_easy/Screens/AllEnquiries/Model/AllEnquiriesResponseModel.dart';
import 'package:farm_easy/Screens/AllEnquiries/ViewModel/all_enquireis_view_model.dart';
import 'package:farm_easy/API/Services/network/status.dart';
import 'package:farm_easy/utils/SharedPreferences/shared_preferences.dart';
import 'package:get/get.dart';

class AllEnquiriesController extends GetxController {
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    allEnquiries();
    print("addff");
  }

  RxList<Data> allEnquiriesList = <Data>[].obs;
  RxInt enquiryId = 0.obs;
  RxInt totalPages = 0.obs;
  RxInt currentPage = 1.obs;
  final _api = AllEnquiriesViewModel();
  final allenquiriesData = AllEnquiriesResponseModel().obs;
  final loading = false.obs;
  final _prefs = AppPreferences();
  final rxRequestStatus = Status.LOADING.obs;
  void setRxRequestStatus(Status _value) => rxRequestStatus.value = _value;
  void setRxRequestData(AllEnquiriesResponseModel _value) =>
      allenquiriesData.value = _value;
  Future<void> allEnquiries() async {
    loading.value = true;
    _api.allEnquiries({
      "Authorization": 'Bearer ${await _prefs.getUserAccessToken()}',
      "Content-Type": "application/json"
    }, currentPage.value).then((value) {
      loading.value = false;
      setRxRequestData(value);
      setRxRequestStatus(Status.SUCCESS);
      if (allenquiriesData.value.result?.data != null) {
        totalPages.value =
            allenquiriesData.value.result!.pageInfo!.totalPage!.toInt();
        allEnquiriesList.addAll(allenquiriesData.value.result!.data!);
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
      allEnquiries();
    } else {
      print('Already on the last page');
    }
  }

  Future<void> refreshAllEnquiries() async {
    currentPage.value = 1;
    allEnquiriesList.clear();
    await allEnquiries();
  }
}
