// ignore_for_file: avoid_print

import 'package:flutter_test/flutter_test.dart';

void main() {
  // String divid(int x, int y) {
  //   print("Result: ${(x / y)}");
  //   return "${(x / y)}";
  // }

  String divid(int x, int y) {
    if (x == 0 && y != 0) {
      return "Invalid";
    } else if (x == 0 && y == 0) {
      return "NotAllowed";
    } else if (x != 0 && y == 0) {
      return "NotAllowed";
    }
    print("Result: ${(x / y)}");
    return "${(x / y)}";
  }

  void dividTest(int x, int y, String result) {
    print("Is can divid $x by $y , the result equal to $result");
    if (divid(x, y) == result) {
      print("✅ Succeed!");
    } else {
      print("❌ Faild!");
    }
    print("=====================================================");
  }

  dividTest(24, 2, "12.0");
  dividTest(0, 1, "Invalid");
  dividTest(10, 0, "NotAllowed");
  dividTest(0, 0, "NotAllowed");

  group("Calculation", () {
    test("Divid of two numbers", () {
      String result = "";
      result = divid(24, 2);
      expect(result, "12.0");
      result = divid(0, 1);
      expect(result, "Invalid");
      result = divid(10, 0);
      expect(result, "NotAllowed");
      result = divid(0, 0);
      expect(result, "NotAllowed");
    });
  });
}
