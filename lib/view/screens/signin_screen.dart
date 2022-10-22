import 'package:firebase_mvvm/model/services/app_helper.dart';
import 'package:firebase_mvvm/model/services/base/base_model.dart';
import 'package:firebase_mvvm/model/services/base/base_widget.dart';
import 'package:firebase_mvvm/view/screens/home_screen.dart';
import 'package:firebase_mvvm/view/screens/signup_screen.dart';
import 'package:firebase_mvvm/view/styles/app_colors.dart';
import 'package:firebase_mvvm/view/widgets/components/main_button.dart';
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
                      validator: Validator.email,
                      hint: "Email",
                    ),
                    MainTextField(
                      controller: model.passwordController,
                      borderType: BorderType.underline,
                      prefixIcon: const Icon(Icons.password),
                      validator: Validator.password,
                      hint: "Password",
                    ),
                    SizedBox(height: mediaSize.height * 0.06),
                    MainButton(
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
  SigninScreenModel({required this.context});

  final formKey = GlobalKey<FormState>();
  var autovalidateMode = AutovalidateMode.disabled;
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  void submitFun() {
    if (formKey.currentState!.validate()) {
      AppHelper.unfocusFun(context);
      AppHelper.printt("Email: ${emailController.text} \nPassword: ${passwordController.text}");
      AppHelper.push(context, const HomeScreen());
    } else {
      autovalidateMode = AutovalidateMode.always;
      setState();
    }
  }
}
