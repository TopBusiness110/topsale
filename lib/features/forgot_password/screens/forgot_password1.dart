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

import '../../../core/widgets/custom_arrow_back.dart';
import '../../../core/widgets/custom_button.dart';
import '../../../core/widgets/custom_container.dart';
import '../../../core/widgets/custom_textfield.dart';

class ForgotPasswordStep1 extends StatelessWidget {
  const ForgotPasswordStep1({super.key});

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
                        child:CustomArrowBack()
                      ),
                    ),
                    SizedBox(height: 3.h,),
                    //  Spacer(),
                    Image.asset(AssetsManager.splash,color: AppColors.white,width: 45.w,height: 25.h,),
                    SizedBox(height: 5.h,),
                    Center(
                      child: CustomContainer(
                          width: 90.w,
                          height: 25.h,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text("password_recover",style: Theme.of(context).textTheme.displayLarge,).tr(),
                              CustomTextField(title: 'email'.tr(),
                                textColor: AppColors.white.withOpacity(0.3),
                                textInputType: TextInputType.name,
                                backgroundColor: AppColors.primary,
                                minLine: 1,
                                isPassword: false,
                              ),
                              CustomButton(backgroundColor: AppColors.yellow, textColor: AppColors.white,
                                text: "recover".tr(), onPressed: () {
                                Navigator.pushNamed(context, Routes.forgotPassword2Route);
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
              //const CopyRightsWidget()
            ],
          ),
        );
      },
    );
  }
}
