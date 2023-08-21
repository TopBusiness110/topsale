import 'package:easy_localization/easy_localization.dart'as easy;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';
import 'package:topsale/features/cart/cart_cubit.dart';
import 'package:topsale/features/returns/cubit/returns_cubit.dart';

import '../../../core/methods/clients.dart';
import '../../../core/methods/products.dart';
import '../../../core/methods/products.dart';
import '../../../core/methods/products.dart';
import '../../../core/models/client_model.dart';
import '../../../core/utils/app_colors.dart';
import '../../../core/widgets/custom_arrow_back.dart';
import '../../../core/widgets/custom_button.dart';
import '../../../core/widgets/custom_textfield.dart';

class ReturnsScreen extends StatelessWidget {
  const ReturnsScreen({super.key});

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
                        Border.all(color: AppColors.white, width: 1),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Text(
                        //"client".tr(),
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
                  SizedBox(
                    height: 3.h,
                  ),
                  Text(
                    "products",
                    style: Theme.of(context).textTheme.displayLarge,
                  ).tr(),

                  state is ClientCartFounded || state is AddedState || state is ProductRemoved?
                    //  cubit.listOfProducts.isNotEmpty?
                      Expanded(
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
                                    return Row(

                                      children:[
                                        IconButton(
                                          onPressed: () {
                                         cubit.removeProduct(index);
                                          },
                                          icon:Icon(Icons.delete_forever_outlined,color: AppColors.red,) ,
                                          ),

                                        Expanded(
                                          child: Row(
                                          mainAxisAlignment:
                                          MainAxisAlignment
                                              .spaceBetween,
                                          children: [
                                            Column(
                                              crossAxisAlignment:
                                              CrossAxisAlignment
                                                  .start,
                                              mainAxisSize:
                                              MainAxisSize.min,
                                              children: [
                                                Row(
                                                  mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                                  children: [
                                                    Text(
                                                        //"${cubit.currentClient} - ${cubit.selectedProducts[index]} ",
                                                      "${cubit.listOfProducts[index].name}",
                                                        style: Theme.of(
                                                            context)
                                                            .textTheme
                                                            .bodySmall),
                                                    SizedBox(
                                                      width: 6.w,
                                                    ),
                                                    Text(
                                                      "${cubit.listOfProducts[index].code}",
                                                      style: Theme.of(
                                                          context)
                                                          .textTheme
                                                          .bodySmall!
                                                          .copyWith(
                                                          fontSize:
                                                          10,
                                                          color: AppColors
                                                              .white
                                                              .withOpacity(
                                                              0.5)),
                                                    ),
                                                  ],
                                                ),
                                                SizedBox(
                                                  height: 1.h,
                                                ),
                                                Text(
                                                  "${cubit.listOfProducts[index].price} USD",
                                                  textDirection:
                                                  TextDirection.ltr,
                                                  // textAlign: TextAlign.start,
                                                  style: Theme.of(
                                                      context)
                                                      .textTheme
                                                      .bodySmall!
                                                      .copyWith(
                                                      fontSize: 10,
                                                      color: AppColors
                                                          .white
                                                          .withOpacity(
                                                          0.5)),
                                                ),
                                                SizedBox(
                                                  height: 1.h,
                                                ),
                                                Padding(
                                                  padding:
                                                  EdgeInsets.only(
                                                      right: 5.w),
                                                  child: Row(
                                                    mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .center,
                                                    crossAxisAlignment:
                                                    CrossAxisAlignment
                                                        .center,
                                                    children: [
                                                      Text(
                                                        "number",
                                                        style: Theme.of(
                                                            context)
                                                            .textTheme
                                                            .bodySmall,
                                                      ).tr(),
                                                      SizedBox(
                                                        width: 1.h,
                                                      ),
                                                      InkWell(
                                                        onTap: () {
                                                          //todo-->
                                                          cubit.addProductQuantity(index);
                                                          //cubit.listOfProducts[index].userOrderedQuantity++;
                                                        },
                                                        child: const CircleAvatar(
                                                          radius: 12,
                                                          backgroundColor:
                                                          AppColors
                                                              .lightBlue,
                                                          child: Icon(
                                                            Icons.add,
                                                            size: 13,
                                                            color:
                                                            AppColors
                                                                .white,
                                                          ),
                                                        ),
                                                      ),
                                                       Padding(
                                                        padding:
                                                        const EdgeInsets
                                                            .all(
                                                            12.0),
                                                        child:
                                                        Text("${cubit.listOfProducts[index].userOrderedQuantity}"),
                                                      ),
                                                      const CircleAvatar(
                                                        radius: 12,
                                                        backgroundColor:
                                                        AppColors
                                                            .lightBlue,
                                                        child: Icon(
                                                          Icons.remove,
                                                          size: 13,
                                                          color:
                                                          AppColors
                                                              .white,
                                                        ),
                                                      )
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                            Container(
                                              width: 20.w,
                                              height: 10.h,
                                              decoration: BoxDecoration(
                                                  color:
                                                  AppColors.primary,
                                                  borderRadius:
                                                  BorderRadius
                                                      .circular(
                                                      16)),
                                              child: Image.asset(cubit.listOfProducts[index].image!,fit: BoxFit.cover,),
                                            ),
                                          ],
                                      ),
                                        ),

                                      ]
                                    );
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
                                  itemCount:
                                  cubit.listOfProducts.length

                              ),
                            ),
                            SizedBox(
                              height: 10.h,
                            ),
                          ],
                        )),
                  ):
                      const Spacer(),

                ],
              ),
            ),
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
               //  showProductsPopup(context);
                },
                text: "return".tr(),
              ),
            ),
          ),
        ],
      ),
    );
  },
);
  }

  void showClientsPopup(BuildContext context, List<ClientModel> clients) {
    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          shape:
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          backgroundColor: AppColors.blue2,
          child: BlocBuilder<ReturnsCubit, ReturnsState>(
            builder: (context, state) {
              ReturnsCubit cubit =
              context.read<ReturnsCubit>();
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
                        //  cubit.matches.clear();
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
                              //search about client products
                              cubit.searchForProductsForClient(cubit.currentClient, context.read<CartCubit>().cart);
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
                        itemCount: cubit.matches.isEmpty
                            ? clients.length
                            : cubit.matches.length),
                  ),
                ],
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
                            return
                              InkWell(
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
                                          Text("pppppp",
                                           // cubit.products[index],
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyMedium,
                                          ),
                                          Text("650.55 USD",
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
