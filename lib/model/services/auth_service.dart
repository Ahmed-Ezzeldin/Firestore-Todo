import 'dart:convert';

import 'package:firebase_mvvm/model/models/user_model.dart';
import 'package:firebase_mvvm/model/services/app_helper.dart';
import 'package:firebase_mvvm/model/services/preference.dart';
import 'package:flutter/cupertino.dart';

class AuthService extends ChangeNotifier {
  UserModel? _user;
  UserModel? get user => _user;
  bool get isLogin => Preference.getBool(PrefKeys.isUserLoged) == true;

  saveUser(UserModel user) {
    try {
      Preference.setString(PrefKeys.user, json.encode(user.toJson()));
      Preference.setString(PrefKeys.token, "======== USER_TOKEN ========");
      Preference.setBool(PrefKeys.isUserLoged, true);
      _user = user;
      AppHelper.printObject(user);
      notifyListeners();
    } catch (e) {
      AppHelper.printt("saveUser error ---> $e");
    }
  }

  Future<bool> loadUser() async {
    try {
      Map<String, dynamic> userMap = json.decode(Preference.getString(PrefKeys.user)!);
      _user = UserModel.fromJson(userMap);
      notifyListeners();
      return true;
    } catch (e) {
      AppHelper.printt("loadUser error ---> $e");
      await Preference.clear();
      return false;
    }
  }

  Future<void> signOut() async {
    await Preference.clear();
    _user = null;
  }

  Future<bool> signIn(UserModel user) async {
    try {
      saveUser(user);
      await loadUser();
      return true;
    } catch (e) {
      AppHelper.printt(e);
      return false;
    }
  }

  Future<bool> signUp(UserModel user) async {
    try {
      saveUser(user);
      await loadUser();
      return true;
    } catch (e) {
      AppHelper.printt(e);
      return false;
    }
  }
}
