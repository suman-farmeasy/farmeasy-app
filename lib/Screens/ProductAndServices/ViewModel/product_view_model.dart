import 'package:farm_easy/ApiUrls/api_urls.dart';
import 'package:farm_easy/Screens/ProductAndServices/Model/delete_product_response_model.dart';
import 'package:farm_easy/Screens/ProductAndServices/Model/product_services_model.dart';
import 'package:farm_easy/Screens/Threads/CreateThreads/Model/ThreadCreatedResponseModel.dart';
import 'package:farm_easy/Services/network/network_api_services.dart';

class CreateProductViewModel {
  final _api = NetworkApiServices();
  Future<ThreadCreatedResponseModel> createProduct(
      var data, var headerMap) async {
    dynamic response =
        await _api.postApi(ApiUrls.ADD_PRODUCT, data, true, headerMap);
    return ThreadCreatedResponseModel.fromJson(response);
  }
}

class ProductListListViewModel {
  final _api = NetworkApiServices();
  Future<ProductServiceListModel> productServices(
      var headerMap, int userId, int currentPage) async {
    dynamic response = await _api.getApi(
        ApiUrls.PRODUCT_SERVICES + '$userId&page=$currentPage',
        true,
        headerMap);
    return ProductServiceListModel.fromJson(response);
  }
}

class DeleteProductViewModel {
  final _api = NetworkApiServices();
  Future<DeleteProductResponseModel> deleteProduct(
      var headerMap, int productId) async {
    dynamic response = await _api.deleteApi(
        ApiUrls.DELETE_PRODUCT + '$productId', true, headerMap);
    return DeleteProductResponseModel.fromJson(response);
  }
}

class UpdateProductViewModel {
  final _api = NetworkApiServices();
  Future<ThreadCreatedResponseModel> updateProduct(
      int productId, var data, var headerMap) async {
    dynamic response = await _api.patchApi(
        ApiUrls.UPDATE_PRODUCT + '$productId', data, true, headerMap);
    return ThreadCreatedResponseModel.fromJson(response);
  }
}
