import 'package:easy_localization/easy_localization.dart' as easy;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:location/location.dart';
import 'package:sizer/sizer.dart';
import 'package:topsale/config/routes/app_routes.dart';
import 'package:topsale/core/widgets/custom_button.dart';
import 'package:topsale/features/returns/cubit/returns_cubit.dart';

import '../../../core/utils/app_colors.dart';
import '../../../core/widgets/custom_arrow_back.dart';

class ReturnsDetailsScreen extends StatefulWidget {
  const ReturnsDetailsScreen({super.key, required this.orderId});
  final int orderId;
  @override
  State<ReturnsDetailsScreen> createState() => _ReturnsDetailsScreenState();
}

class _ReturnsDetailsScreenState extends State<ReturnsDetailsScreen> {
  LocationData? currentLocation;
  @override
  void initState() {
    context.read<ReturnsCubit>().getPartnerOrderDetails(widget.orderId);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ReturnsCubit, ReturnsState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        ReturnsCubit cubit = context.read<ReturnsCubit>();
        return Scaffold(
          backgroundColor: AppColors.primary,
          body: Column(children: [
            SizedBox(
              height: 5.h,
            ),
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: Text(
                    "products",
                    style: Theme.of(context).textTheme.displayLarge,
                  ).tr(),
                ),
                const Spacer(),
                const CustomArrowBack()
              ],
            ),
            cubit.getManOrderDetailsModel == null
                ? Center(
                    child: CircularProgressIndicator(color: AppColors.yellow),
                  )
                : Expanded(
                    child: Container(
                      margin: EdgeInsets.all(12),
                      decoration: BoxDecoration(
                          color: AppColors.blue2,
                          borderRadius: BorderRadius.circular(19)),
                      child: ListView.separated(
                          itemBuilder: (context, index) {
                            //when we clicked on client
                            return InkWell(
                              onTap: () {},
                              child: Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Flexible(
                                          child: Text(
                                            "${cubit.getManOrderDetailsModel!.result![index].name ?? ''}",
                                            // "${widget.shipmentModel.clientName}",
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyMedium,
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              CircleAvatar(
                                                radius: 12,
                                                backgroundColor:
                                                    AppColors.primary,
                                                child: IconButton(
                                                  padding: EdgeInsets.zero,
                                                  onPressed: () {
                                                    setState(() {});

                                                    //  if (cubit
                                                    //          .getManOrderDetailsModel!
                                                    //          .result![index]
                                                    //          .productUomQty >
                                                    //      cubit
                                                    //          .getManOrderDetailsModel!
                                                    //          .result![index]
                                                    //          .userProductUomQty)
                                                    cubit
                                                        .getManOrderDetailsModel!
                                                        .result![index]
                                                        .userProductUomQty += 1;
                                                  },
                                                  icon: const Icon(
                                                    Icons.add,
                                                    color: AppColors.yellow,
                                                    size: 17,
                                                  ),
                                                ),
                                              ),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 8.0),
                                                child: Text(
                                                  "${cubit.getManOrderDetailsModel!.result![index].userProductUomQty}",
                                                  textDirection:
                                                      TextDirection.ltr,
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .bodySmall,
                                                ),
                                              ),
                                              CircleAvatar(
                                                radius: 12,
                                                backgroundColor:
                                                    AppColors.primary,
                                                child: IconButton(
                                                  padding: EdgeInsets.zero,
                                                  onPressed: () {
                                                    setState(() {});

                                                    if (cubit
                                                            .getManOrderDetailsModel!
                                                            .result![index]
                                                            .userProductUomQty >=
                                                        1)
                                                      cubit
                                                          .getManOrderDetailsModel!
                                                          .result![index]
                                                          .userProductUomQty -= 1;
                                                    //  cubit.removeProduct(product: product);
                                                  },
                                                  icon: const Icon(
                                                    Icons.remove,
                                                    color: AppColors.yellow,
                                                    size: 17,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
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
                              cubit.getManOrderDetailsModel!.result!.length),
                    ),
                  ),
            // SizedBox(height: 5,),
            SizedBox(
              height: 10,
            ),
            Align(
              alignment: Alignment.bottomRight,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: CustomButton(
                  backgroundColor: AppColors.yellow,
                  width: 37.w,
                  textColor: AppColors.white,
                  onPressed: () {
                    // cubit.createSaleOrder(
                    //   context,
                    // );
                    //  for (int i = 0;
                    //      i < cubit.getManOrderDetailsModel!.result!.length;
                    //      i++) {
                    cubit.createSaleOrder(
                      context,
                    );
                    // }
                    // Navigator.pushNamedAndRemoveUntil(
                    //     context, Routes.homeRoute, (route) => false);
                  },
                  text: "return".tr(),
                ),
              ),
            ),

            SizedBox(
              height: 10,
            ),
          ]),
        );
      },
    );
  }
}

