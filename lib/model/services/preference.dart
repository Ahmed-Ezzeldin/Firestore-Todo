import 'dart:developer';
import 'package:firebase_mvvm/model/services/app_helper.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PrefKeys {
  static const String isFirstLaunch = "isFirstLaunch";
  static const String isNotification = "isNotification";
  static const String isUserLoged = "isUserLoged";
  static const String languageCode = "languageCode";
  static const String languageName = "languageName";
  static const String isDark = "isDark";
  static const String theme = "theme";
  static const String user = "user";
  static const String token = "token";
  static const String fcmToken = "fcmToken";
}

class Preference {
  static SharedPreferences? sharedPref;
  static Future<void> initialize() async {
    if (sharedPref == null) {
      sharedPref = await SharedPreferences.getInstance();
      setDefaultValues(getString(PrefKeys.theme) == null);
    }
  }

  /// =================================================================================
  /// ============================================================== Set Default Values
  static void setDefaultValues(bool isNullValue) {
    if (isNullValue) {
      setString(PrefKeys.theme, "Light");
      setString(PrefKeys.languageCode, "en");
      setString(PrefKeys.languageName, "English");
      setBool(PrefKeys.isFirstLaunch, true);
      setBool(PrefKeys.isNotification, true);
      setBool(PrefKeys.isUserLoged, false);
      log("*** setDefaultValues is called ***");
    }
  }

  /// =================================================================================
  /// ============================================================================  Get
  static String? getString(String key) {
    try {
      return sharedPref!.getString(key);
    } catch (error) {
      AppHelper.printt(error);
    }
    return null;
  }

  static bool? getBool(String key) {
    try {
      return sharedPref!.getBool(key);
    } catch (error) {
      AppHelper.printt(error);
    }
    return null;
  }

  static int? getInt(String key) {
    try {
      return sharedPref!.getInt(key);
    } catch (error) {
      AppHelper.printt(error);
    }
    return null;
  }

  /// =================================================================================
  /// ============================================================================  Set
  static Future<bool?> setString(String key, String value) async {
    try {
      return await sharedPref!.setString(key, value);
    } catch (error) {
      AppHelper.printt(error);
    }
    return null;
  }

  static Future<bool?> setBool(String key, bool value) async {
    try {
      return await sharedPref!.setBool(key, value);
    } catch (error) {
      AppHelper.printt(error);
    }
    return null;
  }

  static Future<bool?> setInt(String key, int value) async {
    try {
      return await sharedPref!.setInt(key, value);
    } catch (error) {
      AppHelper.printt(error);
    }
    return null;
  }

  /// =================================================================================
  /// ========================================================================== Reload
  static Future<void> reload() async {
    try {
      await sharedPref!.reload();
    } catch (error) {
      AppHelper.printt(error);
    }
  }

  /// =================================================================================
  /// ========================================================================== Remove
  static Future<bool?> remove(String key) async {
    try {
      return await sharedPref!.remove(key);
    } catch (error) {
      AppHelper.printt(error);
    }
    return null;
  }

  /// =================================================================================
  /// =========================================================================== Clear
  static Future<bool?> clear() async {
    try {
      return await sharedPref!.clear();
    } catch (error) {
      AppHelper.printt(error);
    }
    return null;
  }
}
