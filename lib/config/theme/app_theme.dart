import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../core/utils/app_colors.dart';
import '../../core/utils/app_strings.dart';

ThemeData appTheme() {

  return ThemeData(
    primaryColor: AppColors.primary,
    hintColor: AppColors.white,

    brightness: Brightness.light,
    // scaffoldBackgroundColor: AppColors.scaffoldBackground,
    fontFamily: AppStrings.fontFamily,
    textTheme:  TextTheme(
      displayLarge:  TextStyle(
          fontSize: 19.sp,
          fontWeight: FontWeight.w600,
          color: AppColors.white
      ),
      displayMedium: TextStyle(
        height: 1.5,
        fontSize: 18.0,
        // fontWeight: FontWeight.bold,
      ),
      bodyMedium:TextStyle(
        height: 1.5,
        fontSize: 18.0,
        // fontWeight: FontWeight.bold,
      ),
    ),
    appBarTheme: const AppBarTheme(
      centerTitle: true,
      elevation: 0.0,
      backgroundColor: AppColors.transparent,
      titleTextStyle: TextStyle(
        fontSize: 22.0,
        letterSpacing: 1.5,
        fontWeight: FontWeight.w500,
      ),
    ),
  );
}