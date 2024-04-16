import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';
import 'package:topsale/core/utils/app_assets.dart';
import 'package:topsale/core/utils/app_colors.dart';
import 'package:topsale/core/widgets/custom_button.dart';
import 'package:topsale/core/widgets/toast.dart';
import 'package:topsale/features/create_sales_order/cubit/create_sales_order_cubit.dart';
import 'package:topsale/features/payments/cubit/payments_cubit.dart';

import '../../../config/routes/app_routes.dart';
import '../../../core/widgets/custom_arrow_back.dart';

class PaymentScreen extends StatefulWidget {
  PaymentScreen(
      {super.key,
      required this.sum,
      this.onPressed,
      required this.productId,
      required this.quantity,
      required this.partnerId});
  final double sum;
  final productId;
  final quantity;
  final partnerId;
  final void Function()? onPressed;

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<PaymentsCubit, PaymentsState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        PaymentsCubit cubit = context.read<PaymentsCubit>();

        return OrientationBuilder(
          builder: (context, orientation) {
            if (orientation == Orientation.landscape) {
              SystemChrome.setPreferredOrientations([
                DeviceOrientation.portraitDown,
                DeviceOrientation.portraitUp
              ]);
            }
            return WillPopScope(
              onWillPop: () async {
                cubit.changeButtonColor(false);
                return true;
              },
              child: Scaffold(
                resizeToAvoidBottomInset: true,
                backgroundColor: AppColors.primary,
                body: Stack(
                  children: [
                    //app bar
                    Positioned(
                        left: 2.w,
                        top: 3.h,
                        child: Row(
                          children: [
                            Text(
                              "create_sales_order",
                              style: Theme.of(context).textTheme.displayLarge,
                            ).tr(),
                            const CustomArrowBack(),
                          ],
                        )),
                    //the big white container
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: SingleChildScrollView(
                        child: Container(
                          width: double.infinity,
                          height: 73.h,
                          decoration: const BoxDecoration(
                              color: AppColors.white,
                              borderRadius: BorderRadius.only(
                                  topRight: Radius.circular(60),
                                  topLeft: Radius.circular(60))),
                          child: Column(
                            children: [
                              Image.asset(
                                AssetsManager.splash,
                                width: 30.w,
                                height: 20.h,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Icon(
                                    Icons.check,
                                    color: AppColors.yellow,
                                    size: 25,
                                  ),
                                  SizedBox(
                                    width: 3.w,
                                  ),
                                  Text(
                                    "sales_order_success".tr(),
                                    style: Theme.of(context)
                                        .textTheme
                                        .displayMedium!
                                        .copyWith(color: AppColors.primary),
                                  )
                                ],
                              ),
                              const SizedBox(
                                height: 8,
                              ),
                              Text("الاجمالي: ${widget.sum} USD",
                                  style: Theme.of(context)
                                      .textTheme
                                      .displayMedium!
                                      .copyWith(color: AppColors.primary)),
                              SizedBox(
                                height: 3.h,
                              ),
                              Text(
                                "the_payment".tr(),
                                style: Theme.of(context)
                                    .textTheme
                                    .displayMedium!
                                    .copyWith(color: AppColors.primary),
                              ),
                              const SizedBox(
                                height: 8,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Radio(
                                    value: 1,
                                    groupValue: cubit.selectedRadioValue,
                                    onChanged: (value) {
                                      cubit.setSelectedRadioValue(value!);
                                    },
                                  ),
                                  Text('without_payment'.tr(),
                                      style: Theme.of(context)
                                          .textTheme
                                          .displayMedium!
                                          .copyWith(color: AppColors.primary)),
                                  SizedBox(
                                    width: 14.w,
                                  ),
                                  Radio(
                                    value: 2,
                                    groupValue: cubit.selectedRadioValue,
                                    onChanged: (value) {
                                      cubit.setSelectedRadioValue(value!);
                                    },
                                  ),
                                  Text('with_payment'.tr(),
                                      style: Theme.of(context)
                                          .textTheme
                                          .displayMedium!
                                          .copyWith(color: AppColors.primary)),
                                ],
                              ),
                              //drop down button
                              Visibility(
                                visible: cubit.selectedRadioValue == 2
                                    ? true
                                    : false,
                                child: Container(
                                  margin: EdgeInsets.symmetric(horizontal: 5.w),
                                  decoration: BoxDecoration(
                                      color: cubit.isSelected
                                          ? AppColors.primary
                                          : AppColors.white,
                                      borderRadius: BorderRadius.circular(10),
                                      border:
                                          Border.all(color: AppColors.primary)),
                                  child: DropdownButtonHideUnderline(
                                    child: DropdownButton2(
                                      dropdownStyleData:
                                          const DropdownStyleData(
                                              decoration: BoxDecoration(
                                        color: AppColors.primary,
                                      )),
                                      value: cubit.selectedValue,
                                      onChanged: (value) {
                                        cubit.selectPaymentMethod(value);
                                      },
                                      isExpanded: true,
                                      hint: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text("payment_method".tr(),
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .displayMedium!
                                                  .copyWith(
                                                      color:
                                                          AppColors.primary)),
                                        ],
                                      ),
                                      items: cubit.allJournalsModel!.result!
                                          .map((item) =>
                                              DropdownMenuItem<String>(
                                                  value: item.id.toString(),
                                                  child: Text(
                                                    item.displayName!,
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .displayMedium!
                                                        .copyWith(
                                                          color:
                                                              AppColors.white,
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                        ),
                                                  )))
                                          .toList(),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 3.h,
                              ),
                              // Text(
                              //   "the_payment".tr(),
                              //   style: Theme.of(context)
                              //       .textTheme
                              //       .displayMedium!
                              //       .copyWith(color: AppColors.primary),
                              // ),
                              // const SizedBox(height: 8,),
                              // Row(
                              //   mainAxisAlignment: MainAxisAlignment.center,
                              //   children: [
                              //     Radio(
                              //       value: 1,
                              //       groupValue: cubit.selectedRadioValue,
                              //       onChanged: (value) {
                              //         cubit.setSelectedRadioValue(value!);
                              //       },
                              //     ),
                              //      Text(
                              //       'without_payment'.tr(),
                              //       style:Theme.of(context).textTheme.displayMedium!.copyWith( color: AppColors.primary)),
                              //    SizedBox(width: 14.w,),
                              //     Radio(
                              //       value: 2,
                              //       groupValue: cubit.selectedRadioValue,
                              //       onChanged: (value) {
                              //         cubit.setSelectedRadioValue(value!);
                              //       },
                              //     ),
                              //      Text('with_payment'.tr(),
                              //          style:Theme.of(context).textTheme.displayMedium!.copyWith( color: AppColors.primary)),
                              //
                              //   ],
                              // ),
                              const SizedBox(
                                height: 8,
                              ),
                              Visibility(
                                  visible: cubit.selectedRadioValue == 2
                                      ? true
                                      : false,
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: SizedBox(
                                      height: 5.h,
                                      width: 80.w,
                                      child: TextFormField(
                                        controller: cubit.amountController,
                                        keyboardType: TextInputType.number,
                                        style: Theme.of(context)
                                            .textTheme
                                            .displayMedium,
                                        decoration: InputDecoration(
                                            hintText:
                                                "المبلغ   ${widget.sum}  ",
                                            hintStyle: const TextStyle(
                                                color: AppColors.white,
                                                fontWeight: FontWeight.w600),
                                            contentPadding:
                                                const EdgeInsets.symmetric(
                                                    vertical: 5.0,
                                                    horizontal: 5),
                                            border: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(20)),
                                            filled: true,
                                            fillColor: AppColors.primary),
                                      ),
                                    ),
                                  )),
                              SizedBox(
                                height: 5.h,
                                child: Image.asset(
                                  AssetsManager.whiteCopyRights,
                                ),
                              ),
                              SizedBox(
                                height: 2.h,
                              ),
                              //the last 2 buttons
                              SizedBox(
                                height: 40,
                                child: Padding(
                                  padding: EdgeInsets.only(bottom: 0.3.h),
                                  child: BlocConsumer<CreateSalesOrderCubit,
                                          CreateSalesOrderState>(
                                      listener: (context, state) {},
                                      builder: (context, state) {
                                        return CustomButton(
                                            backgroundColor: AppColors.yellow,
                                            textColor: AppColors.white,
                                            text: "confirm".tr(),
                                            onPressed: () {
                                              if (cubit.selectedRadioValue ==
                                                  1) {
                                                cubit.createInvoice(context,
                                                    partnerId: widget.partnerId,
                                                    productId: widget.productId,
                                                    quantity: widget.quantity,
                                                    amount: widget.sum);
                                              } else {
                                                if (cubit.selectedValue ==
                                                    null) {
                                                  makeToast(
                                                      "من فضلك اخر وسيلة الدفع");

                                                  print(
                                                      "please select payment method");
                                                } else {
                                                  cubit.createInvoice(context,
                                                      partnerId:
                                                          widget.partnerId,
                                                      productId:
                                                          widget.productId,
                                                      quantity: widget.quantity,
                                                      amount: widget.sum);
                                                }
                                              }
                                            });
                                      }),
                                  // Row(
                                  //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  //   children: [
                                  //     CustomButton(
                                  //         backgroundColor: AppColors.yellow,
                                  //         textColor: AppColors.white,
                                  //         text: "confirm".tr(),
                                  //         onPressed: () {
                                  //           Navigator.pushReplacementNamed(context, Routes.receiptRoute);
                                  //         }),
                                  //     CustomButton(
                                  //         backgroundColor: AppColors.primary,
                                  //         textColor: AppColors.white,
                                  //         text: "print".tr(),
                                  //         onPressed: () {}),
                                  //   ],
                                  // ),
                                ),
                              )
                              // SizedBox(height: 30,)
                            ],
                          ),
                        ),
                      ),
                    ),
                    //copy rights
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }
}
