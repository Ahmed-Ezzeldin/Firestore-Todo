import 'package:firebase_mvvm/model/services/base/base_widget.dart';
import 'package:firebase_mvvm/view/styles/app_colors.dart';
import 'package:firebase_mvvm/view/widgets/main_textfield.dart';
import 'package:firebase_mvvm/view/widgets/main_button.dart';
import 'package:firebase_mvvm/view/widgets/main_progress.dart';
import 'package:firebase_mvvm/viewmodel/signup_screen_viewmodel.dart';
import 'package:flutter/material.dart';

class SignupScreen extends StatelessWidget {
  const SignupScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Size mediaSize = MediaQuery.of(context).size;
    return BaseWidget<SignupScreenViewmodel>(
      model: SignupScreenViewmodel(context: context),
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
