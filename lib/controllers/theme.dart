import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:movie_sphere/common/themes/dark_theme.dart';
import 'package:movie_sphere/common/themes/light_theme.dart';

class ThemeController extends GetxController {
  final Rx<ThemeMode> themeMode = ThemeMode.light.obs;

  void toggleTheme() {
    themeMode.value = themeMode.value == ThemeMode.light ? ThemeMode.dark : ThemeMode.light;
    Get.changeThemeMode(themeMode.value);
  }

  ThemeMode get currentTheme => themeMode.value;
  set currentTheme(ThemeMode mode) => themeMode.value = mode;

  ThemeData get currentThemeData => themeMode.value == ThemeMode.light ? lightTheme : darkTheme;

  @override
  void onInit() {
    super.onInit();
  }
}
