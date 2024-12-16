import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class ApiService {
  final String baseUrl =
      'https://stag.vshopp.com/api/v1/categories/product-list';
  final String bearerToken =
      '2UFrWpJmym4Jp4qM0ZfnO46oqqrEBW1lsWMhlafq93M6hV4O9CLkbzejHW9D7SaKrb7yKRQ3p0fmCux24mlRgtLBqu8ehFZQNoh8sIie2jzofDe8OVTmGb56';

  Future<Map<String, dynamic>> fetchProducts(
      int page, int distanceCategory) async {
    final url =
        '$baseUrl?distanceCategory=$distanceCategory&page=$page&limit=10';
    print('Requesting URL: $url');

    final headers = {
      'authorization': 'Bearer $bearerToken',
      'moduleId': '3',
    };
    print('Request headers: $headers');

    final response = await http.get(
      Uri.parse(url),
      headers: headers,
    );

    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      print('Parsed data: $data');
      return {'items': data['items'], 'nextPageUrl': data['next_page_url']};
    } else {
      throw Exception('Failed to load products');
    }
  }
}

class ProductController extends GetxController {
  final ApiService apiService = ApiService();

  var products0to10 = <dynamic>[].obs;
  var products10to20 = <dynamic>[].obs;
  var products20Plus = <dynamic>[].obs;
  var nextPageUrl0to10 = ''.obs;
  var nextPageUrl10to20 = ''.obs;
  var nextPageUrl20Plus = ''.obs;
  var isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    fetchProducts(0);
  }

  Future<void> fetchProducts(int distanceCategory) async {
    if (isLoading.value) return;

    isLoading.value = true;

    int page = 1;
    if (distanceCategory == 0 && nextPageUrl0to10.value.isNotEmpty) {
      page = int.tryParse(nextPageUrl0to10.value) ?? 1;
    } else if (distanceCategory == 1 && nextPageUrl10to20.value.isNotEmpty) {
      page = int.tryParse(nextPageUrl10to20.value) ?? 1;
    } else if (distanceCategory == 2 && nextPageUrl20Plus.value.isNotEmpty) {
      page = int.tryParse(nextPageUrl20Plus.value) ?? 1;
    }

    final result = await apiService.fetchProducts(page, distanceCategory);

    if (distanceCategory == 0) {
      products0to10.addAll(result['items']);
      nextPageUrl0to10.value = result['nextPageUrl'] ?? '';
    } else if (distanceCategory == 1) {
      products10to20.addAll(result['items']);
      nextPageUrl10to20.value = result['nextPageUrl'] ?? '';
    } else {
      products20Plus.addAll(result['items']);
      nextPageUrl20Plus.value = result['nextPageUrl'] ?? '';
    }

    isLoading.value = false;
  }
}

class ProductPage extends StatelessWidget {
  final ProductController productController = Get.put(ProductController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Products Data')),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Image.network(
                'https://stag.vshopp.com/uploads/2024-04-08-66139d96cb116.png'),
            Obx(() => buildProductScroller(productController.products0to10, 0,
                productController.nextPageUrl0to10)),
            Obx(() => buildProductScroller(productController.products10to20, 1,
                productController.nextPageUrl10to20)),
            Obx(() => buildProductScroller(productController.products20Plus, 2,
                productController.nextPageUrl20Plus)),
          ],
        ),
      ),
    );
  }

  Widget buildProductScroller(
      List<dynamic> products, int distanceCategory, RxString nextPageUrl) {
    return Column(
      children: [
        GridView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 10.0,
            mainAxisSpacing: 10.0,
          ),
          itemCount: products.length,
          itemBuilder: (context, index) {
            final product = products[index];
            return Card(
              elevation: 5,
              child: Column(
                children: [
                  Image.network(
                      'https://stag.vshopp.com/uploads/${product['image']}',
                      height: 100,
                      width: 100),
                  Text(product['name'],
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  Text('Price: ₹${product['price']}'),
                  Text('Rating: ${product['avg_rating'] ?? 'N/A'}')
                ],
              ),
            );
          },
        ),
        if (nextPageUrl.value.isNotEmpty)
          TextButton(
            onPressed: () {
              productController.fetchProducts(distanceCategory);
            },
            child: productController.isLoading.value
                ? CircularProgressIndicator()
                : Text('Load More'),
          ),
      ],
    );
  }
}
