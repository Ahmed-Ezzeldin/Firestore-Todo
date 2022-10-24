import 'dart:convert';
import 'dart:io';
import 'dart:async';
import 'package:firebase_mvvm/view/styles/app_colors.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class AppHelper {
  /// ================================================================= Push
  static Future<dynamic> push(
    BuildContext context,
    Widget page, {
    bool replace = false,
  }) async {
    final route = MaterialPageRoute(builder: (ctx) => page);
    return replace ? await Navigator.pushReplacement(context, route) : await Navigator.push(context, route);
  }

  /// ================================================================= Push And Replace
  static Future<dynamic> pushReplaceAll(
    BuildContext context,
    Widget page, {
    bool rootNavigator = false,
  }) {
    return Navigator.of(
      context,
      rootNavigator: rootNavigator,
    ).pushAndRemoveUntil(
      MaterialPageRoute(builder: (context) => page),
      (Route<dynamic> route) => false,
    );
  }



  /// ================================================================= Unfocus
  static unfocusFun(BuildContext context) {
    FocusScope.of(context).unfocus();
  }

  /// ================================================================= Regular Print
  static printt(Object? object, {bool isError = false}) {
    if (kDebugMode) {
      if (isError) {
        print("====================================== ❗Error❗");
        print(object);
        print("====================================== ❗Error❗");
      } else {
        print(object);
      }
    }
  }

  /// =================================================================  Print Formated Object
  static printObject(Object? object, {String title = ""}) {
    String divider = "*************************************************";
    try {
      if (Platform.isAndroid) {
        AppHelper.printt("\x1B[35m $divider $title \x1B[0m");
        if (object != null) {
          /// *** Spaces is for space between opject items ***
          const JsonEncoder.withIndent("     ").convert(object).split("\n").forEach(
            (element) {
              AppHelper.printt("\x1B[35m$element\x1B[0m");
            },
          );
        }
        AppHelper.printt("\x1B[35m $divider \x1B[0m");
      } else {
        AppHelper.printt(divider);
        if (object != null) {
          const JsonEncoder.withIndent("     ").convert(object).split("\n").forEach(
            (element) {
              AppHelper.printt(element);
            },
          );
        }
        AppHelper.printt(divider);
      }
    } catch (e) {
      AppHelper.printt(e);
    }
  }

  /// ================================================================= Show Snack Bar
  static showSnackBarMessage(
    BuildContext context, {
    required String message,
    String? label,
    double radius = 0,
    int seconds = 5,
    SnackBarBehavior? behavior,
    bool isTop = false,
    TextAlign textAlign = TextAlign.start
  }) {
    ScaffoldMessenger.of(context).removeCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message, textAlign: textAlign),
        duration: Duration(seconds: seconds),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(radius)),
        behavior: behavior,
        margin: isTop
            ? EdgeInsets.only(
                bottom: MediaQuery.of(context).size.height - 120,
                left: 10,
                right: 10,
              )
            : null,
        action: label == null
            ? null
            : SnackBarAction(
                label: label,
                textColor: AppColors.primaryColor,
                onPressed: () {
                  Navigator.of(context);
                },
              ),
      ),
    );
  }
}
