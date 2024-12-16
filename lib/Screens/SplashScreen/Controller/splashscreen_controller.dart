import 'package:farm_easy/Screens/Auth/LoginPage/View/login_page.dart';
import 'package:farm_easy/Screens/Auth/Role%20Selection/View/role_selection.dart';
import 'package:farm_easy/Screens/Auth/UserResgister/View/user_registration.dart';
import 'package:farm_easy/Screens/Dashboard/controller/current_location_controller.dart';
import 'package:farm_easy/Screens/Dashboard/view/dashboard.dart';
import 'package:farm_easy/Screens/HomeScreen/View/home_screen.dart';
import 'package:farm_easy/Screens/OnboardingScreen/view/intro_screen.dart';
import 'package:farm_easy/Screens/SplashScreen/Model/IsUserExist.dart';
import 'package:farm_easy/Screens/SplashScreen/ViewModel/is_user_exist_view_model.dart';
import 'package:farm_easy/Screens/WeatherScreen/Controller/current_weather_controller.dart';
import 'package:farm_easy/API/Services/network/status.dart';
import 'package:farm_easy/Utils/SharedPreferences/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class SplashController extends GetxController
    with SingleGetTickerProviderMixin {
  late AnimationController controllerTop;
  late AnimationController controllerBottom;
  late Animation<Offset> animationTop;
  late Animation<Offset> animationBottom;

  final AppPreferences _prefs = AppPreferences();
  final locationCOntroller = Get.put(CurrentLocation());

  @override
  void onInit() {
    super.onInit();
    locationCOntroller.detectLocation();
    print(
        "@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@     location controller initilized");
    controllerTop = AnimationController(
      vsync: this,
      duration: Duration(seconds: 2),
    );

    controllerBottom = AnimationController(
      vsync: this,
      duration: Duration(seconds: 2),
    );
    animationTop = Tween<Offset>(begin: Offset(0, -5), end: Offset(0, -1.2))
        .animate(controllerTop);
    animationBottom = Tween<Offset>(begin: Offset(0, 5), end: Offset(0, 1))
        .animate(controllerBottom);

    controllerTop.forward();
    controllerBottom.forward();

    controllerTop.addStatusListener((status) {
      if (status == AnimationStatus.completed) {}
    });
    controllerBottom.addStatusListener((status) {
      if (status == AnimationStatus.completed) {}
    });
  }

  isLogin() async {
    bool isLoggedIn = await _prefs.isUserLoggedIn();
    if (isLoggedIn) {
      Get.offAll(() => DashBoard());
      String userRole = await _prefs.getUserRole();

      if (userRole.isEmpty) {
        Get.offAll(RoleSelection());
      } else {
        String userName = await _prefs.getUserName();
        if (userName.isEmpty) {
          Get.offAll(
              UserRegistration(userType: "${await _prefs.getUserRole()}"));
        } else {
          print(
              "========================================Screen=========================================");
          Get.offAll(() => DashBoard());
        }
      }
    } else {
      Get.offAll(IntroductionScreen());
    }
  }

  @override
  void onClose() {
    controllerTop.dispose();
    controllerBottom.dispose();
    super.onClose();
  }
}
