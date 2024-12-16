import 'package:farm_easy/Screens/ProductAndServices/Model/delete_product_response_model.dart';
import 'package:farm_easy/Screens/ProductAndServices/ViewModel/product_view_model.dart';
import 'package:farm_easy/Services/network/status.dart';
import 'package:farm_easy/SharedPreferences/shared_preferences.dart';
import 'package:get/get.dart';

class DeleteProductController extends GetxController {
  RxInt totalPage = 0.obs;

  final _api = DeleteProductViewModel();
  final deletePrdoct = DeleteProductResponseModel().obs;
  final loading = false.obs;
  final _prefs = AppPreferences();
  final rxRequestStatus = Status.LOADING.obs;

  void setRxRequestStatus(Status _value) => rxRequestStatus.value = _value;
  void setRxRequestData(DeleteProductResponseModel _value) =>
      deletePrdoct.value = _value;
  Future<void> deleteProduct(int product) async {
    loading.value = true;
    _api.deleteProduct({
      "Authorization": 'Bearer ${await _prefs.getUserAccessToken()}',
      "Content-Type": "application/json"
    }, product).then((value) {
      loading.value = false;
      setRxRequestData(value);
      setRxRequestStatus(Status.SUCCESS);
    }).onError((error, stackTrace) {
      loading.value = false;
      print(error);
      print(stackTrace);
    });
  }
}
