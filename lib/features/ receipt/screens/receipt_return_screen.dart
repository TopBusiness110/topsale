import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:screenshot/screenshot.dart';
import 'package:sizer/sizer.dart';
import 'package:topsale/config/routes/app_routes.dart';
import 'package:topsale/core/utils/app_colors.dart';
import 'package:topsale/core/utils/decode_image.dart';
import 'package:topsale/core/utils/get_size.dart';
import 'package:topsale/features/%20receipt/cubit/receipt_cubit.dart';
import 'package:topsale/features/create_sales_order/cubit/create_sales_order_cubit.dart';
import 'package:topsale/features/home/cubit/home_tab_cubit/home_cubit.dart';
import 'package:topsale/features/payments/cubit/payments_cubit.dart';
import 'package:topsale/features/products/cubit/products_cubit.dart';
import 'package:e_invoice_generator/e_invoice_generator.dart';
import 'package:topsale/features/returns/cubit/returns_cubit.dart';
import '../../../core/utils/app_assets.dart';
import '../../../core/widgets/custom_button.dart';

class ReceiptReturnScreen extends StatelessWidget {
  const ReceiptReturnScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ReceiptCubit, ReceiptState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        
        ReceiptCubit cubit = context.read<ReceiptCubit>();
        return WillPopScope(
          onWillPop: () async {
            print('sssss');
            Navigator.pushNamedAndRemoveUntil(
                context, Routes.homeRoute, (route) => false);
            context.read<ProductsCubit>().selectedProducts = [];
            context.read<CreateSalesOrderCubit>().currentClient = "";

            return await true;
          },
          child: Scaffold(
            backgroundColor: AppColors.primary,
            body: SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 10.h,
                  ),
                  Center(
                    child: Container(
                      // height: 83.h,
                      // width: 95.w,
                      decoration: const BoxDecoration(
                          borderRadius: BorderRadius.only(
                              topRight: Radius.circular(16),
                              topLeft: Radius.circular(16)),
                          color: AppColors.white),
                      child: Column(
                        children: [
                          Screenshot(
                            controller: cubit.screenshotController,
                            child: Container(
                              decoration: const BoxDecoration(
                                  borderRadius: BorderRadius.only(
                                      topRight: Radius.circular(16),
                                      topLeft: Radius.circular(16)),
                                  color: AppColors.white),
                              child: Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 8.0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Container(
                                            width: getSize(context) / 3,
                                            decoration: BoxDecoration(
                                                shape: BoxShape.rectangle),
                                            margin: EdgeInsets.all(8),
                                            child: context
                                                        .read<HomeCubit>()
                                                        .companyDataModel ==
                                                    null
                                                ? SizedBox(
                                                    height: 3,
                                                  )
                                                : DecodedImage(
                                                    base64String: context
                                                        .read<HomeCubit>()
                                                        .companyDataModel!
                                                        .result![0]
                                                        .logo!,
                                                    context: context)),
                                        if (context
                                                .read<HomeCubit>()
                                                .companyDataModel !=
                                            null)
                                          if (context
                                                  .read<HomeCubit>()
                                                  .companyDataModel!
                                                  .result![0]
                                                  .countryCode ==
                                              'SA')
                                            EinvoiceGenerator(
                                              sellerName:
                                                  ' ${context.read<HomeCubit>().userName}',
                                              sellerTRN:
                                                  '${context.read<HomeCubit>().companyDataModel!.result![0].vat ?? 0.0}',
                                              totalWithVat:
                                                  ' ${context.read<CreateSalesOrderCubit>().sum + context.read<ProductsCubit>().taxesSum}',
                                              vatPrice:
                                                  '${context.read<ProductsCubit>().taxesSum}',
                                              size: getSize(context) / 3,
                                            ),
                                      ],
                                    ),
                                  ),
                                  //Image.asset(
                                  //  AssetsManager.splash,
                                  //  width: 30.w,
                                  //  height: 16.h,
                                  //),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Text(
                                        "فاتورة ضريبية مبسطة",
                                        style: Theme.of(context)
                                            .textTheme
                                            .displayLarge!
                                            .copyWith(color: AppColors.primary),
                                      ),
                                      BlocBuilder<ReturnsCubit,
                                              ReturnsState>(
                                          builder: (context, state) {
                                        return context
                                                    .read<
                                                        ReturnsCubit>()
                                                    .invoiceDetailsModel ==
                                                null
                                            ? SizedBox(
                                                width: 1,
                                              )
                                            : Text(
                                                "${context.read<ReturnsCubit>().invoiceDetailsModel!.name ?? "0"}",
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .displayLarge!
                                                    .copyWith(
                                                        color:
                                                            AppColors.primary),
                                              );
                                      }),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 1.h,
                                  ),
                                  Text(
                                    "تاريخ الفاتورة:${DateTime.now().toString().substring(0, 16)}",
                                    style: Theme.of(context)
                                        .textTheme
                                        .displayLarge!
                                        .copyWith(color: AppColors.primary),
                                  ),
                                  SizedBox(
                                    height: 1.h,
                                  ),
                                  Text(
                                    "${context.read<PaymentsCubit>().selectedValue ?? "آجل"}",
                                    // "لم يتم الدفع",
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
                                  // SizedBox(
                                  //   height: 1.h,
                                  // ),
                                  Text(
                                    "اسم العميل:${context.read<CreateSalesOrderCubit>().currentClient}",
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyMedium!
                                        .copyWith(color: AppColors.primary),
                                  ),
                                  Text(
                                    "اسم الفرع:${context.read<HomeCubit>().companyDataModel!.result![0].name ?? ''}",
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyMedium!
                                        .copyWith(color: AppColors.primary),
                                  ),
                                  if (context
                                          .read<HomeCubit>()
                                          .companyDataModel!
                                          .result![0]
                                          .street
                                          .toString() !=
                                      "false")
                                    Text(
                                      "عنوان الفرع:${context.read<HomeCubit>().companyDataModel!.result![0].street ?? ''}",
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyMedium!
                                          .copyWith(color: AppColors.primary),
                                    ),
                                  Text(
                                    "الرقم الضريبي:${context.read<HomeCubit>().companyDataModel!.result![0].vat ?? 0.0}",
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyMedium!
                                        .copyWith(color: AppColors.primary),
                                  ),
                                  // Text(
                                  //   "الرقم التسجيلي:${context.read<HomeCubit>().companyDataModel!.result![0].companyRegistry ?? 0.0}",
                                  //   style: Theme.of(context)
                                  //       .textTheme
                                  //       .bodyMedium!
                                  //       .copyWith(color: AppColors.primary),
                                  // ),
                                  Padding(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 6.w),
                                    child: Divider(),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 8.0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          "اسم المنتج",
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyMedium!
                                              .copyWith(
                                                  color: AppColors.primary),
                                        ),
                                        // SizedBox(
                                        //   width: 30.w,
                                        // ),
                                        Text(
                                          "كمية",
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyMedium!
                                              .copyWith(
                                                  color: AppColors.primary),
                                        ),
                                        //   SizedBox(
                                        //     width: 5.w,
                                        //   ),
                                        Text(
                                          "اجمالي",
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyMedium!
                                              .copyWith(
                                                  color: AppColors.primary),
                                        ),
                                      ],
                                    ),
                                  ),
                                  ListView.builder(
                                      shrinkWrap: true,
                                      physics: NeverScrollableScrollPhysics(),
                                      itemCount:  context.read<ReturnsCubit>().getManOrderDetailsModel!.result!.length,
                                      itemBuilder: (context, index) {
                                        return Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 8.0),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              Flexible(
                                                flex: 1,
                                                child: Text(
                                                  context.read<ReturnsCubit>().getManOrderDetailsModel!.result![index]
                                                      .name!,
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .bodyMedium!
                                                      .copyWith(
                                                          color: AppColors
                                                              .primary),
                                                ),
                                              ),
                                              //  SizedBox(
                                              //    width: 20.w,
                                              //  ),
                                              Flexible(
                                                flex: 1,
                                                child: Text(
                                                   context.read<ReturnsCubit>().getManOrderDetailsModel!.result![index]
                                                      .userProductUomQty
                                                      .toString(),
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .bodyMedium!
                                                      .copyWith(
                                                          color: AppColors
                                                              .primary),
                                                ),
                                              ),
                                              // SizedBox(
                                              //   width: 5.w,
                                              // ),
                                              Flexible(
                                                flex: 1,
                                                child: Text(
                                                  "${ context.read<ReturnsCubit>().getManOrderDetailsModel!.result![index].userProductUomQty *  context.read<ReturnsCubit>().getManOrderDetailsModel!.result![index].userProductUomQty!} ${context.read<HomeCubit>().currencyName}",
                                                  //    context
                                                  //        .read<
                                                  //            CreateSalesOrderCubit>()
                                                  //        .sum
                                                  //        .toString(),
                                                  // context
                                                  //     .read<ProductsCubit>()
                                                  //     .selectedProducts[0]
                                                  //     .listPrice
                                                  //     .toString(),

                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .bodyMedium!
                                                      .copyWith(
                                                          color: AppColors
                                                              .primary),
                                                ),
                                              ),
                                            ],
                                          ),
                                        );
                                      }),

                                  Padding(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 6.w),
                                    child: Divider(),
                                  ),
                                  Text(
                                    "ضريبة القيمة المضافة: ${context.read<ProductsCubit>().taxesSum.toStringAsFixed(2)} ${context.read<HomeCubit>().currencyName}",
                                    style: Theme.of(context)
                                        .textTheme
                                        .displayLarge!
                                        .copyWith(color: AppColors.primary),
                                  ),
                                  Padding(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 6.w),
                                    child: Divider(),
                                  ),
                                  Text(
                                    "الاجمالي: ${context.read<CreateSalesOrderCubit>().sum + context.read<ProductsCubit>().taxesSum} ${context.read<HomeCubit>().currencyName}",
                                    style: Theme.of(context)
                                        .textTheme
                                        .displayLarge!
                                        .copyWith(color: AppColors.primary),
                                  ),
                                  Padding(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 6.w),
                                    child: Divider(),
                                  ),
                                  Text(
                                    "المدفوع: 00.00 ${context.read<HomeCubit>().currencyName}",
                                    style: Theme.of(context)
                                        .textTheme
                                        .displayLarge!
                                        .copyWith(color: AppColors.primary),
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Text(
                                    "الباقي: ${context.read<CreateSalesOrderCubit>().sum + context.read<ProductsCubit>().taxesSum - 0.0} ${context.read<HomeCubit>().currencyName}",
                                    style: Theme.of(context)
                                        .textTheme
                                        .displayLarge!
                                        .copyWith(color: AppColors.primary),
                                  ),
                                  Padding(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 6.w),
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
                                    height: 5.h,
                                    child: Image.asset(
                                      AssetsManager.whiteCopyRights,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 2.h,
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
                          SizedBox(
                            height: 2.h,
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
