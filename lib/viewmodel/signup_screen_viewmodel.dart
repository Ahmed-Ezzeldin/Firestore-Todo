// ignore_for_file: use_build_context_synchronously

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_mvvm/model/models/user_model.dart';
import 'package:firebase_mvvm/model/services/app_helper.dart';
import 'package:firebase_mvvm/model/services/base/base_model.dart';
import 'package:firebase_mvvm/model/services/fireauth_service.dart';
import 'package:firebase_mvvm/model/services/provider_setup.dart';
import 'package:firebase_mvvm/view/screens/home_screen.dart';
import 'package:flutter/material.dart';

class SignupScreenViewmodel extends BaseModel {
  final BuildContext context;
  SignupScreenViewmodel({required this.context}) {
    emailController.text = "ahmed@test.com";
    passwordController.text = "123456789";
  }

  final formKey = GlobalKey<FormState>();
  var autovalidateMode = AutovalidateMode.disabled;
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  void submitFun() {
    if (formKey.currentState!.validate()) {
      AppHelper.unfocusFun(context);
      signUp();
    } else {
      autovalidateMode = AutovalidateMode.always;
      setState();
    }
  }

  void signUp() async {
    try {
      setBusy();
      UserCredential credential = await FireauthService.signUp(
        email: emailController.text,
        password: passwordController.text,
      );
      AppHelper.printt(credential);
      await auth.signUp(
        UserModel(
          uid: credential.user?.uid,
          displayName: credential.user?.displayName,
          email: credential.user?.email,
          phoneNumber: credential.user?.phoneNumber,
        ),
      );
      AppHelper.pushReplaceAll(context, const HomeScreen());
    } on FirebaseAuthException catch (error) {
      AppHelper.showSnackBarMessage(
        context,
        behavior: SnackBarBehavior.floating,
        radius: 5,
        textAlign: TextAlign.center,
        message: "${error.message}",
      );
      AppHelper.printt(error, isError: true);
    } catch (error) {
      AppHelper.printt(error);
    }
    setIdle();
  }
}
