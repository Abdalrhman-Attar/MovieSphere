import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LocaleController extends GetxController {
  var appLocale = const Locale('en', 'US').obs;

  void changeLanguage(String languageCode) {
    Locale locale = Locale(languageCode);
    appLocale.value = locale;
    Get.updateLocale(locale);
  }

  Future<void> setLocale(Locale locale) async {
    appLocale.value = locale;
    Get.updateLocale(locale);
  }

  bool getIsRtl() {
    return appLocale.value.languageCode == 'ar';
  }

  @override
  void onInit() {
    super.onInit();
    String? savedLanguageCode = Get.locale?.languageCode;
    if (savedLanguageCode != null) {
      appLocale.value = Locale(savedLanguageCode);
    }
  }
}
