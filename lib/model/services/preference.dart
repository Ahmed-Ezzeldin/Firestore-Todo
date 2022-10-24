import 'dart:developer';
import 'package:firebase_mvvm/model/services/app_helper.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PrefKeys {
  static const String isUserLoged = "isUserLoged";
  static const String user = "user";
  static const String token = "token";
}

class Preference {
  static SharedPreferences? sharedPref;
  static Future<void> initialize() async {
    if (sharedPref == null) {
      sharedPref = await SharedPreferences.getInstance();
      setDefaultValues(getBool(PrefKeys.isUserLoged) == null);
    }
  }

  /// =================================================================================
  /// ============================================================== Set Default Values
  static void setDefaultValues(bool isNullValue) {
    if (isNullValue) {
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
