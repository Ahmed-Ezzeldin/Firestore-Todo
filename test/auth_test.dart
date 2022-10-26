// ignore_for_file: avoid_print, unused_element

import 'package:flutter_test/flutter_test.dart';

void main() {
  String signInTest(String email, String password) {
    String userEmail = "user@test.com";
    String userPassword = "123456789";
    String value = "";
    if (email.isEmpty && password.isEmpty) {
      value = "Please enter email and password";
    } else if (email.isEmpty) {
      value = "Email should not be empty!";
    } else if (password.isEmpty) {
      value = "Password should not be empty!";
    } else if (!email.contains("@")) {
      value = "Please enter valid email";
    } else if (password.length < 8) {
      value = "Please enter valid password";
    } else if (email != userEmail) {
      value = "User not found!";
    } else if (password != userPassword) {
      value = "Wrong password";
    } else if (email == userEmail && password == userPassword) {
      value = "Signin Succeed";
    } else {
      value = "Signin Faild";
    }
    return value;
  }
  String signUpTest(String email, String password) {
    String userEmail = "user@test.com";
    String userPassword = "123456789";
    String value = "";
    if (email.isEmpty && password.isEmpty) {
      value = "Please enter email and password";
    } else if (email.isEmpty) {
      value = "Email should not be empty!";
    } else if (password.isEmpty) {
      value = "Password should not be empty!";
    } else if (!email.contains("@")) {
      value = "Please enter valid email";
    } else if (password.length < 8) {
      value = "Please enter valid password";
    } else if (email == userEmail) {
      value = "User already exists";
    } else if (password != userPassword) {
      value = "Password not match";
    } else if (email != userEmail) {
      value = "Signup Succeed";
    } else {
      value = "Signup Faild";
    }
    return value;
  }

  group("Authentication", () { 
    test("Sign In", () {
      String result = "";
      result = signInTest("", "123123123");
      expect(result, "Email should not be empty!");
      result = signInTest("user@test.com", "");
      expect(result, "Password should not be empty!");
      result = signInTest("", "");
      expect(result, "Please enter email and password");
      result = signInTest("test.fdf.com", "123456789");
      expect(result, "Please enter valid email");
      result = signInTest("user@test.com", "12345");
      expect(result, "Please enter valid password");
      result = signInTest("ahmed@test.com", "123456789");
      expect(result, "User not found!");
      result = signInTest("user@test.com", "1234567890");
      expect(result, "Wrong password");
      result = signInTest("user@test.com", "123456789");
      expect(result, "Signin Succeed");
    });
    test("Sign Up", () {
      String result = "";
      result = signUpTest("", "123123123");
      expect(result, "Email should not be empty!");
      result = signUpTest("user@test.com", "");
      expect(result, "Password should not be empty!");
      result = signUpTest("", "");
      expect(result, "Please enter email and password");
      result = signUpTest("test.fdf.com", "123456789");
      expect(result, "Please enter valid email");
      result = signUpTest("user@test.com", "12345");
      expect(result, "Please enter valid password");
      result = signUpTest("user@test.com", "123456789");
      expect(result, "User already exists");
      result = signUpTest("user2@test.com", "1234567890");
      expect(result, "Password not match");
      result = signUpTest("user2@test.com", "123456789");
      expect(result, "Signup Succeed");
    });
  });
}
