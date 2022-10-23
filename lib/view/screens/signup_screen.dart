// ignore_for_file: use_build_context_synchronously

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_mvvm/model/models/user_model.dart';
import 'package:firebase_mvvm/model/services/app_helper.dart';
import 'package:firebase_mvvm/model/services/base/base_model.dart';
import 'package:firebase_mvvm/model/services/base/base_widget.dart';
import 'package:firebase_mvvm/model/services/firebase_auth_service.dart';
import 'package:firebase_mvvm/model/services/provider_setup.dart';
import 'package:firebase_mvvm/view/screens/home_screen.dart';
import 'package:firebase_mvvm/view/styles/app_colors.dart';
import 'package:firebase_mvvm/view/widgets/components/main_button.dart';
import 'package:firebase_mvvm/view/widgets/components/main_progress.dart';
import 'package:firebase_mvvm/view/widgets/components/main_textfield.dart';
import 'package:flutter/material.dart';

class SignupScreen extends StatelessWidget {
  const SignupScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Size mediaSize = MediaQuery.of(context).size;
    return BaseWidget<SignupScreenModel>(
      model: SignupScreenModel(context: context),
      builder: (_, model, child) {
        return Scaffold(
          appBar: AppBar(title: const Text("Sign up")),
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
                      Icons.task_alt,
                      size: 150,
                      color: AppColors.primaryColor,
                    ),
                    SizedBox(height: mediaSize.height * 0.05),
                    MainTextField(
                      controller: model.nameController,
                      borderType: BorderType.underline,
                      keyboardType: TextInputType.name,
                      prefixIcon: const Icon(Icons.person_outline),
                      validator: Validator.username,
                      hint: "Name",
                    ),
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
                            title: "Sign up",
                            onPressed: model.submitFun,
                          ),
                    SizedBox(height: mediaSize.height * 0.03),
                    Wrap(
                      crossAxisAlignment: WrapCrossAlignment.center,
                      children: [
                        const Text("Already have an account"),
                        MainButton(
                          type: ButtonType.text,
                          title: "Sign in",
                          textStyle: const TextStyle(fontSize: 14),
                          onPressed: () {
                            Navigator.of(context).pop();
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

class SignupScreenModel extends BaseModel {
  final BuildContext context;
  SignupScreenModel({required this.context}) {
    emailController.text = "ahmed@test.com";
    passwordController.text = "123456789";
  }

  final formKey = GlobalKey<FormState>();
  var autovalidateMode = AutovalidateMode.disabled;
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

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
      UserCredential credential = await FirebaseAuthService().signUp(
        email: emailController.text,
        password: passwordController.text,
      );
      AppHelper.printColor(credential);
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
