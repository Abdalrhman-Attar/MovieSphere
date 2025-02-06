import 'package:shared_preferences/shared_preferences.dart';

class MySharedPreferences {
  static late SharedPreferences _sharedPreferences;

  static const String keyIsFirstTime = "key_isFirstTime";
  static const String keyLanguage = "key_language";
  static const String keyIsDarkMode = "key_isDarkMode";
  static const String keyRecentSearches = "key_recentSearches";

  // New keys for session management
  static const String keySessionId = "key_sessionId";
  static const String keyAccountId = "key_accountId";
  static const String KeyRequestToken = "key_requestToken";

  static Future init() async => _sharedPreferences = await SharedPreferences.getInstance();

  static bool get isFirstTime => _sharedPreferences.getBool(keyIsFirstTime) ?? true;
  static set isFirstTime(bool value) => _sharedPreferences.setBool(keyIsFirstTime, value);

  static String get language => _sharedPreferences.getString(keyLanguage) ?? "en";
  static set language(String value) => _sharedPreferences.setString(keyLanguage, value);

  static bool get isDarkMode => _sharedPreferences.getBool(keyIsDarkMode) ?? false;
  static set isDarkMode(bool value) => _sharedPreferences.setBool(keyIsDarkMode, value);

  static List<String> get recentSearches => _sharedPreferences.getStringList(keyRecentSearches) ?? [];
  static set recentSearches(List<String> value) => _sharedPreferences.setStringList(keyRecentSearches, value);

  static void addRecentSearch(String value) {
    final recentSearches = _sharedPreferences.getStringList(keyRecentSearches) ?? [];
    if (recentSearches.contains(value)) return;
    recentSearches.add(value);
    _sharedPreferences.setStringList(keyRecentSearches, recentSearches);
  }

  static void removeRecentSearch(String value) {
    final recentSearches = _sharedPreferences.getStringList(keyRecentSearches) ?? [];
    recentSearches.remove(value);
    _sharedPreferences.setStringList(keyRecentSearches, recentSearches);
  }

  static void clearRecentSearches() => _sharedPreferences.remove(keyRecentSearches);

  // Session Management
  static String get sessionId => _sharedPreferences.getString(keySessionId) ?? "";
  static set sessionId(String value) => _sharedPreferences.setString(keySessionId, value);

  static int get accountId => _sharedPreferences.getInt(keyAccountId) ?? 0;
  static set accountId(int value) => _sharedPreferences.setInt(keyAccountId, value);

  static String get requestToken => _sharedPreferences.getString(KeyRequestToken) ?? "";
  static set requestToken(String value) => _sharedPreferences.setString(KeyRequestToken, value);

  static void clearSession() {
    _sharedPreferences.remove(keySessionId);
    _sharedPreferences.remove(keyAccountId);
    _sharedPreferences.remove(KeyRequestToken);
  }
}
