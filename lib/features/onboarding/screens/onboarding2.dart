import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:topsale/core/preferences/preferences.dart';

import '../../../config/routes/app_routes.dart';
import '../../../core/utils/app_assets.dart';
import '../../../core/utils/app_colors.dart';
import '../../../core/widgets/custom_button.dart';

class OnBoarding2 extends StatelessWidget {
  const OnBoarding2({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primary,
      body: Stack(
        children: [
          // SizedBox(height: 27.h),
          //  const Spacer(),
          Positioned(
            top: MediaQuery.of(context).size.height * .3,
            left: 0,
            right: 0,
            //bottom:  MediaQuery.of(context).size.height*.1,

            child: SizedBox(
              height: MediaQuery.of(context).size.height * .20,
              width: 70.w,
              child: Center(
                child: SizedBox(
                  height: 20.h,
                  width: 70.w,
                  child: Image.asset(AssetsManager.onBoarding2),
                ),
              ),
            ),
          ),
          // SizedBox(height: 2.h,),
          Positioned(
            top: MediaQuery.of(context).size.height * .51,
            left: 0,
            right: 0,
            child: Center(
              child: Text(
                "clients_transactions",
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.displayLarge,
              ).tr(),
            ),
          ),
          // SizedBox(height: 2.h),
          Positioned(
            top: MediaQuery.of(context).size.height * .54,
            left: 0,
            right: 0,
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "add_customers_transactions",
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.displayMedium,
                ).tr(),
              ),
            ),
          ),
          // SizedBox(height: 4.h,),
          //  SizedBox(height: 20.h,),
          // SizedBox(height: 20.h,),
          Positioned(
            top: MediaQuery.of(context).size.height * .64,
            bottom: 0,
            left: 0,
            right: 0,
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 28.0),
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: CustomButton(
                      width: 25.w,
                      height: 5.h,
                      backgroundColor: AppColors.lightBlue,
                      onPressed: () {
                        Preferences.instance
                            .setIsFirstTime(key: 'onBoarding', value: true)
                            .then((value) {
                          print('first timee');
                          Navigator.pushReplacementNamed(
                              context, Routes.loginRoute);
                        }).catchError((error) {
                          print('error${error.toString()}');
                        });
                      },
                      
                      text: "finish",
                      textColor: AppColors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),

          //  SizedBox(
          //    height: 4.h,
          //  ),
          // SizedBox(height: 15.h,),

          //  const Spacer()

          // SizedBox(height: 7.h,),
          // CopyRightsWidget()
        ],
      ),
    );
  }
}
