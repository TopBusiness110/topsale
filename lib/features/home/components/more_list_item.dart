import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../core/utils/app_assets.dart';
import '../../../core/utils/app_colors.dart';

class MoreListItem extends StatelessWidget {
  final String imagePath;
  final String text;
  const MoreListItem({super.key,required this.imagePath,required this.text});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 65.w,
      height: 11.h,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 5),
        margin: EdgeInsets.symmetric(horizontal: 10.w,vertical: 10),
        decoration: BoxDecoration(
            color: AppColors.blue2,
            borderRadius: BorderRadius.circular(10)
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset(imagePath,width: 40,),
            SizedBox(width: 20,),
            Text(text,style: Theme.of(context).textTheme.displayMedium,)
          ],
        ),
      ),
    );
  }
}
List<String> moreImages = [AssetsManager.myAccount,AssetsManager.termsConditionsDelete,AssetsManager.reports,AssetsManager.termsConditionsDelete,AssetsManager.logout];
List<String> labels = ["my_account".tr(),"terms_conditions".tr(),"reports".tr(),"delete_account".tr(),"logout".tr()];
