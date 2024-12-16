import 'package:get/get.dart';
import 'package:flutter/material.dart';

class LocaleController extends GetxController {
  void changeLocale(String languageCode) {
    var locale = Locale(languageCode);
    Get.updateLocale(locale);
  }
}
