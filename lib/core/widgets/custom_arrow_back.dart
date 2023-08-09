import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../utils/app_colors.dart';

class CustomArrowBack extends StatelessWidget {
  const CustomArrowBack({super.key});

  @override
  Widget build(BuildContext context) {
    String? lang = EasyLocalization.of(context)!.locale.countryCode;
    return    Padding(
      padding: const EdgeInsets.only(left: 8.0),
      child: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Transform.rotate(
            angle: lang == "en" ? 0 : (3.14),
            child: const Icon(
              Icons.arrow_back_ios,
              color: AppColors.lightBlue,
            ),
          )),
    );
  }
}
