import 'package:farm_easy/Screens/MyProfile/Model/ListReviewResponseModel.dart';
import 'package:farm_easy/Screens/MyProfile/ViewModel/review_view_model.dart';
import 'package:farm_easy/Services/network/status.dart';
import 'package:farm_easy/SharedPreferences/shared_preferences.dart';
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

      // You may add further logic here if needed
    }).onError((error, stackTrace) {
      loading.value = false;
      print(error);
      print(stackTrace);
    });
  }
}
