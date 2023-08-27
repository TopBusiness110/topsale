import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sizer/sizer.dart';
import 'package:topsale/config/routes/app_routes.dart';
import 'package:topsale/core/utils/app_assets.dart';
import 'package:topsale/core/utils/app_colors.dart';
import 'package:topsale/features/onboarding/cubit/onboarding_cubit.dart';
import 'package:topsale/features/onboarding/cubit/onboarding_cubit.dart';

import '../../../config/theme/app_theme.dart';
import '../../../core/widgets/copy_right_widget.dart';
import '../../../core/widgets/custom_button.dart';
import '../../../core/widgets/custom_svg_images.dart';

class OnBoarding1 extends StatelessWidget {
  const OnBoarding1({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OnBoardingCubit, OnBoardingState>(

      builder: (context, state) {
        OnBoardingCubit cubit = context.read<OnBoardingCubit>();
        return Scaffold(
          backgroundColor: AppColors.primary,

          body: Stack(

            children: [

             // Spacer(),
              Positioned(

                top: MediaQuery.of(context).size.height*.3,
                left: 0,
                right: 0,
                //bottom:  MediaQuery.of(context).size.height*.1,

                child: SizedBox(
                  height: MediaQuery.of(context).size.height*.20,
                  width: 70.w,
                  child: Center(
                    child: Stack(children: [
                      Image.asset(AssetsManager.onboardingImageBg,height: 20.h,),
                      Image.asset(AssetsManager.onBoarding1,height: 20.h,),
                    ],),
                  ),
                ),
              ),
             // SizedBox(height: 2.h,),
              Positioned(
                top: MediaQuery.of(context).size.height*.51,
                left: 0,
                right: 0,

                child: Center(
                  child: Text("sales_representatives_shipments",
                  style:
                  Theme.of(context).textTheme.displayLarge).tr(),
                ),
              ),
              // SizedBox(height: 2.h),
              Positioned(top: MediaQuery.of(context).size.height*.54,
                left: 0,
                right: 0,

                child: Center(child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text("follow_sales_shipments", style:Theme.of(context).textTheme.displayMedium,).tr(),
                )),
              ),
              // SizedBox(height: 4.h,),
              //  SizedBox(height: 20.h,),
              // SizedBox(height: 20.h,),
              Positioned(
                top:  MediaQuery.of(context).size.height*.64,
                bottom: 0,
                left: 0,
                right: 0,

                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CustomButton(
                      width: 25.w,
                      height: 5.h,
                      backgroundColor: AppColors.lightBlue, onPressed: () {

                       cubit.pageController.animateToPage(2, duration: Duration(microseconds: 10), curve: Curves.bounceInOut);
                    }, text: "next", textColor: AppColors.white,),
                    SizedBox(width: 15.w,),
                    CustomButton(
                      width: 25.w,
                      height: 5.h,
                      backgroundColor: AppColors.blue2, onPressed: () {
                      Navigator.pushReplacementNamed(context, Routes.loginRoute);
                    }, text: "skip", textColor: AppColors.yellow,),
                  ],),
              ),

             // SizedBox(height: 7.h,),
             //  CopyRightsWidget()


            ],
          ),
        );
      },
    );
  }
}
