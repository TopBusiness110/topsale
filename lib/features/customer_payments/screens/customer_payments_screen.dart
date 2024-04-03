

import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:easy_localization/easy_localization.dart' as easy;

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
//import 'package:intl/intl.dart'as intl;
import 'package:sizer/sizer.dart';
import 'package:topsale/features/customer_payments/cubit/customer_payments_cubit.dart';

import '../../../config/routes/app_routes.dart';
import '../../../core/methods/clients.dart';
import '../../../core/models/client_model.dart';
import '../../../core/utils/app_colors.dart';
import '../../../core/widgets/custom_arrow_back.dart';
import '../../../core/widgets/custom_button.dart';
import '../../../core/widgets/custom_textfield.dart';
import '../../../core/widgets/toast.dart';
import '../../catch_receipt/models/catch_receipt_model.dart';

class CustomerPaymentsScreen extends StatelessWidget {
  const CustomerPaymentsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CustomerPaymentsCubit, CustomerPaymentsState>(
  listener: (context, state) {
    // TODO: implement listener
  },
  builder: (context, state) {
    CustomerPaymentsCubit cubit = context.read<CustomerPaymentsCubit>();
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: AppColors.primary,
      body: SingleChildScrollView(
        child: Column(
          children: [
           SizedBox(height: 5.h,),
               Row(
                  children: [
                    const Spacer(),
                    Text(
                      "customer_payments",
                      style: Theme.of(context).textTheme.displayLarge,
                    ).tr(),
                    const CustomArrowBack(),

                  ],
                ),
         //   Spacer(),
            SizedBox(height: 20.h,),
            Container(
              width: double.infinity,
              height: 65.h,
              decoration: const BoxDecoration(
                color: AppColors.blue2,
                borderRadius: BorderRadius.only(topLeft: Radius.circular(64) ,topRight: Radius.circular(64))
              ),
              child: Column(
                children: [
                  SizedBox(height: 3.h,),
                  InkWell(
                   onTap: () {
                     showClientsPopup(context, clients);
                   },
                    child: Container(
                      width: 80.w,
                      height: 6.h,
                      padding: const EdgeInsets.all(15),
                      decoration: BoxDecoration(
                        border:
                        Border.all(color: AppColors.white, width: 2),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Text(
                        //"",
                        cubit.currentClient == ""
                            ? "client".tr()
                            : cubit.currentClient,
                        style: Theme.of(context)
                            .textTheme
                            .bodyMedium!
                            .copyWith(
                          color: AppColors.white.withOpacity(0.3),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 3.h,),
                  //drop down button
                  Container(
                    width: 80.w,
                    decoration: BoxDecoration(
                        color: cubit.isSelected
                            ? AppColors.primary
                            : AppColors.blue2,
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(color: AppColors.white,width: 2)),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton2(
                        dropdownStyleData: const DropdownStyleData(
                            decoration: BoxDecoration(
                              color: AppColors.primary,
                            )),
                        value: cubit.selectedPaymentValue,
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
                                    .copyWith(color: AppColors.primary)),
                          ],
                        ),
                        items: cubit.items
                            .map((item) => DropdownMenuItem<String>(
                            value: item,
                            child: Text(
                              item,
                              style: Theme.of(context)
                                  .textTheme
                                  .displayMedium!
                                  .copyWith(
                                color: AppColors.white,
                                overflow: TextOverflow.ellipsis,
                              ),
                            )))
                            .toList(),
                      ),
                    ),
                  ),
                  SizedBox(height: 3.h,),
                  SizedBox(
                    width: 90.w,
                    child: CustomTextField(
                      controller: cubit.amountController,
                      title: 'المبلغ'.tr(),
                      textColor: AppColors.white.withOpacity(0.3),
                      textInputType: TextInputType.number,
                      backgroundColor: AppColors.primary,
                      minLine: 1,
                      isPassword: false,
                    ),
                  ),

                  SizedBox(height: 3.h,),
                  SizedBox(
                    width: 90.w,
                    child: CustomTextField(title: 'memo'.tr(),
                      controller: cubit.memoController,
                      textColor: AppColors.white.withOpacity(0.3),
                      textInputType: TextInputType.text,
                      backgroundColor: AppColors.primary,
                      minLine: 1,
                      isPassword: false,
                    ),
                  ),

                  SizedBox(height: 3.h,),
                  SizedBox(
                    width: 90.w,
                    child: CustomTextField(
                      readOnly: true,
                      controller: cubit.datePickedController,
                      title: 'date'.tr(),
                      textColor: AppColors.white.withOpacity(0.3),
                      textInputType: TextInputType.text,
                      backgroundColor: AppColors.primary,
                      minLine: 1,
                      isPassword: false,
                      onTap: () async{
                        DateTime? pickedDate = await showDatePicker(context: context, initialDate: DateTime.now(), firstDate: DateTime.now(), lastDate: DateTime(2050));

                      String?  formattedDate = easy.DateFormat('MM/d/yyyy').format(pickedDate!);
                          cubit.datePickedController.text = formattedDate;

                      },
                    ),
                  ),

                  SizedBox(height: 3.h,),
                  //the last 2 buttons
                  Padding(
                    padding: EdgeInsets.only(bottom: 0.3.h),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        CustomButton(
                            backgroundColor: AppColors.yellow,
                            textColor: AppColors.white,
                            text: "with_payment".tr(),
                            onPressed: () {
                              if(cubit.currentClient==""){
                                makeToast("choose client");
                              }
                              else if(cubit.selectedPaymentValue==null){
                                makeToast("choose payment method");
                              }
                              else if(cubit.amountController.text==""){
                                makeToast("choose payment method");
                              }
                              else if(cubit.datePickedController.text==""){
                                makeToast("pick date");
                              }
                              else{
                                Navigator.pushReplacementNamed(context, Routes.catchReceiptRoute,arguments:
                                CatchReceiptModel(clientName: cubit.currentClient,
                                    amount: double.parse(cubit.amountController.text,),
                                    paymentMethod: cubit.selectedPaymentValue!,
                                    date: cubit.datePickedController.text,
                                    memo: cubit.memoController.text
                                ));
                                //cubit.clearFields();
                              }
                            }),
                        CustomButton(
                            backgroundColor: AppColors.primary,
                            textColor: AppColors.white,
                            text: "print".tr(),
                            onPressed: () {}),
                      ],
                    ),
                  )
                ],
              ),
            ),

          ],
        ),
      ),
    );
  },
);
  }

  void showClientsPopup(BuildContext context,List<ClientModel> clients) {
    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          shape:
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          backgroundColor: AppColors.blue2,
          child: BlocBuilder<CustomerPaymentsCubit, CustomerPaymentsState>(
            builder: (context, state) {
              CustomerPaymentsCubit cubit =
              context.read<CustomerPaymentsCubit>();
              return ListView(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  SizedBox(
                    height: 2.h,
                  ),
                  Center(
                      child: Text(
                        "client",
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.displayLarge,
                      ).tr()),
                  SizedBox(
                    height: 2.h,
                  ),
                  CustomTextField(
                      onchange: (value) {
                        cubit.searchForName(value);

                      },
                      title: "الاسم / الرقم",
                      textInputType: TextInputType.text,
                      backgroundColor: AppColors.primary,
                      textColor: AppColors.white),
                  Container(
                    alignment: Alignment.center,
                    width: 95.w,
                    height: 60.h,
                    margin: const EdgeInsets.all(15),
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: AppColors.primary),
                    child: ListView.separated(
                        itemBuilder: (context, index) {
                          return InkWell(
                            onTap: () {
                              cubit.matches.isEmpty
                                  ? cubit.selectClientName(clients[index].name)
                                  : cubit
                                  .selectClientName(cubit.matches[index].name);
                              cubit.matches.clear();
                              Navigator.pop(context);
                            },
                            child: Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment:
                                MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    cubit.matches.isEmpty
                                         ? clients[index].name
                                        : cubit.matches[index].name,
                                    style:
                                    Theme.of(context).textTheme.bodyMedium,
                                  ),
                                  Text(
                                    cubit.matches.isEmpty
                                        ? clients[index].phoneNumber
                                        : cubit.matches[index].phoneNumber,
                                    textDirection: TextDirection.ltr,
                                    style:
                                    Theme.of(context).textTheme.bodyMedium,
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                        separatorBuilder: (context, index) {
                          return Divider(
                            indent: 10,
                            endIndent: 10,
                            color: AppColors.white.withOpacity(0.7),
                            thickness: 1,
                          );
                        },
                        itemCount:
                        cubit.matches.isEmpty
                            ? clients.length
                            : cubit.matches.length,
                    ),
                  ),
                ],
              );
            },
          ),
        );
      },
    );
  }
}
