import 'package:easy_localization/easy_localization.dart' as easy;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sizer/sizer.dart';
import 'package:topsale/core/utils/app_colors.dart';
import '../../../config/routes/app_routes.dart';
import '../../../core/models/selected_products.dart';
import '../../../core/widgets/custom_arrow_back.dart';
import '../cubit/sales_ordered_list_cubit.dart';

class SalesOrderedListScreen extends StatefulWidget {
  const SalesOrderedListScreen({super.key});

  @override
  State<SalesOrderedListScreen> createState() => _SalesOrderedListScreenState();
}

class _SalesOrderedListScreenState extends State<SalesOrderedListScreen> {
  late final ScrollController scrollController = ScrollController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    context.read<SalesOrderedListCubit>().getAllOrders();
    //context.read<SalesOrderedListCubit>().getAllUsers();
    scrollController.addListener(_scrollListener);
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

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SalesOrderedListCubit, SalesOrderedListState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        SalesOrderedListCubit cubit = context.read<SalesOrderedListCubit>();
        return Scaffold(
          floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
          floatingActionButton: CircleAvatar(
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
                Navigator.pushNamed(context, Routes.createSalesOrderRoute,
                    arguments: SelectedProducts([]));
                // Navigator.pushNamed(context, Routes.expectedClientsTabRoute);
              },
            ),
          ),
          backgroundColor: AppColors.primary,
          body: Column(
            children: [
              SizedBox(
                height: 5.h,
              ),
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 8.0),
                    child: Text(
                      "sales_ordered_list",
                      style: Theme.of(context).textTheme.displayLarge,
                    ).tr(),
                  ),
                  const Spacer(),
                  const CustomArrowBack()
                ],
              ),
              cubit.ordersModel == null
                  //  ||
                  //         cubit.allUsersModel == null ||
                  //         cubit.matches.isEmpty
                  ? Center(
                      child: CircularProgressIndicator(color: AppColors.yellow),
                    )
                  : Expanded(
                      child: ListView.builder(
                      controller: scrollController,
                      itemCount: cubit.ordersModel?.result!.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: Stack(
                            children: [
                              Container(
                                margin: EdgeInsets.only(top: 20),
                                width: 97.w,
                                height: 17.h,
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10.0, vertical: 20),
                                decoration: BoxDecoration(
                                    color: AppColors.primary,
                                    borderRadius: BorderRadius.circular(15),
                                    border: Border.all(
                                        color: AppColors.blue2, width: 2)),
                                child: Column(
                                  children: [
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        SvgPicture.asset("assets/icon/bill.svg",
                                            width: 20),
                                        const SizedBox(
                                          width: 15,
                                        ),
                                        Text(
                                          //"uytgggh",
                                          cubit.ordersModel?.result![index]
                                                  .displayName ??
                                              "",
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodySmall,
                                        ),
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        SvgPicture.asset("assets/icon/name.svg",
                                            width: 20),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        InkWell(
                                          onTap: () {
                                            print(
                                                "id : ${cubit.ordersModel?.result![index].partnerId}");

                                            print(
                                                "name :${cubit.matches[index].id}");
                                            print(
                                                "name :${cubit.matches[index].name}");
                                          },
                                          child: Text(
                                            // cubit.matches
                                            //         .where((element) =>
                                            //             (element.id ==
                                            //                 cubit
                                            //                     .ordersModel
                                            //                     ?.result![index]
                                            //                     .partnerId))
                                            //         .first
                                            //         .name ??
                                            "",
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodySmall,
                                          ),
                                        ),
                                        SizedBox(
                                          width: 8.w,
                                        ),
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 15,
                                    ),
                                    Row(
                                      children: [
                                        SvgPicture.asset("assets/icon/date.svg",
                                            width: 20),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        Text(
                                          "${cubit.ordersModel?.result![index].writeDate.toString().substring(0, 16)}",
                                          //cubit.expectedClients?[index]?.address??"",
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodySmall,
                                        ),
                                        SizedBox(
                                          width: 30.w,
                                        ),
                                        Text(
                                          "الاجمالي : ${cubit.ordersModel?.result![index]!.amountTotal} ",
                                          //cubit.expectedClients?[index]?.address??"",
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodySmall,
                                        ),
                                      ],
                                    ),
                                  ],
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
                                        borderRadius: BorderRadius.circular(20),
                                        color: AppColors.lightBlue),
                                    child: Text(cubit.ordersModel
                                            ?.result![index].state ??
                                        ''),
                                  ))
                            ],
                          ),
                        );
                      },
                    ))
            ],
          ),
        );
      },
    );
  }
}
