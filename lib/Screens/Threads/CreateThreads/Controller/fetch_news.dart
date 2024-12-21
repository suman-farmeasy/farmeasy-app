import 'dart:convert';
import 'package:farm_easy/Screens/Threads/Model/demoNewsdata.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class NewsController extends GetxController {
  var isLoading = true.obs;
  var newsList = <AgricultureNews>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchNews();
  }

  Future<void> fetchNews() async {
    const url =
        "https://newsdata.io/api/1/news?apikey=pub_629335b92fc7fb351a1bd1ec04963f8c4807b&q=agriculture&country=in";
    try {
      isLoading(true);
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final newsData = NewsData.fromJson(data);
        newsList.value = newsData.results ?? [];
      } else {
        Get.snackbar("Error", "Failed to load news");
      }
    } catch (e) {
      Get.snackbar("Error", e.toString());
    } finally {
      isLoading(false);
    }
  }
}
