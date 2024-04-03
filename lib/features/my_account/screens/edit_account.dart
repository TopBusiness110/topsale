import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:topsale/core/utils/app_colors.dart';
import 'package:topsale/core/widgets/custom_button.dart';

import '../../../core/utils/app_assets.dart';
import '../../../core/widgets/custom_arrow_back.dart';
import '../components/custom_edit_container.dart';

class EditAccountScreen extends StatelessWidget {
  const EditAccountScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var nameController = TextEditingController();
    var emailController = TextEditingController();
    var phoneController = TextEditingController();
    var passwordController = TextEditingController();
    GlobalKey<FormState> formKey = GlobalKey<FormState>();
    return Scaffold(
      backgroundColor: AppColors.primary,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 8.0),
                    child: Text(
                      "edit_account",
                      style: Theme.of(context).textTheme.displayLarge,
                    ).tr(),
                  ),
                  const Spacer(),
                  const CustomArrowBack()
                ],
              ),
              SizedBox(
                height: 7.h,
              ),
              Stack(
                children: [
                  Container(
                    margin: const EdgeInsets.only(top: 50),
                    height: 70.h,
                    width: double.infinity,
                    clipBehavior: Clip.antiAlias,
                    decoration: const ShapeDecoration(
                        color: AppColors.lightBlue,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(64),
                                topRight: Radius.circular(64)))),
                    child: Form(
                      key: formKey,
                      child: Column(
                        children: [
                          SizedBox(
                            height: 10.h,
                          ),
                          Text(
                            "مصطفى خليل",
                            style: Theme.of(context).textTheme.displayMedium,
                          ),
                          const Spacer(),
                          // SizedBox(height: 10,),
                          CustomEditContainer(
                            controller: nameController,
                            textInputType: TextInputType.name,
                            label: "الاسم",
                            icon: Icons.person,
                          ),
                          SizedBox(
                            height: 3.h,
                          ),
                          CustomEditContainer(
                            controller: phoneController,
                            textInputType: TextInputType.phone,
                            label: "التليفون",
                            icon: Icons.phone,
                          ),
                          SizedBox(
                            height: 3.h,
                          ),
                          CustomEditContainer(
                            controller: emailController,
                            textInputType: TextInputType.emailAddress,
                            label: "البريد الاكتروني",
                            icon: Icons.mail,
                          ),
                          SizedBox(
                            height: 3.h,
                          ),
                          CustomEditContainer(
                            controller: passwordController,
                            isPassword: true,
                            textInputType: TextInputType.text,
                            label: "الرقم السري",
                            icon: Icons.lock,
                          ),
                          SizedBox(
                            height: 3.h,
                          ),
                          CustomButton(
                            width: 20.w,
                            backgroundColor: AppColors.yellow,
                            text: "done".tr(),
                            onPressed: () {
                              if (formKey.currentState!.validate()) {
                                print('Form is valid');
                              } else {
                                print('Form is Not valid');
                              }
                            },
                            textColor: AppColors.white,
                          ),
                          const Spacer()
                        ],
                      ),
                    ),
                  ),
                  const Positioned(
                      right: 0,
                      left: 0,
                      child: CircleAvatar(
                        radius: 60,
                        backgroundColor: AppColors.primary,
                      )),
                  Positioned(
                      top: 5,
                      right: 0,
                      left: 0,
                      child: CircleAvatar(
                        radius: 54,
                        // backgroundColor: AppColors.white,
                        // backgroundImage: AssetImage(AssetsManager.aly,),
                        child: Image.asset(AssetsManager.aly),
                      ))
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
