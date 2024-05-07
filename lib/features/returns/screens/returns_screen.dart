// ignore_for_file: unused_local_variable

import 'package:easy_localization/easy_localization.dart' as easy;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';
import 'package:topsale/config/routes/app_routes.dart';
import 'package:topsale/core/models/allusers_model.dart';
import 'package:topsale/core/utils/decode_image.dart';
import 'package:topsale/features/cart/cart_cubit.dart';
import 'package:topsale/features/create_sales_order/cubit/create_sales_order_cubit.dart';
import 'package:topsale/features/home/cubit/home_tab_cubit/home_cubit.dart';
import 'package:topsale/features/returns/cubit/returns_cubit.dart';
import 'package:topsale/features/returns/screens/returns_product_screen.dart';
import '../../../core/methods/clients.dart';
import '../../../core/methods/products.dart';
import '../../../core/models/client_model.dart';
import '../../../core/utils/app_colors.dart';
import '../../../core/widgets/custom_arrow_back.dart';
import '../../../core/widgets/custom_button.dart';
import '../../../core/widgets/custom_textfield.dart';

class ReturnsScreen extends StatefulWidget {
  const ReturnsScreen({super.key});

  @override
  State<ReturnsScreen> createState() => _ReturnsScreenState();
}

class _ReturnsScreenState extends State<ReturnsScreen> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  late final ScrollController scrollController = ScrollController();

  @override
  void initState() {
    // context.read<CustomerPaymentsCubit>().getAllJournals();
    context.read<CreateSalesOrderCubit>().getAllUsers();
    context.read<CreateSalesOrderCubit>().currentClient = '';
    context.read<ReturnsCubit>().getPartnerOrdersModel = null;
    scrollController.addListener(_scrollListener);

    super.initState();
  }

  _scrollListener() {
    if (scrollController.position.maxScrollExtent == scrollController.offset) {
      print('dddddddddbottom');
      if (BlocProvider.of<CreateSalesOrderCubit>(context).allUsersModel!.next !=
          null) {
        BlocProvider.of<CreateSalesOrderCubit>(context).getAllUsers(
            isGetMore: true,
            pageId: BlocProvider.of<CreateSalesOrderCubit>(context)
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
    return BlocConsumer<ReturnsCubit, ReturnsState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        ReturnsCubit cubit = context.read<ReturnsCubit>();
        CreateSalesOrderCubit clientCubit =
            context.read<CreateSalesOrderCubit>();
        return Scaffold(
          backgroundColor: AppColors.primary,
          body: Stack(
            alignment: Alignment.bottomCenter,
            children: [
              Positioned(
                  left: 2.w,
                  top: 5.h,
                  child: Row(
                    children: [
                      Text(
                        "create_return_order",
                        style: Theme.of(context).textTheme.displayLarge,
                      ).tr(),
                      const CustomArrowBack(),
                    ],
                  )),
              Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  width: double.infinity,
                  height: 75.h,
                  decoration: const BoxDecoration(
                      color: AppColors.blue2,
                      borderRadius: BorderRadius.only(
                          topRight: Radius.circular(60),
                          topLeft: Radius.circular(60))),
                  child: Column(
                    children: [
                      SizedBox(
                        height: 5.h,
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
                                  Border.all(color: AppColors.white, width: 1),
                              borderRadius: BorderRadius.circular(16),
                            ),
                            child: Text(
                              //"client".tr(),
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
                      Text(
                        "الطلبات",
                        style: Theme.of(context).textTheme.displayLarge,
                      ).tr(),
                      cubit.getPartnerOrdersModel == null
                          ? Container()
                          : Expanded(
                              child: Container(
                                  alignment: Alignment.center,
                                  width: 95.w,
                                  //height: 60.h,
                                  margin: EdgeInsets.all(2.w),
                                  //padding: const EdgeInsets.all(8),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: AppColors.blue2),
                                  child: Column(
                                    children: [
                                      Expanded(
                                        child: ListView.separated(
                                            itemBuilder: (context, index) {
                                              return InkWell(
                                                onTap: () {
                                                  Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (context) =>
                                                          ReturnsDetailsScreen(
                                                        orderId: cubit
                                                            .getPartnerOrdersModel!
                                                            .result![index]
                                                            .id!,
                                                      ),
                                                    ),
                                                  );
                                                },
                                                child: Container(
                                                  alignment:
                                                      Alignment.centerRight,
                                                  margin: EdgeInsets.all(12),
                                                  padding: EdgeInsets.all(8),
                                                  decoration: BoxDecoration(
                                                      color: AppColors.blue2,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              20)),
                                                  child: Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Text(
                                                        "${cubit.getPartnerOrdersModel!.result![index].displayName ?? ''}",
                                                        style: Theme.of(context)
                                                            .textTheme
                                                            .bodyMedium,
                                                      ),
                                                      SizedBox(
                                                        height: 10,
                                                      ),
                                                      Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        children: [
                                                          Text(
                                                            "${cubit.getPartnerOrdersModel!.result![index].amountTotal ?? ''}",
                                                            style: Theme.of(
                                                                    context)
                                                                .textTheme
                                                                .bodyMedium!
                                                                .copyWith(
                                                                    color: AppColors
                                                                        .yellow),
                                                          ),
                                                          Text(
                                                            "${cubit.getPartnerOrdersModel!.result![index].writeDate ?? ''}",
                                                            style: Theme.of(
                                                                    context)
                                                                .textTheme
                                                                .bodyMedium!
                                                                .copyWith(
                                                                    color: AppColors
                                                                        .yellow),
                                                          ),
                                                        ],
                                                      ),
                                                      const SizedBox(
                                                        height: 10,
                                                      ),
                                                      // Row(
                                                      //   children: [
                                                      //     InkWell(
                                                      //       onTap: () {
                                                      //         launch(
                                                      //             "tel://${shipments[index].clientPhoneNumber}");
                                                      //       },
                                                      //       child: const CircleAvatar(
                                                      //         radius: 15,
                                                      //         backgroundColor: AppColors.yellow,
                                                      //         child: Icon(
                                                      //           Icons.call,
                                                      //           color: AppColors.white,
                                                      //           size: 20,
                                                      //         ),
                                                      //       ),
                                                      //     ),
                                                      //     const SizedBox(
                                                      //       width: 20,
                                                      //     ),
                                                      //     InkWell(
                                                      //       onTap: () {
                                                      //         Navigator.pushNamed(
                                                      //             context, Routes.googleMapRoute,
                                                      //             arguments: LatLng(
                                                      //                 shipments[index].clientLat!,
                                                      //                 shipments[index].clientLng!));
                                                      //       },
                                                      //       child: const CircleAvatar(
                                                      //         radius: 15,
                                                      //         backgroundColor: AppColors.lightBlue,
                                                      //         child: Icon(
                                                      //           Icons.location_on_outlined,
                                                      //           color: AppColors.white,
                                                      //           size: 20,
                                                      //         ),
                                                      //       ),
                                                      //     ),
                                                      //   ],
                                                      // ),
                                                      const SizedBox(
                                                        height: 10,
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              );

                                              //  Row(children: [
                                              //   IconButton(
                                              //     onPressed: () {
                                              //       cubit.removeProduct(index);
                                              //     },
                                              //     icon: Icon(
                                              //       Icons.delete_forever_outlined,
                                              //       color: AppColors.red,
                                              //     ),
                                              //   ),
                                              //   Expanded(
                                              //     child: Row(
                                              //       mainAxisAlignment:
                                              //           MainAxisAlignment
                                              //               .spaceBetween,
                                              //       children: [
                                              //         Column(
                                              //           crossAxisAlignment:
                                              //               CrossAxisAlignment.start,
                                              //           mainAxisSize:
                                              //               MainAxisSize.min,
                                              //           children: [
                                              //             Row(
                                              //               mainAxisAlignment:
                                              //                   MainAxisAlignment
                                              //                       .spaceBetween,
                                              //               children: [
                                              //                 Text(
                                              //                     //"${cubit.currentClient} - ${cubit.selectedProducts[index]} ",
                                              //                     "${cubit.listOfProducts[index].name}",
                                              //                     style: Theme.of(
                                              //                             context)
                                              //                         .textTheme
                                              //                         .bodySmall),
                                              //                 SizedBox(
                                              //                   width: 6.w,
                                              //                 ),
                                              //                 Text(
                                              //                   "${cubit.listOfProducts[index].name}",
                                              //                   style: Theme.of(
                                              //                           context)
                                              //                       .textTheme
                                              //                       .bodySmall!
                                              //                       .copyWith(
                                              //                           fontSize: 10,
                                              //                           color: AppColors
                                              //                               .white
                                              //                               .withOpacity(
                                              //                                   0.5)),
                                              //                 ),
                                              //               ],
                                              //             ),
                                              //             SizedBox(
                                              //               height: 1.h,
                                              //             ),
                                              //             Text(
                                              //               "${cubit.listOfProducts[index].listPrice} ${context.read<HomeCubit>().currencyName}",
                                              //               textDirection:
                                              //                   TextDirection.ltr,
                                              //               // textAlign: TextAlign.start,
                                              //               style: Theme.of(context)
                                              //                   .textTheme
                                              //                   .bodySmall!
                                              //                   .copyWith(
                                              //                       fontSize: 10,
                                              //                       color: AppColors
                                              //                           .white
                                              //                           .withOpacity(
                                              //                               0.5)),
                                              //             ),
                                              //             SizedBox(
                                              //               height: 1.h,
                                              //             ),
                                              //             Padding(
                                              //               padding: EdgeInsets.only(
                                              //                   right: 5.w),
                                              //               child: Row(
                                              //                 mainAxisAlignment:
                                              //                     MainAxisAlignment
                                              //                         .center,
                                              //                 crossAxisAlignment:
                                              //                     CrossAxisAlignment
                                              //                         .center,
                                              //                 children: [
                                              //                   Text(
                                              //                     "number",
                                              //                     style: Theme.of(
                                              //                             context)
                                              //                         .textTheme
                                              //                         .bodySmall,
                                              //                   ).tr(),
                                              //                   SizedBox(
                                              //                     width: 1.h,
                                              //                   ),
                                              //                   InkWell(
                                              //                     onTap: () {
                                              //                       //todo-->
                                              //                       cubit
                                              //                           .addProductQuantity(
                                              //                               index);
                                              //                       //cubit.listOfProducts[index].userOrderedQuantity++;
                                              //                     },
                                              //                     child:
                                              //                         const CircleAvatar(
                                              //                       radius: 12,
                                              //                       backgroundColor:
                                              //                           AppColors
                                              //                               .lightBlue,
                                              //                       child: Icon(
                                              //                         Icons.add,
                                              //                         size: 13,
                                              //                         color: AppColors
                                              //                             .white,
                                              //                       ),
                                              //                     ),
                                              //                   ),
                                              //                   Padding(
                                              //                     padding:
                                              //                         const EdgeInsets
                                              //                             .all(12.0),
                                              //                     child: Text(
                                              //                         "${cubit.listOfProducts[index].userOrderedQuantity}"),
                                              //                   ),
                                              //                   InkWell(
                                              //                     onTap: () {
                                              //                       cubit
                                              //                           .decreaseProductQuantity(
                                              //                               index);
                                              //                     },
                                              //                     child:
                                              //                         const CircleAvatar(
                                              //                       radius: 12,
                                              //                       backgroundColor:
                                              //                           AppColors
                                              //                               .lightBlue,
                                              //                       child: Icon(
                                              //                         Icons.remove,
                                              //                         size: 13,
                                              //                         color: AppColors
                                              //                             .white,
                                              //                       ),
                                              //                     ),
                                              //                   )
                                              //                 ],
                                              //               ),
                                              //             ),
                                              //           ],
                                              //         ),
                                              //         Container(
                                              //             width: 20.w,
                                              //             height: 10.h,
                                              //             decoration: BoxDecoration(
                                              //                 color:
                                              //                     AppColors.primary,
                                              //                 borderRadius:
                                              //                     BorderRadius
                                              //                         .circular(16)),
                                              //             child: DecodedImage(
                                              //                 base64String: cubit
                                              //                     .listOfProducts[
                                              //                         index]
                                              //                     .image1920!,
                                              //                 context: context)),
                                              //       ],
                                              //     ),
                                              //   ),
                                              // ]);
                                            },
                                            separatorBuilder: (context, index) {
                                              return Divider(
                                                indent: 10,
                                                endIndent: 10,
                                                color: AppColors.white
                                                    .withOpacity(0.7),
                                                thickness: 1,
                                              );
                                            },
                                            itemCount: cubit
                                                .getPartnerOrdersModel!
                                                .result!
                                                .length),
                                      ),
                                      SizedBox(
                                        height: 10.h,
                                      ),
                                    ],
                                  )),
                            ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

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
                            controller: scrollController,
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
                                  context.read<ReturnsCubit>().getPartnerOrders(
                                      cubit.matches[index].id!);
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

  void showProductsPopup(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          backgroundColor: AppColors.blue2,
          child: BlocBuilder<ReturnsCubit, ReturnsState>(
            builder: (context, state) {
              ReturnsCubit cubit = context.read<ReturnsCubit>();
              return ListView(
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  SizedBox(
                    height: 2.h,
                  ),
                  Center(
                      child: Text(
                    "product",
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.displayLarge,
                  ).tr()),
                  SizedBox(
                    height: 2.h,
                  ),
                  const CustomTextField(
                      title: "اسم المنتج / الباركود",
                      textInputType: TextInputType.text,
                      backgroundColor: AppColors.primary,
                      textColor: AppColors.white),
                  Container(
                      alignment: Alignment.center,
                      width: 95.w,
                      height: 60.h,
                      margin: const EdgeInsets.all(15),
                      //padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: AppColors.primary),
                      child: ListView.separated(
                          itemBuilder: (context, index) {
                            return InkWell(
                              onTap: () {
                                //cubit.addProducts(products[index]);

                                Navigator.pop(context);
                              },
                              child: Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Column(
                                  //  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      //  mainAxisSize: MainAxisSize.min,

                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          "pppppp",
                                          // cubit.products[index],
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyMedium,
                                        ),
                                        Text(
                                            "650.55 ${context.read<HomeCubit>().currencyName}",
                                            textDirection: TextDirection.ltr,
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyMedium),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Text(
                                          '[D-RSL2568]',
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodySmall!
                                              .copyWith(
                                                  color: AppColors.white
                                                      .withOpacity(0.5)),
                                        )
                                      ],
                                    )
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
                          itemCount: products.length)),
                ],
              );
            },
          ),
        );
      },
    );
  }
}
