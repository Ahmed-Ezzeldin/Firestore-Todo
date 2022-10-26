import 'package:firebase_mvvm/model/services/app_helper.dart';
import 'package:firebase_mvvm/view/screens/signup_screen.dart';
import 'package:firebase_mvvm/view/styles/app_colors.dart';
import 'package:firebase_mvvm/view/widgets/main_textfield.dart';
import 'package:firebase_mvvm/view/widgets/main_button.dart';
import 'package:firebase_mvvm/view/widgets/main_progress.dart';
import 'package:firebase_mvvm/viewmodel/signin_screen_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SigninScreen extends StatelessWidget {
  const SigninScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<SigninScreenViewmodel>(context);
    final Size mediaSize = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(title: const Text("Sign in")),
      body: SingleChildScrollView(
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.all(10),
          child: Form(
            key: viewModel.formKey,
            autovalidateMode: viewModel.autovalidateMode,
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
                  controller: viewModel.emailController,
                  borderType: BorderType.underline,
                  prefixIcon: const Icon(Icons.alternate_email),
                  keyboardType: TextInputType.emailAddress,
                  validator: Validator.email,
                  hint: "Email",
                ),
                MainTextField(
                  controller: viewModel.passwordController,
                  borderType: BorderType.underline,
                  prefixIcon: const Icon(Icons.password),
                  keyboardType: TextInputType.visiblePassword,
                  validator: Validator.password,
                  hint: "Password",
                ),
                SizedBox(height: mediaSize.height * 0.06),
                viewModel.isBusy
                    ? const MainProgress()
                    : MainButton(
                        radius: 5,
                        width: double.infinity,
                        title: "Sign in",
                        onPressed: () {
                          viewModel.submitFun(context);
                        },
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
  }
}
