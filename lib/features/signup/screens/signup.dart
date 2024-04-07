import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';
import 'package:topsale/features/login/cubit/login_cubit.dart';
import 'package:topsale/features/signup/cubit/signup_cubit.dart';

import '../../../config/routes/app_routes.dart';
import '../../../core/utils/app_assets.dart';
import '../../../core/utils/app_colors.dart';
import '../../../core/widgets/bottom_copy_rights_widget.dart';

import '../../../core/widgets/custom_button.dart';
import '../../../core/widgets/custom_container.dart';
import '../../../core/widgets/custom_textfield.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  TextEditingController phoneController = TextEditingController();
  TextEditingController passwordControl = TextEditingController();
  TextEditingController databaseControl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    SignupCubit cubit = context.read<SignupCubit>();

    return BlocConsumer<SignupCubit, SignupState>(
        listener: (context, state) {},
        builder: (context, state) {
          return Scaffold(
            resizeToAvoidBottomInset: true,
            backgroundColor: AppColors.primary,
            body: Stack(
              children: [
                SingleChildScrollView(
                  child: Column(
                    children: [
                      Align(
                        alignment: Alignment.topLeft,
                        child: Padding(
                          padding: EdgeInsets.only(top: 7.h, left: 15),
                          child: InkWell(
                              onTap: () {
                                Navigator.pop(context);
                              },
                              child: const Icon(
                                Icons.arrow_forward_ios,
                                color: AppColors.yellow,
                                size: 25,
                              )),
                        ),
                      ),
                      SizedBox(
                        height: 5.h,
                      ),
                      //  Spacer(),
                      Image.asset(
                        AssetsManager.splash,
                        color: AppColors.white,
                        width: 45.w,
                        height: 25.h,
                      ),
                      // SizedBox(height: 2.h,),
                      Center(
                        child: CustomContainer(
                            width: 90.w,
                            // height: 49.h,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  "new_register",
                                  style:
                                      Theme.of(context).textTheme.displayLarge,
                                ).tr(),
                                SizedBox(
                                  height: 3.h,
                                ),
                                CustomTextField(
                                  title: 'seller_name'.tr(),
                                  textColor: AppColors.white.withOpacity(0.3),
                                  textInputType: TextInputType.name,
                                  backgroundColor: AppColors.primary,
                                  minLine: 1,
                                  isPassword: false,
                                ),
                                CustomTextField(
                                  title: 'odoo_link'.tr(),
                                  textColor: AppColors.white.withOpacity(0.3),
                                  textInputType: TextInputType.name,
                                  backgroundColor: AppColors.primary,
                                  minLine: 1,
                                  isPassword: false,
                                ),
                                CustomTextField(
                                  title: 'database_name'.tr(),
                                  textColor: AppColors.white.withOpacity(0.3),
                                  textInputType: TextInputType.text,
                                  backgroundColor: AppColors.primary,
                                  minLine: 1,
                                  isPassword: false,
                                ),
                                CustomTextField(
                                  title: 'user_name'.tr(),
                                  controller: phoneController,
                                  textColor: AppColors.white.withOpacity(0.3),
                                  textInputType: TextInputType.name,
                                  backgroundColor: AppColors.primary,
                                  minLine: 1,
                                  isPassword: false,
                                ),
                                CustomTextField(
                                  title: 'password'.tr(),
                                  controller: passwordControl,
                                  textColor: AppColors.white.withOpacity(0.3),
                                  textInputType: TextInputType.text,
                                  backgroundColor: AppColors.primary,
                                  minLine: 1,
                                  isPassword: false,
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                CustomButton(
                                  backgroundColor: AppColors.yellow,
                                  textColor: AppColors.white,
                                  text: "registration".tr(),
                                  onPressed: () {
                                    cubit.login(context,
                                        phoneOrMail: phoneController.text,
                                        password: passwordControl.text,
                                        db: databaseControl.text);
                                  },
                                  fontSize: 14,
                                ),
                                const SizedBox(
                                  height: 5,
                                )
                              ],
                            )),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      BottomCopyRightsWidget()
                    ],
                  ),
                ),
              ],
            ),
          );
        });
  }
}
