import 'package:easy_localization/easy_localization.dart' as easy;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';
import 'package:topsale/config/routes/app_routes.dart';
import 'package:topsale/core/models/client_model.dart';
import 'package:topsale/core/models/product_model.dart';
import 'package:topsale/core/utils/app_colors.dart';
import 'package:topsale/core/widgets/custom_button.dart';
import 'package:topsale/core/widgets/custom_textfield.dart';
import 'package:topsale/features/cart/cart_cubit.dart';
import 'package:topsale/features/create_sales_order/cubit/create_sales_order_cubit.dart';
import '../../../core/methods/clients.dart';
import '../../../core/models/selected_products.dart';
import '../../../core/widgets/custom_arrow_back.dart';

class CreateSalesOrder extends StatefulWidget {
  SelectedProducts? selectedProducts;

  CreateSalesOrder({super.key, this.selectedProducts});

  @override
  State<CreateSalesOrder> createState() => _CreateSalesOrderState();
}

class _CreateSalesOrderState extends State<CreateSalesOrder> {
  final formKey = GlobalKey<FormState>(debugLabel: "new_client");

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    context
        .read<CreateSalesOrderCubit>()
        .calculateTotalPrice(widget.selectedProducts!);
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CreateSalesOrderCubit, CreateSalesOrderState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        CreateSalesOrderCubit cubit = context.read<CreateSalesOrderCubit>();
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
                        "create_sales_order",
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
                      widget.selectedProducts!.products.isEmpty ||
                              widget.selectedProducts == null
                          // cubit.selectedProducts.isEmpty
                          ? const Spacer()
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
                                              onTap: () {},
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
                                                      //name & code
                                                      Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        children: [
                                                          Text(
                                                              // "${cubit.currentClient} - ${cubit.selectedProducts[index]} ",
                                                              "${widget.selectedProducts?.products[index].name}",
                                                              style: Theme.of(
                                                                      context)
                                                                  .textTheme
                                                                  .bodySmall),
                                                          SizedBox(
                                                            width: 6.w,
                                                          ),
                                                          Text(
                                                            "${widget.selectedProducts?.products[index].code}",
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
                                                      //price
                                                      Text(
                                                        "\$ ${widget.selectedProducts?.products[index].price}",
                                                        textDirection:
                                                            TextDirection.ltr,
                                                        // textAlign: TextAlign.start,
                                                        style: Theme.of(context)
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
                                                            //number
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
                                                            //add button
                                                            InkWell(
                                                              onTap: () {
                                                                cubit.addProduct(
                                                                    product: widget
                                                                            .selectedProducts!
                                                                            .products[
                                                                        index],
                                                                    context:
                                                                        context);
                                                                cubit.calculateTotalPrice(
                                                                    widget
                                                                        .selectedProducts!);
                                                              },
                                                              child:
                                                                  const CircleAvatar(
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
                                                            //userOrderedQuantity
                                                            Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                          .all(
                                                                      12.0),
                                                              child: Text(
                                                                "${widget.selectedProducts?.products[index].userOrderedQuantity}",
                                                              ),
                                                            ),
                                                            //remove button
                                                            InkWell(
                                                              onTap: () {
                                                                cubit.removeProduct(
                                                                    product: widget
                                                                            .selectedProducts!
                                                                            .products[
                                                                        index],
                                                                    products: widget
                                                                        .selectedProducts
                                                                        ?.products,
                                                                    context:
                                                                        context);
                                                                cubit.calculateTotalPrice(
                                                                    widget
                                                                        .selectedProducts!);
                                                              },
                                                              child:
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
                                                                .circular(16)),
                                                    child: Image.asset(
                                                      widget
                                                          .selectedProducts!
                                                          .products[index]
                                                          .image!,
                                                      fit: BoxFit.cover,
                                                    ),
                                                  ),
                                                ],
                                              ),
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
                                              //cubit.selectedProducts.length
                                              widget.selectedProducts!.products
                                                  .length,
                                        ),
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
              //price
              Positioned(
                bottom: 7.h,
                left: 10,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 8.0, horizontal: 20),
                      child: Text(
                        "الاجمالي: ${cubit.sum} USD",
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                    ),
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  CustomButton(
                    backgroundColor: AppColors.yellow,
                    //  width: 35.w,
                    textColor: AppColors.white,
                    onPressed: () {
                      if (cubit.currentClient == "") {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Text("elect_client_name".tr()),
                          backgroundColor: AppColors.red,
                          duration: Duration(milliseconds: 1000),
                        ));
                      } else {
                        // showProductsPopup(context);
                        Navigator.pushReplacementNamed(
                            context, Routes.productsRoute);
                      }
                    },
                    text: "add_product+",
                  ),
                  CustomButton(
                    backgroundColor: AppColors.lightBlue,
                    textColor: AppColors.white,
                    onPressed: () {
                      if(widget.selectedProducts!.products.isEmpty){
                        ScaffoldMessenger.of(context)
                            .showSnackBar(const SnackBar(
                          content: Text(" من فضلك اضف منتجات"),
                          backgroundColor: AppColors.red,
                          duration: Duration(milliseconds: 1000),
                        ));
                      }
                      if(cubit.currentClient==""){
                        ScaffoldMessenger.of(context)
                            .showSnackBar(const SnackBar(
                          content: Text(" من فضلك اضف عميل"),
                          backgroundColor: AppColors.red,
                          duration: Duration(milliseconds: 1000),
                        ));
                      }
                      if (widget.selectedProducts!.products.isNotEmpty&&cubit.currentClient!="") {
                        showAlertDialog(context);
                      } else {
                        // ScaffoldMessenger.of(context)
                        //     .showSnackBar(const SnackBar(
                        //   content: Text(" من فضلك اضف منتجات"),
                        //   backgroundColor: AppColors.red,
                        //   duration: Duration(milliseconds: 1000),
                        // ));
                      }
                    },
                    text: "confirm",
                  )
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  void showAlertDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return BlocConsumer<CreateSalesOrderCubit, CreateSalesOrderState>(
          listener: (context, state) {
            // TODO: implement listener
          },
          builder: (context, state) {
            CreateSalesOrderCubit cubit = context.read<CreateSalesOrderCubit>();
            return AlertDialog(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20)),
              backgroundColor: AppColors.white,
              actionsAlignment: MainAxisAlignment.spaceBetween,
              title: Center(
                child: Text(
                  "confirm_sales_order".tr(),
                  style: Theme.of(context).textTheme.displayLarge!.copyWith(
                        color: AppColors.lightBlue,
                      ),
                ),
              ),
              content: Text(
                "sure_about_sales_order".tr(),
                style: Theme.of(context)
                    .textTheme
                    .displayMedium!
                    .copyWith(color: AppColors.lightBlue, fontSize: 14),
              ),
              actions: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                    Navigator.pushNamed(context, Routes.paymentRoute,
                        arguments: cubit.sum);
                    //save client name and its products
                    print("++++++++++++++++++++++++++++++++++++++++++++++");
                    print(widget.selectedProducts?.products);
                    context.read<CartCubit>().addClients(cubit.currentClient,widget.selectedProducts!.products );
                  },
                  style: ElevatedButton.styleFrom(
                    minimumSize: Size(28.w, 5.h),
                    maximumSize: Size(30.w, 5.h),
                    backgroundColor: AppColors.lightBlue,
                  ),
                  child: Text(
                    "yes".tr(),
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                    minimumSize: Size(28.w, 5.h),
                    maximumSize: Size(30.w, 5.h),
                  ),
                  child: Text(
                    "no".tr(),
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ),
              ],
            );
          },
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
                                      ? cubit
                                          .selectClientName(clients[index].name)
                                      : cubit.selectClientName(
                                          cubit.matches[index].name);
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
                                        state is SearchingResultsState
                                            ? cubit.matches[index].name
                                            :
                                            // cubit.matches.isEmpty ?
                                            clients[index].name,
                                        //  : cubit.matches[index].name,
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyMedium,
                                      ),
                                      Text(
                                        //cubit.matches.isEmpty?
                                        state is SearchingResultsState
                                            ? cubit.matches[index].phoneNumber
                                            : clients[index].phoneNumber,
                                        //:cubit.matches[index].phoneNumber,
                                        textDirection: TextDirection.ltr,
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyMedium,
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
