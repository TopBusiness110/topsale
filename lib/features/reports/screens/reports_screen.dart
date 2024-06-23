import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sizer/sizer.dart';
import 'package:topsale/config/routes/app_routes.dart';
import 'package:topsale/core/utils/app_colors.dart';
import 'package:topsale/core/widgets/custom_arrow_back.dart';
import 'package:topsale/features/%20receipt/screens/receipt_screen%20details.dart';
import 'package:topsale/features/reports/screens/report_screen.dart';
import 'package:topsale/features/sales_ordered_list/cubit/sales_ordered_list_cubit.dart';

class ReportsScreen extends StatefulWidget {
  const ReportsScreen({super.key});

  @override
  State<ReportsScreen> createState() => _ReportsScreenState();
}

class _ReportsScreenState extends State<ReportsScreen> {
  late final ScrollController scrollController = ScrollController();
  late final ScrollController scrollControllerPartner = ScrollController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    context.read<SalesOrderedListCubit>().getAllOrders();
    context.read<SalesOrderedListCubit>().getAllPartners();

    scrollController.addListener(_scrollListener);
    scrollControllerPartner.addListener(_scrollListenerPartner);
  }

  _scrollListener() {
    if (scrollController.position.maxScrollExtent == scrollController.offset) {
      print('dddddddddbottom');
      if (BlocProvider.of<SalesOrderedListCubit>(context).ordersModel!.next !=
          null) {
        BlocProvider.of<SalesOrderedListCubit>(context).getAllOrders(
            isGetMore: true,
            pageId: BlocProvider.of<SalesOrderedListCubit>(context)
                    .ordersModel!
                    .next ??
                1);
        debugPrint('new posts');
      }
    } else {
      print('dddddddddtop');
    }
  }

  _scrollListenerPartner() {
    if (scrollControllerPartner.position.maxScrollExtent ==
        scrollControllerPartner.offset) {
      print('dddddddddbottom');
      if (BlocProvider.of<SalesOrderedListCubit>(context).allUsersModel!.next !=
          null) {
        BlocProvider.of<SalesOrderedListCubit>(context).getAllPartners(
            isGetMore: true,
            pageId: BlocProvider.of<SalesOrderedListCubit>(context)
                    .allUsersModel!
                    .next ??
                1);
        debugPrint('new posts');
      }
    } else {
      print('dddddddddtop');
    }
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: AppColors.primary,
        body: SafeArea(
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
              Container(
                height: 50,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: AppColors.blue2),
                child: TabBar(
                  // indicator:
                  //
                  // BoxDecoration(
                  //   color: AppColors.lightBlue,
                  //   borderRadius: BorderRadius.circular(10),
                  // ),
                  labelColor: Colors.orange,
                  dividerColor: Colors.yellow,
                  tabs: [
                    Tab(
                      child: Text(
                        "sales".tr(),
                        style: Theme.of(context).textTheme.displayMedium,
                      ),
                    ),
                    Tab(
                      child: Text(
                        "clients".tr(),
                        style: Theme.of(context).textTheme.displayMedium,
                      ),
                    ),
                    // Tab(
                    //   child: Text(
                    //     "reports".tr(),
                    //     style: Theme.of(context).textTheme.displayMedium,
                    //   ),
                    // ),
                  ],
                ),
              ),
              BlocConsumer<SalesOrderedListCubit, SalesOrderedListState>(
                  listener: (context, state) {
                // TODO: implement listener
              }, builder: (context, state) {
                SalesOrderedListCubit cubit =
                    context.read<SalesOrderedListCubit>();
                return Expanded(
                    child: TabBarView(
                  children: [
                    Container(
                      // width: 70.w,
                      //  height: double.infinity,
                      decoration: BoxDecoration(
                          color: AppColors.primary,
                          borderRadius: BorderRadius.circular(20)),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 10.0, horizontal: 18),
                        child: Column(
                          children: [
                            cubit.ordersModel == null
                                //  ||
                                //         cubit.allUsersModel == null ||
                                //         cubit.matches.isEmpty
                                ? Expanded(
                                    child: Center(
                                      child: CircularProgressIndicator(
                                          color: AppColors.yellow),
                                    ),
                                  )
                                : Expanded(
                                    child: ListView.builder(
                                    controller: scrollController,
                                    itemCount:
                                        cubit.ordersModel?.result!.length,
                                    itemBuilder: (context, index) {
                                      return Padding(
                                        padding: const EdgeInsets.all(4.0),
                                        child: Stack(
                                          children: [
                                            GestureDetector(
                                              onTap: () {
                                                Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (context) =>
                                                          ReceiptScreenDetails(
                                                        index: index,
                                                      ),
                                                    ));
                                                cubit.getOrderDetails(cubit
                                                    .ordersModel
                                                    ?.result![index]
                                                    .id,
                                                    cubit
                                                    .ordersModel
                                                    ?.result![index].displayName
                                                    );
                                                cubit.getPartnerName(cubit
                                                    .ordersModel
                                                    ?.result![index]
                                                    .partnerId);

                                                // Navigator.pushNamed(context,
                                                //     Routes.reportRoute);
                                                // cubit.getOrderDetails(cubit
                                                //     .ordersModel
                                                //     ?.result![index]
                                                //     .id);
                                                // cubit.getPartnerDetails(cubit
                                                //     .ordersModel
                                                //     ?.result![index]
                                                //     .partnerId);
                                              },
                                              child: Container(
                                                margin:
                                                    EdgeInsets.only(top: 20),
                                                width: 97.w,
                                                // height: 17.h,
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 10.0,
                                                        vertical: 20),
                                                decoration: BoxDecoration(
                                                    color: AppColors.primary,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            15),
                                                    border: Border.all(
                                                        color: AppColors.blue2,
                                                        width: 2)),
                                                child: Column(
                                                  children: [
                                                    SizedBox(
                                                      height: 4.h,
                                                    ),
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .start,
                                                      children: [
                                                        SvgPicture.asset(
                                                            "assets/icon/bill.svg",
                                                            width: 20),
                                                        const SizedBox(
                                                          width: 15,
                                                        ),
                                                        Text(
                                                          //"uytgggh",
                                                          cubit
                                                                  .ordersModel
                                                                  ?.result![
                                                                      index]
                                                                  .displayName ??
                                                              "",
                                                          style:
                                                              Theme.of(context)
                                                                  .textTheme
                                                                  .bodySmall,
                                                        ),
                                                      ],
                                                    ),
                                                    // Row(
                                                    //   mainAxisAlignment:
                                                    //       MainAxisAlignment
                                                    //           .start,
                                                    //   children: [
                                                    //     SvgPicture.asset(
                                                    //         "assets/icon/name.svg",
                                                    //         width: 20),
                                                    //     SizedBox(
                                                    //       width: 10,
                                                    //     ),
                                                    //     InkWell(
                                                    //       onTap: () {
                                                    //         print(
                                                    //             "id : ${cubit.ordersModel?.result![index].partnerId}");

                                                    //         print(
                                                    //             "name :${cubit.matches[index].id}");
                                                    //         print(
                                                    //             "name :${cubit.matches[index].name}");
                                                    //       },
                                                    //       child: Text(
                                                    //         // cubit.matches
                                                    //         //         .where((element) =>
                                                    //         //             (element.id ==
                                                    //         //                 cubit
                                                    //         //                     .ordersModel
                                                    //         //                     ?.result![index]
                                                    //         //                     .partnerId))
                                                    //         //         .first
                                                    //         //         .name ??
                                                    //         "",
                                                    //         style: Theme.of(
                                                    //                 context)
                                                    //             .textTheme
                                                    //             .bodySmall,
                                                    //       ),
                                                    //     ),
                                                    //     SizedBox(
                                                    //       width: 8.w,
                                                    //     ),
                                                    //   ],
                                                    // ),
                                                    const SizedBox(
                                                      height: 15,
                                                    ),
                                                    Row(
                                                      children: [
                                                        SvgPicture.asset(
                                                            "assets/icon/date.svg",
                                                            width: 20),
                                                        SizedBox(
                                                          width: 10,
                                                        ),
                                                        Text(
                                                          "${cubit.ordersModel?.result![index].writeDate.toString().substring(0, 16)}",
                                                          //cubit.expectedClients?[index]?.address??"",
                                                          style:
                                                              Theme.of(context)
                                                                  .textTheme
                                                                  .bodySmall,
                                                        ),
                                                        SizedBox(
                                                          width: 30.w,
                                                        ),
                                                        Text(
                                                          "الاجمالي : ${cubit.ordersModel?.result![index]!.amountTotal} ",
                                                          //cubit.expectedClients?[index]?.address??"",
                                                          style:
                                                              Theme.of(context)
                                                                  .textTheme
                                                                  .bodySmall,
                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                            Positioned(
                                                right: 5.w,
                                                // top: -10,
                                                child: Container(
                                                  alignment: Alignment.center,
                                                  width: 27.w,
                                                  height: 5.h,
                                                  decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              20),
                                                      color:
                                                          AppColors.lightBlue),
                                                  child: Text(cubit
                                                          .ordersModel
                                                          ?.result![index]
                                                          .state ??
                                                      ''),
                                                ))
                                          ],
                                        ),
                                      );
                                    },
                                  ))
                          ],
                        ),
                      ),
                    ),
                    Container(
                      // width: 70.w,
                      // height: double.infinity,
                      decoration: BoxDecoration(
                          color: AppColors.primary,
                          borderRadius: BorderRadius.circular(20)),
                      child: Column(
                        children: [
                          cubit.allUsersModel == null
                              //  ||
                              //         cubit.allUsersModel == null ||
                              //         cubit.matches.isEmpty
                              ? Expanded(
                                  child: Center(
                                    child: CircularProgressIndicator(
                                        color: AppColors.yellow),
                                  ),
                                )
                              : Expanded(
                                  child: ListView.builder(
                                  controller: scrollControllerPartner,
                                  itemCount:
                                      cubit.allUsersModel?.result!.length,
                                  itemBuilder: (context, index) {
                                    return Padding(
                                      padding: const EdgeInsets.all(4.0),
                                      child: GestureDetector(
                                        onTap: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    ReportScreen(
                                                        lentgh: cubit
                                                                .allUsersModel
                                                                ?.result![index]
                                                                .saleOrderIds!
                                                                .length ??
                                                            0),
                                              ));
                                          cubit.getOrderDetailsForReports(cubit
                                              .allUsersModel
                                              ?.result![index]
                                              .saleOrderIds!);
                                          // cubit.getPartnerDetails(cubit
                                          //     .allUsersModel
                                          //     ?.result![index]
                                          //     .partnerId);
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
                                                          "اسم العميل",
                                                          style: TextStyle(
                                                              color: AppColors
                                                                  .yellow),
                                                        ),
                                                        Text(
                                                          //  "fgdsjhdskfhjdskhffgdsjhdskfhjdskhffgdsjhdskfhjdskhffgdsjhdskfhjdskhffgdsjhdskfhjdskhffgdsjhdskfhjdskhf",

                                                          cubit
                                                                  .allUsersModel
                                                                  ?.result![
                                                                      index]
                                                                  .name ??
                                                              "",
                                                          style:
                                                              Theme.of(context)
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
                                                        "رقم التليفون",
                                                        style: TextStyle(
                                                            color: AppColors
                                                                .yellow),
                                                      ),
                                                      Text(
                                                        //   "fgdsjhdskfhjdskhffgdsjhdskfhjdskhffgdsjhdskfhjdskhffgdsjhdskfhjdskhffgdsjhdskfhjdskhffgdsjhdskfhjdskhf",

                                                        cubit
                                                                    .allUsersModel
                                                                    ?.result![
                                                                        index]
                                                                    .phone
                                                                    .toString() ==
                                                                "false"
                                                            ? " لا يوجد"
                                                            : cubit
                                                                .allUsersModel
                                                                ?.result![index]
                                                                .phone,
                                                        style: Theme.of(context)
                                                            .textTheme
                                                            .bodySmall,
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                              Padding(
                                                padding: EdgeInsets.symmetric(
                                                    vertical: 6,
                                                    horizontal: 20),
                                                child: Divider(),
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
                                                          "المستحقات",
                                                          style: TextStyle(
                                                              color: AppColors
                                                                  .yellow),
                                                        ),
                                                        Text(
                                                          //  "fgdsjhdskfhjdskhffgdsjhdskfhjdskhffgdsjhdskfhjdskhffgdsjhdskfhjdskhffgdsjhdskfhjdskhffgdsjhdskfhjdskhf",

                                                          cubit
                                                                  .allUsersModel
                                                                  ?.result![
                                                                      index]
                                                                  .totalDue
                                                                  .toString() ??
                                                              "",
                                                          style:
                                                              Theme.of(context)
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
                                                        "المبيعات",
                                                        style: TextStyle(
                                                            color: AppColors
                                                                .yellow),
                                                      ),
                                                      Text(
                                                        //   "fgdsjhdskfhjdskhffgdsjhdskfhjdskhffgdsjhdskfhjdskhffgdsjhdskfhjdskhffgdsjhdskfhjdskhffgdsjhdskfhjdskhf",

                                                        cubit
                                                                .allUsersModel
                                                                ?.result![index]
                                                                .creditToInvoice
                                                                .toString() ??
                                                            "",
                                                        style: Theme.of(context)
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
                                      ),
                                    );
                                  },
                                ))
                        ],
                      ),
                    ),
                    // Container(
                    //   // width: 70.w,
                    //   // height: double.infinity,
                    //   decoration: BoxDecoration(
                    //       color: AppColors.primary,
                    //       borderRadius: BorderRadius.circular(20)),
                    // ),
                  ],
                ));
              })
            ],
          ),
        ),
      ),
    );
  }
}
