import 'package:farm_easy/Screens/Auth/CompleteProfile/Controller/get_profile_controller.dart';
import 'package:farm_easy/Screens/ProductAndServices/Controller/delete_product_controller.dart';
import 'package:farm_easy/Screens/ProductAndServices/EditProduct/View/edit_product.dart';
import 'package:farm_easy/Screens/ProductAndServices/Model/product_services_model.dart';
import 'package:farm_easy/Screens/ProductAndServices/ViewModel/product_view_model.dart';
import 'package:farm_easy/API/Services/network/status.dart';
import 'package:farm_easy/utils/SharedPreferences/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class ProductViewController extends GetxController {
  void resetPageToFirst() {
    currentPage.value = 1;
  }

  final getProfile = Get.find<GetProfileController>();

  RxInt current = (-1).obs;
  RxInt totalPage = 0.obs;

  final _api = ProductListListViewModel();
  final productData = ProductServiceListModel().obs;

  RxList<Data> productDataList = <Data>[].obs;
  RxList<Data> productDataListNew = <Data>[].obs;
  final loading = false.obs;
  final _prefs = AppPreferences();
  final rxRequestStatus = Status.LOADING.obs;
  RxInt currentPage = 1.obs;

  void setRxRequestStatus(Status _value) => rxRequestStatus.value = _value;

  void setRxRequestData(ProductServiceListModel _value) =>
      productData.value = _value;

  Future<void> productList(
      {bool clearList = false, required int userId}) async {
    loading.value = true;
    Status.LOADING;
    if (clearList) {
      productDataList.clear();
    }
    _api.productServices({
      "Authorization": 'Bearer ${await _prefs.getUserAccessToken()}',
      "Content-Type": "application/json"
    }, userId, currentPage.value).then((value) {
      loading.value = false;
      setRxRequestData(value);
      setRxRequestStatus(Status.SUCCESS);

      if (productData.value.result!.data != null) {
        totalPage.value =
            productData.value.result!.pageInfo!.totalPage!.toInt();
        productDataList.addAll(productData.value.result!.data!);
      }
      if (productData.value.result!.data != null) {
        totalPage.value =
            productData.value.result!.pageInfo!.totalPage!.toInt();
        productDataListNew.addAll(productData.value.result!.data!);
      }
    }).onError((error, stackTrace) {
      loading.value = false;
    });
  }

  Future<void> userProductList(int userId) async {
    loading.value = true;
    Status.LOADING;

    _api.productServices({
      "Authorization": 'Bearer ${await _prefs.getUserAccessToken()}',
      "Content-Type": "application/json"
    }, userId, currentPage.value).then((value) {
      loading.value = false;
      setRxRequestData(value);
      setRxRequestStatus(Status.SUCCESS);
    }).onError((error, stackTrace) {
      loading.value = false;
    });
  }

  void loadMoreData(int userId) {
    if (currentPage.value < totalPage.value) {
      currentPage.value++;
      productList(userId: userId);
    } else {
      print('Already on the last page');
    }
  }

  Future<void> refreshAllproduct(int userId) async {
    currentPage.value = 1;
    productDataList.clear();
    await productList(userId: userId);
  }

  void showPopupMenu(
    BuildContext context,
    int index,
    TapDownDetails details,
    String title,
    int id,
    List<String> images,
    List<int> imagesId,
    String description,
    String currency,
    String unitPrice,
    String unit,
    String unitValue,
  ) async {
    final tapPosition = details.globalPosition;

    final result = await showMenu(
      context: context,
      position: RelativeRect.fromLTRB(
        tapPosition.dx,
        tapPosition.dy,
        tapPosition.dx + 1,
        tapPosition.dy + 1,
      ),
      items: [
        PopupMenuItem<String>(
          value: 'Edit',
          child: Row(
            children: [
              SvgPicture.asset("assets/img/editp.svg"),
              SizedBox(width: 8),
              Text('Edit'),
            ],
          ),
        ),
        PopupMenuItem<String>(
          value: 'Delete',
          child: Row(
            children: [
              SvgPicture.asset("assets/img/del.svg"),
              SizedBox(width: 8),
              Text('Delete'),
            ],
          ),
        ),
      ],
    );

    if (result == 'Edit') {
      Get.to(() => EditProduct(
            images: images,
            imagesId: imagesId,
            title: title,
            discription: description,
            unit: unit,
            currency: currency,
            unitPrice: unitPrice,
            unitValue: unitValue,
            id: id,
          ));
    } else if (result == 'Delete') {
      showDeleteDialog(
        index,
        title,
        id,
      ); // Call the delete dialog
    }
  }

  final deleteProduct = Get.put(DeleteProductController());
  void showDeleteDialog(
    int index,
    String title,
    int id,
  ) {
    Get.dialog(
      AlertDialog(
        title: Text("Delete Product"),
        content: Text("Are you sure you want to delete '$title'?"),
        actions: [
          TextButton(
            onPressed: () => Get.back(), // Close the dialog
            child: Text("Cancel"),
          ),
          TextButton(
            onPressed: () {
              productDataList.removeAt(index);
              productDataList.refresh();
              deleteProduct.deleteProduct(id);

              Get.back();
            },
            child: Text("Delete"),
          ),
        ],
      ),
    );
  }
}
