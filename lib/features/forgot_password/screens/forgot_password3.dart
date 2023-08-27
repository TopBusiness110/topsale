import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';
import 'package:topsale/features/forgot_password/cubit/forgot_password_cubit.dart';

import '../../../config/routes/app_routes.dart';
import '../../../core/utils/app_assets.dart';
import '../../../core/utils/app_colors.dart';
import '../../../core/widgets/bottom_copy_rights_widget.dart';
import '../../../core/widgets/copy_right_widget.dart';

import '../../../core/widgets/custom_button.dart';
import '../../../core/widgets/custom_container.dart';
import '../../../core/widgets/custom_textfield.dart';

class ForgotPasswordStep3 extends StatelessWidget {
  const ForgotPasswordStep3({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ForgotPasswordCubit, ForgotPasswordState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        return Scaffold(
          resizeToAvoidBottomInset: false,
          backgroundColor: AppColors.primary,
          body: Stack(
            children: [

              SingleChildScrollView(
                child: Column(
                  children: [
                    Align(
                      alignment: Alignment.topLeft,
                      child:  Padding(
                        padding:  EdgeInsets.only(top: 7.h,left: 15),
                        child: InkWell(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: const Icon(Icons.arrow_forward_ios,color: AppColors.lightBlue,size: 25,)),
                      ),
                    ),
                    SizedBox(height: 3.h,),
                    //  Spacer(),
                    Image.asset(AssetsManager.splash,color: AppColors.white,width: 45.w,height: 25.h,),
                    SizedBox(height: 5.h,),
                    Center(
                      child: CustomContainer(
                          width: 90.w,
                          height: 32.h,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text("enter_new_password",style: Theme.of(context).textTheme.displayLarge,).tr(),
                              const SizedBox(height: 10,),
                              CustomTextField(title: 'password'.tr(),
                                textColor: AppColors.white.withOpacity(0.3),
                                textInputType: TextInputType.name,
                                backgroundColor: AppColors.primary,
                                minLine: 1,
                                isPassword: false,
                              ),
                              CustomTextField(title: 'confirm_password'.tr(),
                                textColor: AppColors.white.withOpacity(0.3),
                                textInputType: TextInputType.name,
                                backgroundColor: AppColors.primary,
                                minLine: 1,
                                isPassword: false,
                              ),
                              const SizedBox(height: 10,),
                              CustomButton(
                                width: 25.w,
                                backgroundColor: AppColors.yellow, textColor: AppColors.white,
                                text: "registration".tr(), onPressed: () {
                                 Navigator.pushNamed(context, Routes.homeRoute);
                                },
                                fontSize: 14,),
                              const SizedBox(height: 5,)
                            ],
                          )),
                    ),
                  ],
                ),
              ),

              BottomCopyRightsWidget(),
            ],
          ),
        );

      },
    );
  }
}
