import 'dart:io';

import 'package:farm_easy/Screens/Auth/Role%20Selection/View/role_selection.dart';
import 'package:farm_easy/Screens/Auth/UserResgister/View/user_registration.dart';
import 'package:farm_easy/Screens/Dashboard/view/dashboard.dart';
import 'package:farm_easy/Screens/OnboardingScreen/view/intro_screen.dart';
import 'package:farm_easy/Screens/SplashScreen/Model/forceUpdateModel.dart';
import 'package:farm_easy/Screens/SplashScreen/ViewModel/is_user_exist_view_model.dart';
import 'package:farm_easy/Screens/UpdateScreen/View/update_screen.dart';
import 'package:farm_easy/Services/network/status.dart';
import 'package:farm_easy/SharedPreferences/shared_preferences.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:pub_semver/pub_semver.dart';

class SplashController extends GetxController
    with SingleGetTickerProviderMixin {
  late AnimationController controllerTop;
  late AnimationController controllerBottom;
  late Animation<Offset> animationTop;
  late Animation<Offset> animationBottom;

  final AppPreferences _prefs = AppPreferences();

  @override
  void onInit() {
    super.onInit();

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

  final rxRequestStatus = Status.LOADING.obs;
  final _api = SplashViewModel();
  final forceUpdateModel = ForceUpdateModel().obs;
  final loading = false.obs;
  final versionName = "".obs;
  RxString versionNumber = "".obs;

  void getVersionCodeAndName() async {
    final PackageInfo packageInfo = await PackageInfo.fromPlatform();
    versionName.value = packageInfo.version;
    versionNumber.value = packageInfo.buildNumber;
    print(versionName.value);
    print(versionNumber.value);
    forceUpdateSplash();
  }

  void forceUpdateSplash() {
    _api
        .forceUpdate(Platform.isAndroid ? "android" : "ios")
        .then((value) async {
      forceUpdateModel.value = value;
      if ((value.result?.isRequired ?? false)) {
        if (Platform.isIOS) {
          final appVersioniOS = Version.parse(versionName.value);
          final apiVersioniOS =
              Version.parse(forceUpdateModel.value.result?.version ?? "");
          if (appVersioniOS >= apiVersioniOS) {
            isLogin();
          } else {
            Get.offAll(UpdateScreen());
          }
        } else {
          if (int.parse(versionNumber.value) >=
              (value.result?.versionCode ?? 0)) {
            isLogin();
          } else {
            Get.offAll(UpdateScreen());
          }
        }
      } else {
        isLogin();
      }

      loading.value = false;
    }).onError((error, stackTrace) {
      print(
          "****************************************ERROR*****************************************");
      print(error);
    });
  }

  // void forceUpdateSplash() {
  //   _api
  //       .forceUpdate(Platform.isAndroid ? "Android" : "ios")
  //       .then((value) async {
  //     forceUpdateModel.value = value;
  //     if (Platform.isIOS) {
  //       final appVersioniOS = Version.parse(versionName.value);
  //       print("VERSION${Version.parse(versionName.value)}");
  //       final apiVersioniOSfromData =
  //           Version.parse(forceUpdateModel.value.result?.version ?? "");
  //       if (appVersioniOS >= apiVersioniOSfromData) {
  //         isLogin();
  //       } else {
  //         Get.offAll(() => UpdateScreen());
  //       }
  //     } else {
  //       final apiVersionCode = forceUpdateModel.value.result?.versionCode ?? 0;
  //       print(
  //           "Android App Version Code: ${versionNumber.value}, API Version Code: $apiVersionCode");
  //       if (int.tryParse(versionNumber.value) == apiVersionCode) {
  //         isLogin();
  //       } else {
  //         Get.offAll(() => UpdateScreen());
  //       }
  //     }
  //     loading.value = false;
  //   }).onError((error, stackTrace) {
  //     print(
  //         "****************************************ERROR*****************************************");
  //     print(error);
  //     print(stackTrace);
  //   });
  // }
}

class SplashControllerD extends GetxController {
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
  }
}
