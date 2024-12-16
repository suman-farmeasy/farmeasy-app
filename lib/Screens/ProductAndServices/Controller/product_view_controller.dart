import 'package:farm_easy/Screens/ProductAndServices/Model/product_services_model.dart';
import 'package:farm_easy/Screens/ProductAndServices/ViewModel/product_view_model.dart';
import 'package:farm_easy/API/Services/network/status.dart';
import 'package:farm_easy/Utils/SharedPreferences/shared_preferences.dart';
import 'package:get/get.dart';

class ProductViewController extends GetxController {
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    userValue();
    productList();
  }

  void resetPageToFirst() {
    currentPage.value = 1;
  }

  RxInt current = (-1).obs;
  RxInt totalPage = 0.obs;

  final _api = ProductListListViewModel();
  final productData = ProductServiceListModel().obs;

  void userValue() async {
    userId.value = await _prefs.getUserId();
    print('User ID: ${userId.value}');
  }

  RxList<Data> productDataList = <Data>[].obs;
  final loading = false.obs;
  final _prefs = AppPreferences();
  final rxRequestStatus = Status.LOADING.obs;
  RxInt currentPage = 1.obs;
  RxInt userId = 0.obs;

  void setRxRequestStatus(Status _value) => rxRequestStatus.value = _value;

  void setRxRequestData(ProductServiceListModel _value) =>
      productData.value = _value;

  Future<void> productList({bool clearList = false}) async {
    loading.value = true;
    Status.LOADING;
    if (clearList) {
      productDataList.clear();
    }
    _api.productServices({
      "Authorization": 'Bearer ${await _prefs.getUserAccessToken()}',
      "Content-Type": "application/json"
    }, userId.value, currentPage.value).then((value) {
      loading.value = false;
      setRxRequestData(value);
      setRxRequestStatus(Status.SUCCESS);

      if (productData.value.result!.data != null) {
        totalPage.value =
            productData.value.result!.pageInfo!.totalPage!.toInt();
        productDataList.addAll(productData.value.result!.data!);
      }
    }).onError((error, stackTrace) {
      loading.value = false;
    });
  }

  void loadMoreData() {
    if (currentPage.value < totalPage.value) {
      currentPage.value++;
      productList();
    } else {
      print('Already on the last page');
    }
  }

  Future<void> refreshAllproduct() async {
    currentPage.value = 1;
    productDataList.clear();
    await productList();
  }
}
