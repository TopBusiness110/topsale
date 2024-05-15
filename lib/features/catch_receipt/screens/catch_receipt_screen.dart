import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:screenshot/screenshot.dart';
import 'package:sizer/sizer.dart';
import 'package:topsale/config/routes/app_routes.dart';
import 'package:topsale/core/utils/app_colors.dart';
import 'package:topsale/core/utils/decode_image.dart';
import 'package:topsale/features/create_sales_order/cubit/create_sales_order_cubit.dart';
import 'package:topsale/features/customer_payments/cubit/customer_payments_cubit.dart';
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
        context.read<CreateSalesOrderCubit>().currentClient = "";

        return Future.value(false);
      },
      child: Scaffold(
        backgroundColor: AppColors.primary,
        body: BlocConsumer<CustomerPaymentsCubit, CustomerPaymentsState>(
            listener: (context, state) {
          // TODO: implement listener
        }, builder: (context, state) {
          CustomerPaymentsCubit cubit = context.read<CustomerPaymentsCubit>();
          return SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                SizedBox(
                  height: 15.h,
                ),
                Container(
                  margin: EdgeInsets.only(top: 20),
                  // height: 75.h,
                  // width: 95.w,
                  decoration: const BoxDecoration(
                      borderRadius: BorderRadius.only(
                          topRight: Radius.circular(16),
                          topLeft: Radius.circular(16)),
                      color: AppColors.white),
                  child: Screenshot(
                    controller: cubit.screenshotController,
                    child: Column(
                      children: [
                        Container(
                            height: 16.h,
                            decoration:
                                BoxDecoration(shape: BoxShape.rectangle),
                            margin: EdgeInsets.all(8),
                            child: context.read<HomeCubit>().companyDataModel ==
                                    null
                                ? SizedBox(
                                    height: 3,
                                  )
                                // Image.asset('assets/images/splash.png',
                                //     color: AppColors.primary, fit: BoxFit.cover)
                                : DecodedImage(
                                    base64String: context
                                        .read<HomeCubit>()
                                        .companyDataModel!
                                        .result![0]
                                        .logo!,
                                    context: context)),
                        // Image.asset(
                        //   AssetsManager.splash,
                        //   width: 30.w,
                        //   height: 16.h,
                        // ),
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
                          "تاريخ الدفع: ${DateTime.now().toString().substring(0, 16)}",
                          style: Theme.of(context)
                              .textTheme
                              .displayLarge!
                              .copyWith(color: AppColors.primary),
                        ),
                        SizedBox(
                          height: 1.h,
                        ),
                        if (cubit.getPaymentByIdModel != null)
                          InkWell(
                            onTap: () {
                              print(
                                "رقم السند: ${cubit.getPaymentByIdModel!.result![0].name ?? ''}",
                              );
                            },
                            child: BlocBuilder<CustomerPaymentsCubit,
                                    CustomerPaymentsState>(
                                builder: (context, state) {
                              return Text(
                                "رقم السند: ${cubit.getPaymentByIdModel!.result![0].name ?? '55'}",
                                style: Theme.of(context)
                                    .textTheme
                                    .displayLarge!
                                    .copyWith(color: AppColors.primary),
                              );
                            }),
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
                          "اجمالي المدفوع: ${catchReceiptModel.amount} ${context.read<HomeCubit>().currencyName}",
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
                        // SizedBox(
                        //   height: 13.h,
                        // ),
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
                            onPressed: () async {
                              await cubit.captureScreenshot();

                              //  Navigator.pushReplacementNamed(context, Routes.receiptRoute);
                            }),
                        SizedBox(
                          height: 1.h,
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          );
        }),
      ),
    );
  }
}
