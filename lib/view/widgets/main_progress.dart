import 'dart:io';

import 'package:firebase_mvvm/view/styles/app_colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MainProgress extends StatelessWidget {
  final Color color;
  final double diameter;
  final double stroke;
  final double height;
  final double? linearWidth;

  const MainProgress({
    Key? key,
    this.color = AppColors.primaryColor,
    this.stroke = 4,
    this.diameter = 35,
    this.height = 4,
    this.linearWidth,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        height: diameter,
        width: diameter,
        child: Platform.isAndroid
            ? CircularProgressIndicator.adaptive(
                valueColor: AlwaysStoppedAnimation<Color>(color),
                strokeWidth: stroke,
              )
            : CupertinoActivityIndicator(
                radius: diameter * 0.5,
              ),
      ),
    );
  }
}
