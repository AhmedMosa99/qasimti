import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qasimati/utils/localStorage/localStorge.dart';

class AppLanguage extends GetxController {
  var appLocal = "ar";
  var seletedCointry = 'all';
  @override
  void onInit() async {
    super.onInit();
    LocalStorage localStorage = LocalStorage();
    appLocal = await localStorage.languageSelected == null
        ? 'ar'
        : await localStorage.languageSelected;
    Get.updateLocale(Locale(appLocal));
    update();
  }

  void changeLanguage(String type) async {
    LocalStorage localStorage = LocalStorage();
    if (appLocal == type) {
      return;
    }
    if (type == 'ar') {
      appLocal = "ar";
      localStorage.saveLanguage('ar');
    } else {
      appLocal = "en";
      localStorage.saveLanguage('en');
    }
  }
}
