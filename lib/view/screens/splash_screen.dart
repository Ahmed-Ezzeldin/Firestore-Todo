import 'package:firebase_mvvm/model/services/app_helper.dart';
import 'package:firebase_mvvm/model/services/base/base_model.dart';
import 'package:firebase_mvvm/model/services/base/base_widget.dart';
import 'package:firebase_mvvm/view/screens/home_screen.dart';
import 'package:firebase_mvvm/view/screens/signin_screen.dart';
import 'package:firebase_mvvm/view/styles/app_colors.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BaseWidget<SplashScreenModel>(
      model: SplashScreenModel(context: context),
      builder: (_, model, child) {
        return Scaffold(
          // appBar: AppBar(title: const Text("Splash Screen")),
          backgroundColor: AppColors.primaryColor,
          body: Container(
            width: double.infinity,
            padding: const EdgeInsets.all(10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Icon(
                  Icons.flutter_dash,
                  size: 150,
                  color: Colors.white,
                ),
                SizedBox(height: 20),
                Text(
                  "Firebas ToDo",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 30,
                    color: Colors.white,
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}

class SplashScreenModel extends BaseModel {
  final BuildContext context;
  SplashScreenModel({required this.context}) {
    delayFun();
  }

  void delayFun() {
    Future.delayed(const Duration(milliseconds: 2000), () {
      // AppHelper.pushReplaceAll(context, const HomeScreen());
      AppHelper.pushReplaceAll(context, const SigninScreen());
    });
  }
}
