import 'package:flutter/material.dart';

import '../utils/app_assets.dart';
import '../utils/app_colors.dart';

class BottomCopyRightsWidget extends StatelessWidget {
  const BottomCopyRightsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return    SizedBox(
        width: 100,
        //height: 50,
        child: Image.asset(AssetsManager.whiteCopyRights,color: AppColors.white,));
  }
}
