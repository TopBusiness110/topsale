import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:screenshot/screenshot.dart';
import 'package:sizer/sizer.dart';
import 'package:topsale/core/utils/app_colors.dart';
import 'package:topsale/features/%20receipt/cubit/receipt_cubit.dart';
import 'package:topsale/features/create_sales_order/cubit/create_sales_order_cubit.dart';
import 'package:topsale/features/payments/cubit/payments_cubit.dart';

import '../../../core/utils/app_assets.dart';
import '../../../core/widgets/custom_button.dart';

class  ReceiptScreen extends StatelessWidget {
  const  ReceiptScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return  BlocConsumer<ReceiptCubit, ReceiptState>(
  listener: (context, state) {
    // TODO: implement listener
  },
  builder: (context, state) {
    ReceiptCubit cubit = context.read<ReceiptCubit>();
    return Scaffold(
      backgroundColor: AppColors.primary,
      body: Column(
       mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(height: 10.h,),
          Center(
            child: Container(
              height: 83.h,
            width: 95.w,
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(topRight:Radius.circular(16) ,topLeft: Radius.circular(16)),
              color: AppColors.white
            ),
              child: SingleChildScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                child: Column(
                  children: [
                    Screenshot(

                      controller: cubit.screenshotController,
                      child: Container(
                        decoration: const BoxDecoration(
                            borderRadius: BorderRadius.only(topRight:Radius.circular(16) ,topLeft: Radius.circular(16)),
                            color: AppColors.white
                        ),
                        child: Column(
                          children: [
                            Image.asset(
                              AssetsManager.splash,
                              width: 30.w,
                              height: 16.h,
                            ),
                            Text(
                              "receipt".tr(),
                              style: Theme.of(context)
                                  .textTheme
                                  .displayLarge!
                                  .copyWith(color: AppColors.primary),
                            ),
                            SizedBox(height: 3.h,),
                            Text(
                              "تاريخ الفاتورة:${DateTime.now().toString().substring(0,16)}",
                              style: Theme.of(context)
                                  .textTheme
                                  .displayLarge!
                                  .copyWith(color: AppColors.primary),
                            ),
                            SizedBox(height: 1.h,),
                            Text(
                             "${ context.read<PaymentsCubit>().selectedValue??"آجل"}",
                             // "لم يتم الدفع",
                              style: Theme.of(context)
                                  .textTheme
                                  .displayLarge!
                                  .copyWith(color: AppColors.primary),
                            ),
                            SizedBox(height: 1.h,),
                            Text(
                              "بواسطة: TopBusiness",
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium!
                                  .copyWith(color: AppColors.primary),
                            ),
                            SizedBox(height: 1.h,),
                            Text(
                              "اسم العميل:${context.read<CreateSalesOrderCubit>().currentClient}",
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium!
                                  .copyWith(color: AppColors.primary),
                            ),
                            Padding(
                              padding:  EdgeInsets.symmetric(horizontal: 6.w),
                              child: Divider(),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [

                                Text(
                                  "اسم المنتج",
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyMedium!
                                      .copyWith(color: AppColors.primary),
                                ),
                                SizedBox(width: 30.w,),
                                Text(
                                  "كمية",
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyMedium!
                                      .copyWith(color: AppColors.primary),
                                ),
                                SizedBox(width: 5.w,),
                                Text(
                                  "اجمالي",
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyMedium!
                                      .copyWith(color: AppColors.primary),
                                ),

                              ],
                            ),
                            const SizedBox(height: 10,),
                            //todo--> list of products
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [

                                Text(
                                  " حامل هاتف معدني",
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyMedium!
                                      .copyWith(color: AppColors.primary),
                                ),
                                SizedBox(width: 20.w,),
                                Text(
                                  "2",
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyMedium!
                                      .copyWith(color: AppColors.primary),
                                ),
                                SizedBox(width: 5.w,),
                                Text(
                                  "245.22",
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyMedium!
                                      .copyWith(color: AppColors.primary),
                                ),

                              ],
                            ),
                            Padding(
                              padding:  EdgeInsets.symmetric(horizontal: 6.w),
                              child: Divider(),
                            ),
                            Text(
                              "الضريبة: 5.00 USD",
                              style: Theme.of(context)
                                  .textTheme
                                  .displayLarge!
                                  .copyWith(color: AppColors.primary),
                            ),
                            Padding(
                              padding:  EdgeInsets.symmetric(horizontal: 6.w),
                              child: Divider(),
                            ),
                            Text(
                              "الاجمالي: 500.00 USD",
                              style: Theme.of(context)
                                  .textTheme
                                  .displayLarge!
                                  .copyWith(color: AppColors.primary),
                            ),
                            Padding(
                              padding:  EdgeInsets.symmetric(horizontal: 6.w),
                              child: Divider(),
                            ),
                            Text(
                              "المدفوع: 00.00 USD",
                              style: Theme.of(context)
                                  .textTheme
                                  .displayLarge!
                                  .copyWith(color: AppColors.primary),
                            ),
                            SizedBox(height: 5,),
                            Text(
                              "الباقي: 500.00 USD",
                              style: Theme.of(context)
                                  .textTheme
                                  .displayLarge!
                                  .copyWith(color: AppColors.primary),
                            ),
                            Padding(
                              padding:  EdgeInsets.symmetric(horizontal: 6.w),
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
                              height: 7.h,
                              child: Image.asset(
                                "assets/icon/copy_rights_blue.png",
                                color: Colors.black,
                              ),
                            ),
                            // CustomButton(
                            //     backgroundColor: AppColors.yellow,
                            //     textColor: AppColors.white,
                            //     text: "print".tr(),
                            //     onPressed: () {
                            //     //  Navigator.pushReplacementNamed(context, Routes.receiptRoute);
                            //     }),

                          ],
                        ),
                      ),
                    ),
                    CustomButton(
                        backgroundColor: AppColors.yellow,
                        textColor: AppColors.white,
                        text: "print".tr(),
                        onPressed: () async {
                         await cubit.captureScreenshot();
                          //  Navigator.pushReplacementNamed(context, Routes.receiptRoute);
                        }),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  },
);
  }
}
