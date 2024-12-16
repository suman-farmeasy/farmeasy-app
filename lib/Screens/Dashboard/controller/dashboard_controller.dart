import 'package:farm_easy/Screens/Directory/Controller/land_owner_controller.dart';
import 'package:farm_easy/Screens/HomeScreen/Controller/home_controller.dart';
import 'package:farm_easy/Screens/HomeScreen/Controller/recomended_land_controller.dart';
import 'package:farm_easy/Screens/HomeScreen/ProfielSection/Controller/profile_complete_controller.dart';
import 'package:farm_easy/Screens/ProductAndServices/Controller/product_view_controller.dart';
import 'package:farm_easy/SharedPreferences/shared_preferences.dart';
import 'package:get/get.dart';

class DashboardController extends GetxController {
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    homecontroller.landListData();
    recomendedLand.recommendedLandData(100);
    landownerDiretory.landOwnerData();

    ever(selectedIndex, (_) {
      landlistController.landListData();
      productData.productDataList.clear();
    });
  }

  RxInt selectedIndex = 0.obs;
  RxList<String> title = <String>[].obs;
  void setIndex(int index) {
    selectedIndex.value = index;
  }

  final prefs = AppPreferences();
  final landlistController = Get.put(HomeController());
  final homecontroller = Get.put(HomeController());
  final recomendedLand = Get.put(RecommendedLandController());
  final productData = Get.put(ProductViewController());
  final landownerDiretory = Get.put(ListLandOwnerController());
  final profileController = Get.put(ProfilePercentageController());
}
