import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:sizer/sizer.dart';
import 'package:topsale/config/routes/app_routes.dart';
import 'package:topsale/core/utils/app_colors.dart';
import 'package:topsale/features/dismissal_notice/cubit/dismissal_notice_cubit.dart';

import '../../../core/methods/products.dart';
import '../../../core/widgets/custom_arrow_back.dart';
import '../../dismissal_notice_details/components/dismissal_notice_product_item.dart';

//اذن صرف
class DismissalNoticeScreen extends StatefulWidget {
  const DismissalNoticeScreen({super.key});

  @override
  State<DismissalNoticeScreen> createState() => _DismissalNoticeScreenState();
}

class _DismissalNoticeScreenState extends State<DismissalNoticeScreen> {
  @override
  void initState() {
    context.read<DismissalNoticeCubit>().getFromLocations();
    context.read<DismissalNoticeCubit>().getToLocations();
    context.read<DismissalNoticeCubit>().getAllProducts();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<DismissalNoticeCubit, DismissalNoticeState>(
      listener: (context, state) {
        if (state is SuccessCreateStockMoveState) {
          Navigator.pushNamed(context, Routes.dismissalNoticeDetailsRoute,
              arguments: context.read<DismissalNoticeCubit>().selectedProducts);
        }
        // TODO: implement listener
      },
      builder: (context, state) {
        DismissalNoticeCubit cubit = context.read<DismissalNoticeCubit>();
        return Scaffold(
          backgroundColor: AppColors.primary,
          body: SafeArea(
            child: Column(
              children: [
                Row(
                  children: [
                    Spacer(),
                    Text(
                      "dismissal_notice",
                      style: Theme.of(context).textTheme.displayLarge,
                    ).tr(),
                    const CustomArrowBack()
                  ],
                ),
                cubit.getFromLocationModel == null
                    ? Container()
                    : Container(
                        width: 90.w,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(
                                color: AppColors.white.withOpacity(0.5))),
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton2(
                            dropdownStyleData: const DropdownStyleData(
                                decoration: BoxDecoration(
                              color: AppColors.primary,
                            )),
                            value: cubit.selectedFromStockValue,
                            onChanged: (value) {
                              cubit.selectFromStock(value);
                            },
                            isExpanded: true,
                            hint: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text("from_stock".tr(),
                                    style: Theme.of(context)
                                        .textTheme
                                        .displayMedium!
                                        .copyWith(
                                            color: AppColors.white
                                                .withOpacity(0.5))),
                              ],
                            ),
                            items: cubit.getFromLocationModel!.result!
                                .map((item) => DropdownMenuItem<String>(
                                    value: item.id.toString(),
                                    child: Text(
                                      item.name!,
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
                const SizedBox(
                  height: 20,
                ),
                cubit.getToLocationModel == null
                    ? Container()
                    : Container(
                        width: 90.w,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(
                                color: AppColors.white.withOpacity(0.5))),
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton2(
                            dropdownStyleData: const DropdownStyleData(
                                decoration: BoxDecoration(
                              color: AppColors.primary,
                            )),
                            value: cubit.selectedToStockValue,
                            onChanged: (value) {
                              cubit.selectToStock(value);
                            },
                            isExpanded: true,
                            hint: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text("to_stock".tr(),
                                    style: Theme.of(context)
                                        .textTheme
                                        .displayMedium!
                                        .copyWith(
                                            color: AppColors.white
                                                .withOpacity(0.5))),
                              ],
                            ),
                            items: cubit.getToLocationModel!.result!
                                .map((item) => DropdownMenuItem<String>(
                                    value: item.id.toString(),
                                    child: Text(
                                      item.name!,
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
                const SizedBox(
                  height: 10,
                ),
                Text(
                  "products",
                  style: Theme.of(context).textTheme.displayLarge,
                ).tr(),
                const SizedBox(
                  height: 20,
                ),
                cubit.productsModel == null
                    ? CircularProgressIndicator(
                        color: AppColors.yellow,
                      )
                    : Expanded(
                        child: GridView.builder(
                        itemCount: cubit.productsModel!.result!.length,
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                mainAxisExtent: 230,
                                crossAxisSpacing: 10,
                                mainAxisSpacing: 20),
                        itemBuilder: (context, index) {
                          return DismissalNoticeProductItem(
                              product: cubit.productsModel!.result![index]);
                          //products[index],);
                        },
                      )),
                SizedBox(
                  height: 1.h,
                )
              ],
            ),
          ),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerFloat,
          floatingActionButton: SizedBox(
            width: 30.w,
            height: 5.h,
            child: FloatingActionButton(
              mini: false,
              backgroundColor: AppColors.yellow,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16)),
              child: Text(
                "confirm".tr(),
                style: Theme.of(context).textTheme.displayMedium,
              ),
              onPressed: () {
                if (cubit.selectedProducts.isNotEmpty &&
                    cubit.selectedToStockValue != null &&
                    cubit.selectedFromStockValue != null) {
                  cubit.createPicking();
                } else {
                  Fluttertoast.showToast(
                      msg: "من فضلك اختر المنتجات والمخزن",
                      toastLength: Toast.LENGTH_SHORT,
                      gravity: ToastGravity.BOTTOM,
                      timeInSecForIosWeb: 1,
                      backgroundColor: Colors.red,
                      textColor: Colors.white,
                      fontSize: 16.0);
                }

                //  cubit.createPicking();
              },
            ),
          ),
        );
      },
    );
  }
}
