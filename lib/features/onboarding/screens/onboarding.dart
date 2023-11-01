
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:sizer/sizer.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:topsale/core/utils/app_assets.dart';
import 'package:topsale/core/utils/app_colors.dart';
import 'package:topsale/core/widgets/custom_svg_images.dart';
import 'package:topsale/features/onboarding/cubit/onboarding_cubit.dart';

import 'package:topsale/features/onboarding/screens/onboarding1.dart';
import 'package:topsale/features/onboarding/screens/onboarding2.dart';

import '../../../core/widgets/bottom_copy_rights_widget.dart';
import '../../../core/widgets/copy_right_widget.dart';

class OnBoarding extends StatefulWidget {
  const OnBoarding({super.key});

  @override
  State<OnBoarding> createState() => _OnBoardingState();
}

class _OnBoardingState extends State<OnBoarding> {

  @override
  void initState() {
    checkLocationPermission();
    super.initState();
    context.read<OnBoardingCubit>().pageController.addListener(() {
      context.read<OnBoardingCubit>().changePages();
    });
  }
  // @override
  // void dispose() {
  //   context.read<OnBoardingCubit>().pageController.dispose();
  //   super.dispose();
  // }
  Future<void> checkLocationPermission() async {
    if (await Permission.location.request().isGranted) {
      // Location permission granted
    } else {
      // Location permission denied
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<OnBoardingCubit, OnBoardingState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        OnBoardingCubit cubit = context.read<OnBoardingCubit>();
        return Scaffold(
          backgroundColor: AppColors.primary,
          body: Stack(
           // mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Positioned(
                bottom: 100,
                right: 0,
                left: 0,
                top: 0,
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Stack(
                    children: [
                      PageView(
                        controller: cubit.pageController,

                        reverse: true,
                        onPageChanged: (int page) {
                        cubit.onPageChanged(page);
                        },
                        children: const [
                          OnBoarding1(),
                          OnBoarding2(),
                        ],
                      ),
                      Positioned(
                       top:MediaQuery.of(context).size.height*.64 ,
                          bottom: MediaQuery.of(context).size.height*.20,
                          right: 0,
                          left: 0,
                          child:Center(
                            child: SmoothPageIndicator(
                              controller: cubit.pageController,
                              count: cubit.numPages,
                              effect: const WormEffect(
                                activeDotColor: AppColors.lightBlue,
                                dotColor: AppColors.white,
                                dotHeight: 6,
                                dotWidth: 16,
                                type: WormType.underground,
                              ),
                            ),
                          ),
                      ),



                    ],
                  ),
                ),
              ),

              const Positioned(
                  bottom: 10,
                  left: 0,
                  right: 0,
                  child: Center(child: BottomCopyRightsWidget())),

            ],
          ),
        );
      },
    );
  }
}
