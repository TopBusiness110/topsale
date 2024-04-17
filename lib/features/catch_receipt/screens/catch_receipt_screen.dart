import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';
import 'package:topsale/config/routes/app_routes.dart';
import 'package:topsale/core/utils/app_colors.dart';
import 'package:topsale/features/home/cubit/home_tab_cubit/home_cubit.dart';

import '../../../core/utils/app_assets.dart';
import '../../../core/widgets/custom_button.dart';
import '../models/catch_receipt_model.dart';

class CatchReceiptScreen extends StatelessWidget {
  final CatchReceiptModel catchReceiptModel;
  const CatchReceiptScreen({super.key, required this.catchReceiptModel});

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        Navigator.pushNamedAndRemoveUntil(
            context, Routes.homeRoute, (route) => false);
        return Future.value(false);
      },
      child: Scaffold(
        backgroundColor: AppColors.primary,
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: 15.h,
              ),
              Center(
                child: Container(
                  margin: EdgeInsets.only(top: 20),
                  height: 75.h,
                  width: 95.w,
                  decoration: const BoxDecoration(
                      borderRadius: BorderRadius.only(
                          topRight: Radius.circular(16),
                          topLeft: Radius.circular(16)),
                      color: AppColors.white),
                  child: Column(
                    children: [
                      Image.asset(
                        AssetsManager.splash,
                        width: 30.w,
                        height: 16.h,
                      ),
                      Text(
                        "catch_receipt".tr(),
                        style: Theme.of(context)
                            .textTheme
                            .displayLarge!
                            .copyWith(color: AppColors.primary),
                      ),
                      SizedBox(
                        height: 3.h,
                      ),
                      Text(
                        "تاريخ الدفع:  ${catchReceiptModel.date}",
                        style: Theme.of(context)
                            .textTheme
                            .displayLarge!
                            .copyWith(color: AppColors.primary),
                      ),
                      SizedBox(
                        height: 1.h,
                      ),
                      Text(
                        "رقم السند: ${catchReceiptModel.number}",
                        style: Theme.of(context)
                            .textTheme
                            .displayLarge!
                            .copyWith(color: AppColors.primary),
                      ),
                      SizedBox(
                        height: 1.h,
                      ),
                      Text(
                        "بواسطة: ${context.read<HomeCubit>().userName}",
                        style: Theme.of(context)
                            .textTheme
                            .bodyMedium!
                            .copyWith(color: AppColors.primary),
                      ),
                      SizedBox(
                        height: 1.h,
                      ),
                      Text(
                        "اسم العميل: ${catchReceiptModel.clientName}",
                        style: Theme.of(context)
                            .textTheme
                            .bodyMedium!
                            .copyWith(color: AppColors.primary),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 6.w),
                        child: Divider(),
                      ),
                      Text(
                        "اجمالي المدفوع: ${catchReceiptModel.amount} USD",
                        style: Theme.of(context)
                            .textTheme
                            .displayLarge!
                            .copyWith(color: AppColors.primary),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 6.w),
                        child: Divider(),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Text(
                          "www.topbusiness.io",
                          style: Theme.of(context)
                              .textTheme
                              .bodySmall!
                              .copyWith(color: AppColors.primary),
                        ),
                      ),
                      SizedBox(
                        height: 13.h,
                      ),
                      SizedBox(
                        height: 5.h,
                        child: Image.asset(
                          AssetsManager.whiteCopyRights,
                        ),
                      ),
                      SizedBox(
                        height: 2.h,
                      ),
                      CustomButton(
                          backgroundColor: AppColors.yellow,
                          textColor: AppColors.white,
                          text: "print".tr(),
                          onPressed: () {
                            //  Navigator.pushReplacementNamed(context, Routes.receiptRoute);
                          }),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
