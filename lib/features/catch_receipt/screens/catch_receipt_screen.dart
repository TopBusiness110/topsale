import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:topsale/core/utils/app_colors.dart';

import '../../../core/utils/app_assets.dart';
import '../../../core/widgets/custom_button.dart';

class CatchReceiptScreen extends StatelessWidget {
  const CatchReceiptScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primary,
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: 15.h,),
            Center(
              child: Container(
                margin: EdgeInsets.only(top: 20),
                height: 75.h,
                width: 95.w,
                decoration: const BoxDecoration(
                    borderRadius: BorderRadius.only(topRight:Radius.circular(16) ,topLeft: Radius.circular(16)),
                    color: AppColors.white
                ),
                child: Column(
                  children: [
                    Image.asset(
                      ImageAssets.splash,
                      width: 30.w,
                      height: 16.h,
                    ),
                    Text(
                      "catch_receipt".tr(),
                      style: Theme.of(context)
                          .textTheme
                          .displayLarge!
                          .copyWith(color: AppColors.primary),
                    ),
                    SizedBox(height: 3.h,),
                    Text(
                      "تاريخ الدفع: 2023-05-22  06:35:58",
                      style: Theme.of(context)
                          .textTheme
                          .displayLarge!
                          .copyWith(color: AppColors.primary),
                    ),
                    SizedBox(height: 1.h,),
                    Text(
                      "رقم السند: 322",
                      style: Theme.of(context)
                          .textTheme
                          .displayLarge!
                          .copyWith(color: AppColors.primary),
                    ),
                    SizedBox(height: 1.h,),
                    Text(
                      "بواسطة: TopBusiness",
                      style: Theme.of(context)
                          .textTheme
                          .bodyMedium!
                          .copyWith(color: AppColors.primary),
                    ),
                    SizedBox(height: 1.h,),
                    Text(
                      "اسم العميل: khaled elsheikh",
                      style: Theme.of(context)
                          .textTheme
                          .bodyMedium!
                          .copyWith(color: AppColors.primary),
                    ),
                    Padding(
                      padding:  EdgeInsets.symmetric(horizontal: 6.w),
                      child: Divider(),
                    ),

                    Text(
                      "اجمالي المدفوع: 500.00 USD",
                      style: Theme.of(context)
                          .textTheme
                          .displayLarge!
                          .copyWith(color: AppColors.primary),
                    ),
                    Padding(
                      padding:  EdgeInsets.symmetric(horizontal: 6.w),
                      child: Divider(),
                    ),



                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Text(
                        "www.topbusiness.io",
                        style: Theme.of(context)
                            .textTheme
                            .bodySmall!
                            .copyWith(color: AppColors.primary),
                      ),
                    ),
                  SizedBox(height: 13.h,),
                    SizedBox(
                      height: 7.h,
                      child: Image.asset(
                        "assets/icon/copy_rights_blue.png",
                        color: Colors.black,
                      ),
                    ),
                    CustomButton(
                        backgroundColor: AppColors.yellow,
                        textColor: AppColors.white,
                        text: "print".tr(),
                        onPressed: () {
                          //  Navigator.pushReplacementNamed(context, Routes.receiptRoute);
                        }),

                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
