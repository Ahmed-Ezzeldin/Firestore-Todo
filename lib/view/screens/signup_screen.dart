import 'package:firebase_mvvm/view/styles/app_colors.dart';
import 'package:firebase_mvvm/view/widgets/main_textfield.dart';
import 'package:firebase_mvvm/view/widgets/main_button.dart';
import 'package:firebase_mvvm/view/widgets/main_progress.dart';
import 'package:firebase_mvvm/viewmodel/signup_screen_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SignupScreen extends StatelessWidget {
  const SignupScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<SignupScreenViewmodel>(context);

    final Size mediaSize = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(title: const Text("Sign up")),
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
                  Icons.task_alt,
                  size: 150,
                  color: AppColors.primaryColor,
                ),
                SizedBox(height: mediaSize.height * 0.05),
                MainTextField(
                  controller: viewModel.nameController,
                  borderType: BorderType.underline,
                  keyboardType: TextInputType.name,
                  prefixIcon: const Icon(Icons.person_outline),
                  validator: Validator.username,
                  hint: "Name",
                ),
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
                MainTextField(
                  controller: viewModel.confirmPasswordController,
                  borderType: BorderType.underline,
                  prefixIcon: const Icon(Icons.password),
                  keyboardType: TextInputType.visiblePassword,
                  validator: Validator.isMatch,
                  matchedValue: viewModel.passwordController.text,
                  hint: "Confirm Password",
                ),
                SizedBox(height: mediaSize.height * 0.06),
                viewModel.isBusy
                    ? const MainProgress()
                    : MainButton(
                        radius: 5,
                        width: double.infinity,
                        title: "Sign up",
                        onPressed: () {
                          viewModel.submitFun(context);
                        },
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
  }
}
