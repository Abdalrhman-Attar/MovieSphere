import 'dart:async';
import 'dart:ui';
import 'package:animated_splash_screen/animated_splash_screen.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get.dart';
import 'package:movie_sphere/binding/main_binding.dart';
import 'package:movie_sphere/common/controllers.dart';
import 'package:movie_sphere/common/shared_preferences.dart';
import 'package:movie_sphere/common/themes/dark_theme.dart';
import 'package:movie_sphere/common/themes/light_theme.dart';
import 'package:movie_sphere/generated/l10n.dart';
import 'package:movie_sphere/view/bottom_nav/bottom_nav_page.dart';
import 'package:movie_sphere/view/on_boarding/on_boarding_page.dart';
import 'package:movie_sphere/widgets/animated_logo.dart';
import 'package:movie_sphere/widgets/background_image_container.dart';
import 'package:page_transition/page_transition.dart';
import 'package:device_preview/device_preview.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  await MySharedPreferences.init();
  Controllers.init();

  await setUp();

  runApp(
    DevicePreview(
      enabled: false,
      builder: (context) => const MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return Obx(
      () => GetMaterialApp(
        initialBinding: MainBinding(),
        debugShowCheckedModeBanner: false,
        locale: MySharedPreferences.language == "en" ? const Locale("en", "US") : const Locale("ar", "EG"),
        localizationsDelegates: const [
          S.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: S.delegate.supportedLocales,
        theme: darkTheme,
        darkTheme: lightTheme,
        themeMode: Controllers.theme.currentTheme,
        home: BackgroundImageContainer(
          child: AnimatedSplashScreen(
            splash: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [AnimatedLogo()],
            ),
            nextScreen: MySharedPreferences.isFirstTime ? OnBoardingPage() : BottomNavPage(),
            splashTransition: SplashTransition.fadeTransition,
            pageTransitionType: PageTransitionType.fade,
            splashIconSize: MediaQuery.of(context).size.width * 0.6,
            backgroundColor: Colors.transparent,
            duration: 2000,
          ),
        ),
      ),
    );
  }
}

Future<void> setUp() async {
  await MySharedPreferences.init();

  // Load session data when app starts
  Controllers.sessionManager.sessionId.value = MySharedPreferences.sessionId;
  Controllers.sessionManager.accountId.value = MySharedPreferences.accountId;
  Controllers.sessionManager.requestToken.value = MySharedPreferences.requestToken;

  // Check if session exists
  if (Controllers.sessionManager.sessionId.value.isNotEmpty) {
    print("Existing session found. Retrieving account ID...");
    await Controllers.sessionManager.getAccountId();
  } else {
    print("No active session found. Checking request token...");

    if (Controllers.sessionManager.requestToken.value.isEmpty) {
      print("No request token found. Generating a new one...");
      await Controllers.sessionManager.createRequestToken();
      await Controllers.sessionManager.authenticateUser();
      await Controllers.sessionManager.createSession();
      await Controllers.sessionManager.getAccountId();
    } else {
      print("Request token found. Prompting user for authentication...");
      await Controllers.sessionManager.authenticateUser();
      await Controllers.sessionManager.createSession();
      await Controllers.sessionManager.getAccountId();
    }
  }
}
