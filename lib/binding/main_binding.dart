// ignore_for_file: unused_import


import 'package:get/get.dart';
import 'package:movie_sphere/controllers/locale.dart';
import 'package:movie_sphere/controllers/theme.dart';

class MainBinding implements Bindings {
  @override
  void dependencies() {
    Get.put(ThemeController(), permanent: true);
    Get.put(LocaleController(), permanent: true);
  }
}
