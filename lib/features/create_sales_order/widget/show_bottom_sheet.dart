import 'package:flutter/material.dart';
import 'package:topsale/core/utils/app_colors.dart';

void showMyBottomSheet(Widget widget, BuildContext context) {
  showModalBottomSheet(
      context: context,
      builder: (context) => widget,
      isDismissible: false,
      isScrollControlled: true,
      backgroundColor: AppColors.primary,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(20))));
}
