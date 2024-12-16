import 'package:farm_easy/Screens/Auth/CompleteProfile/Controller/land_owner_controller.dart';
import 'package:farm_easy/Screens/Dashboard/controller/current_location_controller.dart';
import 'package:farm_easy/Screens/Directory/Controller/land_owner_controller.dart';
import 'package:farm_easy/Screens/HomeScreen/Controller/home_controller.dart';
import 'package:farm_easy/Screens/HomeScreen/Controller/recomended_land_controller.dart';
import 'package:farm_easy/Screens/HomeScreen/ProfielSection/Controller/profile_complete_controller.dart';
import 'package:farm_easy/Screens/HomeScreen/ViewModel/land_list_viewmodel.dart';
import 'package:farm_easy/Screens/WeatherScreen/Controller/current_weather_controller.dart';
import 'package:farm_easy/Utils/SharedPreferences/shared_preferences.dart';
import 'package:get/get.dart';

class DashboardController extends GetxController {
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    homecontroller.landListData();
    recomendedLand.recommendedLandData();
    landownerDiretory.landOwnerData();
    ever(selectedIndex, (_) {
      landlistController.landListData();
    });
  }

  RxInt selectedIndex = 0.obs;
  RxList<String> title = <String>[].obs;

  final prefs = AppPreferences();
  final landlistController = Get.put(HomeController());
  final homecontroller = Get.put(HomeController());
  final recomendedLand = Get.put(RecommendedLandController());
  final landownerDiretory = Get.put(ListLandOwnerController());
  final profileController = Get.put(ProfilePercentageController());
}
