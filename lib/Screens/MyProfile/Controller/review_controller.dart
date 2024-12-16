import 'package:farm_easy/Screens/HomeScreen/Model/LandListResponseModel.dart';
import 'package:farm_easy/Screens/HomeScreen/ViewModel/land_list_viewmodel.dart';
import 'package:farm_easy/Screens/MyProfile/Model/ListReviewResponseModel.dart';
import 'package:farm_easy/Screens/MyProfile/ViewModel/review_view_model.dart';
import 'package:farm_easy/API/Services/network/status.dart';
import 'package:farm_easy/Utils/SharedPreferences/shared_preferences.dart';
import 'package:get/get.dart';

class ReviewListController extends GetxController {
  final prefs = AppPreferences();
  final _api = ReviewListViewModel();
  final reviewData = ListReviewResponseModel().obs;
  final loading = false.obs;
  RxInt currentPage = 1.obs;
  RxInt totalPages = 0.obs;
  RxInt userId = 0.obs;
  final refreshloading = false.obs;
  final rxRequestStatus = Status.LOADING.obs;
  void setRxRequestStatus(Status _value) => rxRequestStatus.value = _value;
  void setRxRequestData(ListReviewResponseModel _value) =>
      reviewData.value = _value;

  Future<void> reviewListData(int userId) async {
    loading.value = true;
    _api.reviewList({
      "Authorization": 'Bearer ${await prefs.getUserAccessToken()}',
      "Content-Type": "application/json"
    }, userId).then((value) {
      loading.value = false;
      setRxRequestData(value);
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
  // void loadMoreData() {
  //   if (currentPage.value < totalPages.value) {
  //     currentPage.value++;
  //     landListData();
  //   } else {
  //
  //     print('Already on the last page');
  //   }
  // }
  // Future<void> refreshAllLanddata() async {
  //   currentPage.value = 1;
  //   alllandListData.clear();
  //   await landListData();
  // }
}
