import 'package:firebase_mvvm/model/services/base/base_widget.dart';
import 'package:firebase_mvvm/view/styles/app_colors.dart';
import 'package:firebase_mvvm/viewmodel/splash_screen_viewmodel.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BaseWidget<SplashScreenViewmodel>(
      model: SplashScreenViewmodel(context: context),
      builder: (_, model, child) {
        return Scaffold(
          backgroundColor: AppColors.primaryColor,
          body: Container(
            width: double.infinity,
            padding: const EdgeInsets.all(10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Icon(
                  Icons.task_alt,
                  size: 150,
                  color: Colors.white,
                ),
                SizedBox(height: 20),
                Text(
                  "Firebase ToDo",
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