// void showAlertDialog(BuildContext context) {
//   showDialog(
//     context: context,
//     builder: (context) {
//       return BlocConsumer<CreateSalesOrderCubit, CreateSalesOrderState>(
//         listener: (context, state) {
//           if (state is SuccessCreateSaleOrderState) {
//             // print("successdddd");
//             // showAlertDialog(context);
//           }
//         },
//         builder: (context, state) {
//           CreateSalesOrderCubit cubit = context.read<CreateSalesOrderCubit>();
//           ProductsCubit productCubit = context.read<ProductsCubit>();
//           return AlertDialog(
//             shape:
//                 RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
//             backgroundColor: AppColors.white,
//             actionsAlignment: MainAxisAlignment.spaceBetween,
//             title: Center(
//               child: Text(
//                 "confirm_sales_order".tr(),
//                 style: Theme.of(context).textTheme.displayLarge!.copyWith(
//                       color: AppColors.lightBlue,
//                     ),
//               ),
//             ),
//             content: Text(
//               "sure_about_sales_order".tr(),
//               style: Theme.of(context)
//                   .textTheme
//                   .displayMedium!
//                   .copyWith(color: AppColors.lightBlue, fontSize: 14),
//             ),
//             actions: [
//               Row(
//                 children: [
//                   BlocConsumer<CreateSalesOrderCubit, CreateSalesOrderState>(
//                       listener: (context, state) {
//                     if (state is SuccessCreateSaleOrderLineState) {
//                       print('sssss');
//                       Navigator.pop(context);
//                       context.read<ProductsCubit>().getAllProducts();
//                       //context.read<ProductsCubit>().selectedProducts.clear();

//                       Navigator.push(
//                           context,
//                           MaterialPageRoute(
//                             builder: (context) => PaymentScreen(
//                               sum: cubit.sum,
//                               partnerId: cubit.currentClientId,
//                               productId: productCubit.selectedProducts[0].id!,
//                               quantity: productCubit
//                                   .selectedProducts[0].userOrderedQuantity,
//                               onPressed: () {},
//                             ),
//                           ));
//                     }

//                     // if (state is SuccessCreateSaleOrderLineState) {
//                     //   Navigator.pushReplacementNamed(
//                     //       context, Routes.receiptRoute);
//                     // }
//                   }, builder: (context, state) {
//                     return ElevatedButton(
//                       onPressed: () {
//                         cubit.createSaleOrderLine(context,
//                             productId: productCubit.selectedProducts[0].id!,
//                             productQuantity: productCubit
//                                 .selectedProducts[0].userOrderedQuantity);

//                         print("++++++++++++++++++++++++++++++++++++++++++++++");
//                         print(widget.selectedProducts?.products);
//                         context.read<CartCubit>().addClients(
//                             cubit.currentClient,
//                             widget.selectedProducts!.products);
//                         context
//                             .read<SalesOrderedListCubit>()
//                             .fillSalesOrderedList(
//                                 creationDate: cubit.dateTime,
//                                 customer: cubit.currentClient,
//                                 number: cubit.billingNumber,
//                                 status: cubit.billingStatus,
//                                 total: cubit.sum);
//                       },
//                       style: ElevatedButton.styleFrom(
//                         minimumSize: Size(28.w, 5.h),
//                         maximumSize: Size(30.w, 5.h),
//                         backgroundColor: AppColors.lightBlue,
//                       ),
//                       child: Text(
//                         "yes".tr(),
//                         style: Theme.of(context).textTheme.bodyMedium,
//                       ),
//                     );
//                   }),
//                   SizedBox(
//                     width: 3.w,
//                   ),
//                   ElevatedButton(
//                     onPressed: () {
//                       Navigator.pop(context);
//                     },
//                     style: ElevatedButton.styleFrom(
//                       backgroundColor: Colors.red,
//                       minimumSize: Size(28.w, 5.h),
//                       maximumSize: Size(30.w, 5.h),
//                     ),
//                     child: Text(
//                       "no".tr(),
//                       style: Theme.of(context).textTheme.bodyMedium,
//                     ),
//                   ),
//                 ],
//               )
//             ],
//           );
//         },
//       );
//     },
//   );
// }
