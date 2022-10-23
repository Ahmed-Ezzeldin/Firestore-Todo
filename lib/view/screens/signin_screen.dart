// ignore_for_file: use_build_context_synchronously

import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_mvvm/model/models/user_model.dart';
import 'package:firebase_mvvm/model/services/app_helper.dart';
import 'package:firebase_mvvm/model/services/auth_service.dart';
import 'package:firebase_mvvm/model/services/base/base_model.dart';
import 'package:firebase_mvvm/model/services/base/base_widget.dart';
import 'package:firebase_mvvm/model/services/firebase_auth_service.dart';
import 'package:firebase_mvvm/model/services/provider_setup.dart';
import 'package:firebase_mvvm/view/screens/home_screen.dart';
import 'package:firebase_mvvm/view/screens/signup_screen.dart';
import 'package:firebase_mvvm/view/styles/app_colors.dart';
import 'package:firebase_mvvm/view/widgets/components/main_button.dart';
import 'package:firebase_mvvm/view/widgets/components/main_progress.dart';
import 'package:firebase_mvvm/view/widgets/components/main_textfield.dart';
import 'package:flutter/material.dart';

class SigninScreen extends StatelessWidget {
  const SigninScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Size mediaSize = MediaQuery.of(context).size;
    return BaseWidget<SigninScreenModel>(
      model: SigninScreenModel(context: context),
      builder: (_, model, child) {
        return Scaffold(
          appBar: AppBar(title: const Text("Sign in")),
          body: SingleChildScrollView(
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.all(10),
              child: Form(
                key: model.formKey,
                autovalidateMode: model.autovalidateMode,
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    SizedBox(height: mediaSize.height * 0.1),
                    const Icon(
                      // Icons.task_alt,
                      Icons.task_alt,
                      size: 150,
                      color: AppColors.primaryColor,
                    ),
                    SizedBox(height: mediaSize.height * 0.05),
                    MainTextField(
                      controller: model.emailController,
                      borderType: BorderType.underline,
                      prefixIcon: const Icon(Icons.alternate_email),
                      keyboardType: TextInputType.emailAddress,
                      validator: Validator.email,
                      hint: "Email",
                    ),
                    MainTextField(
                      controller: model.passwordController,
                      borderType: BorderType.underline,
                      prefixIcon: const Icon(Icons.password),
                      keyboardType: TextInputType.visiblePassword,
                      validator: Validator.password,
                      hint: "Password",
                    ),
                    SizedBox(height: mediaSize.height * 0.06),
                    model.busy
                        ? const MainProgress()
                        : MainButton(
                            radius: 5,
                            width: double.infinity,
                            title: "Sign in",
                            onPressed: model.submitFun,
                          ),
                    SizedBox(height: mediaSize.height * 0.03),
                    Wrap(
                      crossAxisAlignment: WrapCrossAlignment.center,
                      children: [
                        const Text("Don't have an account"),
                        MainButton(
                          type: ButtonType.text,
                          title: "Sign up",
                          textStyle: const TextStyle(fontSize: 14),
                          onPressed: () {
                            AppHelper.push(context, const SignupScreen());
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

class SigninScreenModel extends BaseModel {
  final BuildContext context;
  SigninScreenModel({required this.context}) {
    emailController.text = "ahmed@test.com";
    passwordController.text = "123456789";
  }

  final formKey = GlobalKey<FormState>();
  var autovalidateMode = AutovalidateMode.disabled;
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  void submitFun() {
    if (formKey.currentState!.validate()) {
      AppHelper.unfocusFun(context);
      signIn();
    } else {
      autovalidateMode = AutovalidateMode.always;
      setState();
    }
  }

  void signIn() async {
    try {
      setBusy();
      UserCredential credential = await FirebaseAuthService().signIn(
        email: emailController.text,
        password: passwordController.text,
      );
      AppHelper.printColor(credential);
      await auth.signIn(
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
