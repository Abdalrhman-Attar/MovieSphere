import 'package:get/get.dart';
import 'package:movie_sphere/controllers/locale.dart';
import 'package:movie_sphere/controllers/session_manager_controller.dart';
import 'package:movie_sphere/controllers/theme.dart';

class Controllers {
  static final ThemeController theme = Get.put(ThemeController());
  static final LocaleController locale = Get.put(LocaleController());
  static final SessionManagerController sessionManager = Get.put(SessionManagerController());

  static void init() {
    theme.onInit();
    locale.onInit();
    sessionManager.onInit();
  }

  static void dispose() {
    theme.onClose();
    locale.onClose();
    sessionManager.onClose();
  }
}
