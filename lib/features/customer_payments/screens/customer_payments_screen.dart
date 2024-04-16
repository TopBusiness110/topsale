import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:easy_localization/easy_localization.dart' as easy;

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
//import 'package:intl/intl.dart'as intl;
import 'package:sizer/sizer.dart';
import 'package:topsale/core/models/allusers_model.dart';
import 'package:topsale/features/create_sales_order/cubit/create_sales_order_cubit.dart';
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

class CustomerPaymentsScreen extends StatefulWidget {
  const CustomerPaymentsScreen({super.key});

  @override
  State<CustomerPaymentsScreen> createState() => _CustomerPaymentsScreenState();
}

class _CustomerPaymentsScreenState extends State<CustomerPaymentsScreen> {
    GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  void initState() {
    context.read<CustomerPaymentsCubit>().getAllJournals();
    context.read<CreateSalesOrderCubit>().getAllUsers();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CustomerPaymentsCubit, CustomerPaymentsState>(
      listener: (context, state) {
        if (state is SuccessUpdatePaymentState) {
          Navigator.pushReplacementNamed(context, Routes.catchReceiptRoute,
              arguments: CatchReceiptModel(
                  clientName:
                      context.read<CreateSalesOrderCubit>().currentClient,
                  amount: double.parse(
                    context.read<CustomerPaymentsCubit>().amountController.text,
                  ),
                  paymentMethod:
                      context.read<CustomerPaymentsCubit>().selectedValue!,
                  date: context
                      .read<CustomerPaymentsCubit>()
                      .datePickedController
                      .text,
                  memo: context
                      .read<CustomerPaymentsCubit>()
                      .memoController
                      .text));
        }

        // TODO: implement listener
      },
      builder: (context, state) {
        CustomerPaymentsCubit cubit = context.read<CustomerPaymentsCubit>();
        CreateSalesOrderCubit clientCubit =
            context.read<CreateSalesOrderCubit>();
        return Scaffold(
          resizeToAvoidBottomInset: false,
          backgroundColor: AppColors.primary,
          body: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  height: 5.h,
                ),
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
                SizedBox(
                  height: 20.h,
                ),
                Container(
                  width: double.infinity,
                  height: 65.h,
                  decoration: const BoxDecoration(
                      color: AppColors.blue2,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(64),
                          topRight: Radius.circular(64))),
                  child: Column(
                    children: [
                      SizedBox(
                        height: 3.h,
                      ),
                      BlocBuilder<CreateSalesOrderCubit, CreateSalesOrderState>(
                          builder: (context, state) {
                        return InkWell(
                          onTap: () {
                            showClientsPopup(context, clientCubit.matches);
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
                              clientCubit.currentClient == ""
                                  ? "client".tr()
                                  : clientCubit.currentClient,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium!
                                  .copyWith(
                                    color: AppColors.white.withOpacity(0.3),
                                  ),
                            ),
                          ),
                        );
                      }),
                      SizedBox(
                        height: 3.h,
                      ),
                      cubit.allJournalsModel == null
                          ? Container()
                          : Container(
                              width: 80.w,
                              decoration: BoxDecoration(
                                  color: cubit.isSelected
                                      ? AppColors.primary
                                      : AppColors.blue2,
                                  borderRadius: BorderRadius.circular(16),
                                  border: Border.all(
                                      color: AppColors.white, width: 2)),
                              child: DropdownButtonHideUnderline(
                                child: DropdownButton2(
                                  dropdownStyleData: const DropdownStyleData(
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
                                                  color: AppColors.primary)),
                                    ],
                                  ),
                                  items: cubit.allJournalsModel!.result!
                                      .map((item) => DropdownMenuItem<String>(
                                          value: item.id.toString(),
                                          child: Text(
                                            item.displayName!,
                                            style: Theme.of(context)
                                                .textTheme
                                                .displayMedium!
                                                .copyWith(
                                                  color: AppColors.white,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                ),
                                          )))
                                      .toList(),
                                ),
                              ),
                            ),
                      //drop down button
                      // Container(
                      //   width: 80.w,
                      //   decoration: BoxDecoration(
                      //       color: cubit.isSelected
                      //           ? AppColors.primary
                      //           : AppColors.blue2,
                      //       borderRadius: BorderRadius.circular(16),
                      //       border:
                      //           Border.all(color: AppColors.white, width: 2)),
                      //   child: DropdownButtonHideUnderline(
                      //     child: DropdownButton2(
                      //       dropdownStyleData: const DropdownStyleData(
                      //           decoration: BoxDecoration(
                      //         color: AppColors.primary,
                      //       )),
                      //       value: cubit.selectedPaymentValue,
                      //       onChanged: (value) {
                      //         cubit.selectPaymentMethod(value);
                      //       },
                      //       isExpanded: true,
                      //       hint: Row(
                      //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      //         children: [
                      //           Text("payment_method".tr(),
                      //               style: Theme.of(context)
                      //                   .textTheme
                      //                   .displayMedium!
                      //                   .copyWith(color: AppColors.primary)),
                      //         ],
                      //       ),
                      //       items: cubit.items
                      //           .map((item) => DropdownMenuItem<String>(
                      //               value: item,
                      //               child: Text(
                      //                 item,
                      //                 style: Theme.of(context)
                      //                     .textTheme
                      //                     .displayMedium!
                      //                     .copyWith(
                      //                       color: AppColors.white,
                      //                       overflow: TextOverflow.ellipsis,
                      //                     ),
                      //               )))
                      //           .toList(),
                      //     ),
                      //   ),
                      // ),
                      SizedBox(
                        height: 3.h,
                      ),
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

                      SizedBox(
                        height: 3.h,
                      ),
                      SizedBox(
                        width: 90.w,
                        child: CustomTextField(
                          title: 'memo'.tr(),
                          controller: cubit.memoController,
                          textColor: AppColors.white.withOpacity(0.3),
                          textInputType: TextInputType.text,
                          backgroundColor: AppColors.primary,
                          minLine: 1,
                          isPassword: false,
                        ),
                      ),

                      SizedBox(
                        height: 3.h,
                      ),
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
                          onTap: () async {
                            DateTime? pickedDate = await showDatePicker(
                                context: context,
                                initialDate: DateTime.now(),
                                firstDate: DateTime.now(),
                                lastDate: DateTime(2050));

                            String? formattedDate =
                                easy.DateFormat("yyyy-MM-dd")
                                    .format(pickedDate!);
                            cubit.datePickedController.text = formattedDate;

                            print(formattedDate);
                          },
                        ),
                      ),

                      SizedBox(
                        height: 3.h,
                      ),
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
                                  if (cubit.selectedValue == null &&
                                      cubit.amountController.text.isEmpty &&
                                      cubit.datePickedController.text.isEmpty &&
                                      cubit.memoController.text.isEmpty &&
                                      clientCubit.currentClient == "") {
                                    makeToast("ادخل جميل البيانات");
                                  } else {
                                    cubit.createPaymentMethod(
                                        partnerId: clientCubit.currentClientId);
                                  }

                                  // if (cubit.currentClient == "") {
                                  //   makeToast("choose client");
                                  // } else if (cubit.selectedValue == null) {
                                  //   makeToast("choose payment method");
                                  // } else if (cubit.amountController.text ==
                                  //     "") {
                                  //   makeToast("choose payment method");
                                  // } else if (cubit.datePickedController.text ==
                                  //     "") {
                                  //   makeToast("pick date");
                                  // } else {

                                  //   //cubit.clearFields();
                                  // }
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

  // void showClientsPopup(BuildContext context, List<ClientModel> clients) {
  //   showDialog(
  //     context: context,
  //     builder: (context) {
  //       return Dialog(
  //         shape:
  //             RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
  //         backgroundColor: AppColors.blue2,
  //         child: BlocBuilder<CustomerPaymentsCubit, CustomerPaymentsState>(
  //           builder: (context, state) {
  //             CustomerPaymentsCubit cubit =
  //                 context.read<CustomerPaymentsCubit>();
  //             return ListView(
  //               physics: const NeverScrollableScrollPhysics(),
  //               shrinkWrap: true,
  //               // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
  //               children: [
  //                 SizedBox(
  //                   height: 2.h,
  //                 ),
  //                 Center(
  //                     child: Text(
  //                   "client",
  //                   textAlign: TextAlign.center,
  //                   style: Theme.of(context).textTheme.displayLarge,
  //                 ).tr()),
  //                 SizedBox(
  //                   height: 2.h,
  //                 ),
  //                 CustomTextField(
  //                     onchange: (value) {
  //                       cubit.searchForName(value);
  //                     },
  //                     title: "الاسم / الرقم",
  //                     textInputType: TextInputType.text,
  //                     backgroundColor: AppColors.primary,
  //                     textColor: AppColors.white),
  //                 Container(
  //                   alignment: Alignment.center,
  //                   width: 95.w,
  //                   height: 60.h,
  //                   margin: const EdgeInsets.all(15),
  //                   padding: const EdgeInsets.all(8),
  //                   decoration: BoxDecoration(
  //                       borderRadius: BorderRadius.circular(10),
  //                       color: AppColors.primary),
  //                   child: ListView.separated(
  //                     itemBuilder: (context, index) {
  //                       return InkWell(
  //                         onTap: () {
  //                           cubit.matches.isEmpty
  //                               ? cubit.selectClientName(clients[index].name)
  //                               : cubit.selectClientName(
  //                                   cubit.matches[index].name!);
  //                           cubit.matches.clear();
  //                           Navigator.pop(context);
  //                         },
  //                         child: Padding(
  //                           padding: EdgeInsets.all(8.0),
  //                           child: Row(
  //                             mainAxisSize: MainAxisSize.min,
  //                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //                             children: [
  //                               Text(
  //                                 cubit.matches.isEmpty
  //                                     ? clients[index].name
  //                                     : cubit.matches[index].name,
  //                                 style: Theme.of(context).textTheme.bodyMedium,
  //                               ),
  //                               Text(
  //                                 cubit.matches.isEmpty
  //                                     ? clients[index].phoneNumber
  //                                     : cubit.matches[index].phoneNumber,
  //                                 textDirection: TextDirection.ltr,
  //                                 style: Theme.of(context).textTheme.bodyMedium,
  //                               ),
  //                             ],
  //                           ),
  //                         ),
  //                       );
  //                     },
  //                     separatorBuilder: (context, index) {
  //                       return Divider(
  //                         indent: 10,
  //                         endIndent: 10,
  //                         color: AppColors.white.withOpacity(0.7),
  //                         thickness: 1,
  //                       );
  //                     },
  //                     itemCount: cubit.matches.isEmpty
  //                         ? clients.length
  //                         : cubit.matches.length,
  //                   ),
  //                 ),
  //               ],
  //             );
  //           },
  //         ),
  //       );
  //     },
  //   );
  // }
  void showClientsPopup(BuildContext context, List<UsersList> clients) {
    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          backgroundColor: AppColors.blue2,
          child: BlocBuilder<CreateSalesOrderCubit, CreateSalesOrderState>(
            builder: (context, state) {
              CreateSalesOrderCubit cubit =
                  context.read<CreateSalesOrderCubit>();
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
                    child: state is NoClientsMatchesState
                        ? SizedBox(
                            height: 50,
                            width: 50,
                            child: IconButton(
                              style: IconButton.styleFrom(
                                  backgroundColor: AppColors.yellow,
                                  shape: CircleBorder()),
                              onPressed: () {
                                showNewClientPopUp(context);
                              },
                              icon: const Icon(
                                Icons.add,
                                color: AppColors.primary,
                                size: 30,
                              ),
                            ),
                          )
                        : ListView.separated(
                            itemBuilder: (context, index) {
                              //when we clicked on client
                              return InkWell(
                                onTap: () {
                                  cubit.matches.isEmpty
                                      ? cubit.selectClientName(
                                          clients[index].name!,
                                          clients[index].id!)
                                      : cubit.selectClientName(
                                          cubit.matches[index].name!,
                                          cubit.matches[index].id!);
                                  // cubit.matches.clear();
                                  Navigator.pop(context);
                                },
                                child: Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Flexible(
                                        child: Text(
                                          //   state is SearchingResultsState
                                          //    ?
                                          cubit.matches[index].name!
                                          //   :
                                          // cubit.matches.isEmpty ?
                                          //    cubit.clients[index].name!,
                                          //  : cubit.matches[index].name
                                          ,
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyMedium,
                                        ),
                                      ),
                                      Flexible(
                                        child: Text(
                                          //cubit.matches.isEmpty?
                                          //  state is SearchingResultsState
                                          //      ?
                                          cubit.matches[index].phone!.toString()
                                          //   : cubit.clients[index].phone!
                                          ,
                                          //:cubit.matches[index].phoneNumber,
                                          textDirection: TextDirection.ltr,
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyMedium,
                                        ),
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
                            itemCount: cubit.matches.isEmpty
                                ? clients.length
                                : cubit.matches.length),
                  ),

                  CircleAvatar(
                    radius: 25,
                    backgroundColor: AppColors.yellow,
                    child: FloatingActionButton(
                      mini: true,
                      backgroundColor: AppColors.white,
                      shape: CircleBorder(),
                      child: Icon(
                        Icons.add,
                        color: AppColors.lightBlue,
                        size: 27,
                      ),
                      onPressed: () {
                        Navigator.pushNamed(
                            context, Routes.expectedClientsTabRoute);
                      },
                    ),
                  ),
                  SizedBox(
                    height: 2.h,
                  ),
                  // SizedBox(
                  //   height: 50,
                  //   width: 50,
                  //   child: IconButton(
                  //     style: IconButton.styleFrom(
                  //       backgroundColor: AppColors.yellow,
                  //       shape: CircleBorder()
                  //     ),
                  //     onPressed: () {
                  //       showNewClientPopUp(context);
                  //     }, icon: Icon(Icons.add,color: AppColors.primary,size: 30,),),
                  // ),
                ],
              );
            },
          ),
        );
      },
    );
  }

  void showNewClientPopUp(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          backgroundColor: AppColors.blue2,
          child: BlocBuilder<CreateSalesOrderCubit, CreateSalesOrderState>(
            builder: (context, state) {
              CreateSalesOrderCubit cubit =
                  context.read<CreateSalesOrderCubit>();
              return Form(
                key: formKey,
                child: ListView(
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    SizedBox(
                      height: 2.h,
                    ),
                    Center(
                        child: Text(
                      "add_new_client".tr(),
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.displayLarge,
                    ).tr()),
                    SizedBox(
                      height: 2.h,
                    ),
                    CustomTextField(
                        validatorMessage: "Enter the client name",
                        controller: cubit.nameController,
                        title: "client_name".tr(),
                        textInputType: TextInputType.text,
                        backgroundColor: AppColors.primary,
                        textColor: AppColors.white),
                    SizedBox(
                      height: 2.h,
                    ),
                    CustomTextField(
                        validatorMessage: "Enter the client phone number",
                        controller: cubit.phoneController,
                        title: "phone_number".tr(),
                        textInputType: TextInputType.number,
                        backgroundColor: AppColors.primary,
                        textColor: AppColors.white),
                    SizedBox(
                      height: 2.h,
                    ),
                    CustomTextField(
                        controller: cubit.addressController,
                        validatorMessage: "Enter Address",
                        title: "address".tr(),
                        textInputType: TextInputType.text,
                        backgroundColor: AppColors.primary,
                        textColor: AppColors.white),
                    Container(
                      margin:
                          EdgeInsets.symmetric(horizontal: 27.w, vertical: 10),
                      padding: const EdgeInsets.symmetric(vertical: 20),
                      child: CustomButton(
                          backgroundColor: AppColors.yellow,
                          height: 30,
                          width: 30,
                          textColor: AppColors.white,
                          text: "add",
                          onPressed: () {
                            if (formKey.currentState!.validate()) {
                              cubit.addNewClient();
                              Navigator.pop(context);
                              cubit.addressController.clear();
                              cubit.phoneController.clear();
                              cubit.nameController.clear();
                            }

                            //add the new contact to the contacts list
                          }),
                    )
                  ],
                ),
              );
            },
          ),
        );
      },
    );
  }
}
