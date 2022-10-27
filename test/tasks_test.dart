// ignore_for_file: avoid_print, unused_element

import 'package:flutter_test/flutter_test.dart';



void main() {
  String getTasksList(String temp) {
    String value = "";
    if (value == temp) {
      value = "Please enter email and password";
    } else {
      value = "Signin Faild";
    }
    return value;
  }

  group("Tasks api", () {
    test("Get Tasks", () {
      String result = "";
      result = getTasksList("");
      expect(result, "Email should not be empty!");
    });
  });
}
