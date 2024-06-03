import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';
import 'package:topsale/core/utils/app_colors.dart';
import 'package:topsale/core/widgets/custom_arrow_back.dart';
import 'package:topsale/features/%20receipt/screens/receipt_reborts.dart';
import 'package:topsale/features/%20receipt/screens/receipt_screen%20details.dart';
import 'package:topsale/features/home/cubit/home_tab_cubit/home_cubit.dart';
import 'package:topsale/features/sales_ordered_list/cubit/sales_ordered_list_cubit.dart';

class ReportScreen extends StatefulWidget {
  const ReportScreen({super.key, required this.lentgh});
  final int lentgh;
  @override
  State<ReportScreen> createState() => _ReportScreenState();
}

class _ReportScreenState extends State<ReportScreen> {
  @override
  Widget build(BuildContext context) {
    SalesOrderedListCubit cubit = context.read<SalesOrderedListCubit>();
    return Scaffold(
      backgroundColor: AppColors.primary,
      body: BlocBuilder<SalesOrderedListCubit, SalesOrderedListState>(
          builder: (context, state) {
        return SafeArea(
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 8.0),
                    child: Text(
                      "reports",
                      style: Theme.of(context).textTheme.displayLarge,
                    ).tr(),
                  ),
                  const Spacer(),
                  const CustomArrowBack()
                ],
              ),
              Expanded(
                  child: widget.lentgh == 0
                      ? Center(child: Text("لا يوجد فواتير"))
                      : widget.lentgh > cubit.ordersListForReports.length
                          ? Center(
                              child: CircularProgressIndicator(
                                  color: AppColors.yellow),
                            )
                          : Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 18.0),
                              child: Column(
                                children: [
                                  ListView.builder(
                                      shrinkWrap: true,
                                      physics: NeverScrollableScrollPhysics(),
                                      itemCount:
                                          cubit.ordersListForReports.length,
                                      itemBuilder: (context, index) {
                                        // double price = 0;
                                        // cubit
                                        //                           .ordersListForReports[
                                        //                               index]
                                        //                           .result!.forEach((element) {
                                                                    
                                        //                            price += element.   priceTotal
                                        //                             });

                                        return GestureDetector(
                                          onTap: () {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) =>
                                                      ReceiptScreenReports(
                                                    orderId: cubit
                                                        .ordersListForReports[
                                                            index]
                                                        .result![0]
                                                        .id
                                                        .toString(),
                                                    orderDate: cubit
                                                        .ordersListForReports[
                                                            index]
                                                        .result![0]
                                                        .date
                                                        .toString(),
                                                  ),
                                                ));
                                            cubit.getOrderDetails(
                                              cubit.ordersListForReports[index]
                                                  .result![0].id,
                                            );
                                            cubit.getPartnerName(cubit
                                                .ordersListForReports[index]
                                                .result![0]
                                                .partnerId);
                                          },
                                          child: Container(
                                            margin: EdgeInsets.only(top: 20),
                                            width: 97.w,
                                            // height: 17.h,
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 10.0, vertical: 20),
                                            decoration: BoxDecoration(
                                                color: AppColors.primary,
                                                borderRadius:
                                                    BorderRadius.circular(15),
                                                border: Border.all(
                                                    color: AppColors.blue2,
                                                    width: 2)),
                                            child: Column(
                                              children: [
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Flexible(
                                                      child: Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Text(
                                                            "الاسم",
                                                            style: TextStyle(
                                                                color: AppColors
                                                                    .yellow),
                                                          ),
                                                          Text(
                                                            cubit.getOrderName(cubit
                                                                    .ordersListForReports[
                                                                        index]
                                                                    .result![0]
                                                                    .displayName) ??
                                                                "",
                                                            style: Theme.of(
                                                                    context)
                                                                .textTheme
                                                                .bodySmall,
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                SizedBox(
                                                  height: 10,
                                                ),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Flexible(
                                                      child: Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Text(
                                                            "التاريخ",
                                                            style: TextStyle(
                                                                color: AppColors
                                                                    .yellow),
                                                          ),
                                                          Text(
                                                            //  "fgdsjhdskfhjdskhffgdsjhdskfhjdskhffgdsjhdskfhjdskhffgdsjhdskfhjdskhffgdsjhdskfhjdskhffgdsjhdskfhjdskhf",

                                                            cubit
                                                                    .ordersListForReports[
                                                                        index]
                                                                    .result![0]
                                                                    .date
                                                                    .toString() ??
                                                                "",
                                                            style: Theme.of(
                                                                    context)
                                                                .textTheme
                                                                .bodySmall,
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                    Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Text(
                                                          "الإجمالي",
                                                          style: TextStyle(
                                                              color: AppColors
                                                                  .yellow),
                                                        ),
                                                        Text(
                                                          //   "fgdsjhdskfhjdskhffgdsjhdskfhjdskhffgdsjhdskfhjdskhffgdsjhdskfhjdskhffgdsjhdskfhjdskhffgdsjhdskfhjdskhf",

                                                          cubit
                                                                  .ordersListForReports[
                                                                      index]
                                                                  .result![0]
                                                                  .priceTotal
                                                                  .toString() ??
                                                              "",
                                                          style:
                                                              Theme.of(context)
                                                                  .textTheme
                                                                  .bodySmall,
                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                                const SizedBox(
                                                  height: 5,
                                                ),
                                              ],
                                            ),
                                          ),
                                        );
                                      }),
                                ],
                              ),
                            ))
            ],
          ),
        );
      }),
    );
  }
}
