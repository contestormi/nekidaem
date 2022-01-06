import 'package:flutter/material.dart';

abstract class AppColors {
  static const lightBlack = Color(0xFF232221);
  static const darkBlack = Color(0xFF010001);
  static const aquamarine = Color(0xFF63FFD7);
  static const white = Color(0xFFFFFFFF);
  static const grey = Color(0xFF3D393B);
  static const lightGrey = Color(0xFF424140);
}

abstract class TextStyles {
  static const fadedText = TextStyle(overflow: TextOverflow.fade);
  static const whiteText = TextStyle(color: AppColors.white);
  static const greyText = TextStyle(color: AppColors.grey);
}
