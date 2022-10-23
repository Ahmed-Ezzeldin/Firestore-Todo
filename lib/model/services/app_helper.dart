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
      // *** rootNavigator (true) to pushing contents above all subsequent instances ***
      // *** ( i used with CupertinoTabView to remove bottom bar from bottom ) ***
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

  /// ================================================================= Colored Print
  static printColor(dynamic text, {String color = "green"}) {
    Map<String, String> colorsMap = {
      // -------------- Text colors --------------
      "reset": "\x1B[0m",
      "black": "\x1B[30m",
      "red": "\x1B[31m",
      "green": "\x1B[32m",
      "yellow": "\x1B[33m",
      "blue": "\x1B[34m",
      "magenta": "\x1B[35m",
      "cyan": "\x1B[36m",
      "white": "\x1B[37m",
      // ----------- Background colors ------------
      "back1": "\x1B[40m",
      "back2": "\x1B[41m",
      "back3": "\x1B[42m",
      "back4": "\x1B[43m",
      "back5": "\x1B[44m",
      "back6": "\x1B[45m",
      "back7": "\x1B[46m",
      "back8": "\x1B[47m",
    };
    Platform.isAndroid ? AppHelper.printt("${colorsMap[color] ?? "\x1B[32m"} $text\x1B[0m") : AppHelper.printt(text);
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

  /// ================================================================= Check Internet Connection
  static Future<bool> isHasInternet(BuildContext context) async {
    bool isHasInternet = false;
    try {
      final result = await InternetAddress.lookup("google.com");
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        isHasInternet = true;
      }
    } on SocketException catch (e) {
      AppHelper.printt("$e");
      isHasInternet = false;
    }
    return isHasInternet;
  }
}
