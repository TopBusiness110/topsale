import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:sizer/sizer.dart';
import 'package:topsale/config/routes/app_routes.dart';
import 'package:topsale/core/api/end_points.dart';
import 'package:topsale/core/preferences/preferences.dart';
import 'package:topsale/core/utils/app_assets.dart';
import 'package:topsale/core/utils/app_colors.dart';
import 'package:topsale/features/login/cubit/login_cubit.dart';

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
    String database = await Preferences.instance.getDataBaseName() ??
        "demo17.topbuziness.com";
          String odooUrl = await Preferences.instance.getOdooUrl() ??
        "https://demo17.topbuziness.com";
  
    
    EndPoints.db = database;
      EndPoints.baseUrl = odooUrl;
    print(EndPoints.baseUrl);
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
        Preferences.instance.getUserName().then((value) async {
          if (value != null) {
            String phoneOrMail = value;
            String password = await Preferences.instance.getUserPass() ?? '';
            String db = await Preferences.instance.getDataBaseName() ?? '';
            String url = await Preferences.instance.getOdooUrl() ?? '';

            context.read<LoginCubit>().login(context,
                phoneOrMail: phoneOrMail, password: password, db: db);
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
