import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import 'package:sizer/sizer.dart';
import 'package:topsale/config/routes/app_routes.dart';
import 'package:topsale/core/utils/app_assets.dart';
import 'package:topsale/core/utils/app_colors.dart';
import 'package:topsale/core/widgets/custom_button.dart';
import 'package:topsale/core/widgets/custom_container.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../core/widgets/bottom_copy_rights_widget.dart';
import '../../../core/widgets/copy_right_widget.dart';
import '../../../core/widgets/custom_textfield.dart';

class LoginScreen extends StatelessWidget{
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primary,
      resizeToAvoidBottomInset: false,
      body: Center(
        child: Stack(
          children: [
            SingleChildScrollView(
              child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(height: 5.h,),
                //  Spacer(),
               Image.asset(AssetsManager.splash,color: AppColors.white,width: 45.w,height: 25.h,),
                CustomContainer(
                  width: 90.w,
                  height: 30.h,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text("login",style: Theme.of(context).textTheme.displayLarge,).tr(),
                     CustomTextField(
                       title: 'user_name'.tr(),
                       textColor: AppColors.white.withOpacity(0.3),
                      textInputType: TextInputType.name,
                      backgroundColor: AppColors.primary,
                      minLine: 1,
                      isPassword: false,
                      ),

                     CustomTextField(title: 'password'.tr(),
                       textColor: AppColors.white.withOpacity(0.3),
                      textInputType: TextInputType.text,
                      backgroundColor: AppColors.primary,
                      minLine: 1,
                      isPassword: false,
                    ),
                    CustomButton(backgroundColor: AppColors.yellow, textColor: AppColors.white,
                      text: "registration".tr(), onPressed: () {
                        Navigator.pushNamed(context, Routes.homeRoute);
                      },
                    fontSize: 14,)
                  ],
                )),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: TextButton(
                      child: Text('recover_password',
                      style: Theme.of(context).textTheme.bodyMedium).tr(),
                      onPressed: (){
                        Navigator.pushNamed(context, Routes.forgotPassword1Route);
                      },
                    ),),
                  ),
                  CustomContainer(
                    width: 90.w,
                    height: 15.h,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text("no_account",style: Theme.of(context).textTheme.displayLarge,).tr(),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            CustomButton(
                              width: 30.w,
                              height: 4.h,
                              backgroundColor: AppColors.primary, onPressed: () {
                              Navigator.pushNamed(context, Routes.signUpRoute);
                            }, text: "new_register".tr(), textColor: AppColors.yellow,),
                            SizedBox(width: 15.w,),
                            CustomButton(
                              width: 30.w,
                              height: 4.h,
                              backgroundColor: AppColors.primary,
                              onPressed: () {
                                Navigator.pushNamed(context, Routes.homeRoute);
                            }, text: "try".tr(), textColor: AppColors.yellow,),
                          ],),
                      ],
                    ),
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(padding: EdgeInsets.symmetric(horizontal: 10),
                      child: TextButton(
                        child: Text('contact_us',
                          style: Theme.of(context).textTheme.bodyMedium,).tr(),
                        onPressed: () async {
                          whatsapp();

                        },
                      ),),
                  ),
                SizedBox(height: 5.h,),
                  BottomCopyRightsWidget()

                // Spacer(),

                ],
              ),
            ),
            // BottomCopyRightsWidget()
          ],
        ),
      ),
    );
  }
  whatsapp() async{
    var contact = "+201011827324";
    var androidUrl = "whatsapp://send?phone=$contact&text=Hi, I need some help about top sale application";
    var iosUrl = "https://wa.me/$contact?text=${Uri.parse('Hi, I need some help about top sale application')}";

    try{
      if(Platform.isIOS){
        await launchUrl(Uri.parse(iosUrl));
      }
      else{

        await launchUrl(Uri.parse(androidUrl));
      }
    } on Exception{
     // EasyLoading.showError('WhatsApp is not installed.');
    }
  }
}
