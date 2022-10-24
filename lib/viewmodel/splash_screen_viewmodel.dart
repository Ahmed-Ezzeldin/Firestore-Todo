// ignore_for_file: use_build_context_synchronously

import 'dart:developer';
import 'package:firebase_mvvm/model/services/app_helper.dart';
import 'package:firebase_mvvm/model/services/base/base_model.dart';
import 'package:firebase_mvvm/model/services/provider_setup.dart';
import 'package:firebase_mvvm/view/screens/home_screen.dart';
import 'package:firebase_mvvm/view/screens/signin_screen.dart';
import 'package:flutter/material.dart';

class SplashScreenViewmodel extends BaseModel {
  final BuildContext context;
  SplashScreenViewmodel({required this.context}) {
    delayFun();
  }

  void delayFun() {
    Future.delayed(const Duration(milliseconds: 2000), () async {
      log("isLogin ${auth.isLogin}");
      if (auth.isLogin) {
        bool isLoadUser = await auth.loadUser();
        if (isLoadUser) {
          AppHelper.pushReplaceAll(context, const HomeScreen());
          AppHelper.printObject(auth.user);
        } else {
          AppHelper.pushReplaceAll(context, const SigninScreen());
        }
      } else {
        AppHelper.pushReplaceAll(context, const SigninScreen());
      }
    });
  }
}
