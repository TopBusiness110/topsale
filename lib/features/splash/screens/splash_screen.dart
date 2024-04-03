import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:sizer/sizer.dart';
import 'package:topsale/config/routes/app_routes.dart';
import 'package:topsale/core/preferences/preferences.dart';
import 'package:topsale/core/utils/app_assets.dart';
import 'package:topsale/core/utils/app_colors.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Spacer(),
          Center(
            child: Image.asset(AssetsManager.splash),
          ),
          const Spacer(),
          SizedBox(
            height: 5.h,
            child: Image.asset(
              AssetsManager.whiteCopyRights,
            ),
          ),

          //  SvgPicture.asset(ImageAssets.copyRightsIcon),
          SizedBox(
            height: 3.h,
          )
        ],
      ),
    );
  }

  void initialization() async {
    // This is where you can initialize the resources needed by your app while
    // the splash screen is displayed.  Remove the following example because
    // delaying the user experience is a bad design practice!
    // ignore_for_file: avoid_print
    print('ready in 3...');
    await Future.delayed(const Duration(seconds: 1));
    print('ready in 2...');
    await Future.delayed(const Duration(seconds: 1));
    print('ready in 1...');
    await Future.delayed(const Duration(seconds: 1));
    print('go!');
    FlutterNativeSplash.remove();

     Preferences.instance.getIsFirstTime(key: 'onBoarding').then((value) {
       if (value != null && value == true) {
         Preferences.instance.getUserToken().then((value) {
           if (value != null) {
               Navigator.pushNamedAndRemoveUntil(
                   context, Routes.homeRoute, (route) => false);
              // context.read<HomeCubit>().getUser();
           } else {
             Navigator.pushNamedAndRemoveUntil(
                 context, Routes.loginRoute, (route) => false);
           }
         });
         print('not first time');
       } else {
         Navigator.pushReplacementNamed(context, Routes.onBoardingRoute);
         print('first time');
       }
     }).catchError((error) {
       print(error.toString());
     });

    //   Navigator.pushReplacementNamed(context, Routes.onBoardingRoute);
  }

  @override
  void initState() {
    super.initState();
    initialization();
  }
}
