import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:screenshot/screenshot.dart';
import 'package:sizer/sizer.dart';
import 'package:topsale/features/dismissal_notice_details/cubit/dismissal_notice_details_cubit.dart';

import '../../../core/models/product_model.dart';
import '../../../core/utils/app_assets.dart';
import '../../../core/utils/app_colors.dart';
import '../../../core/widgets/custom_button.dart';

class DismissalNoticeDetailsScreen extends StatelessWidget {
  final  List<ProductModel>? products ;
  const DismissalNoticeDetailsScreen({super.key, this.products});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<DismissalNoticeDetailsCubit, DismissalNoticeDetailsState>(
  listener: (context, state) {
    // TODO: implement listener
  },
  builder: (context, state) {
    DismissalNoticeDetailsCubit cubit = context.read<DismissalNoticeDetailsCubit>();
    return Scaffold(
      backgroundColor: AppColors.primary,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(height: 10.h,),
          Center(
            child: Container(
              height: 83.h,
              width: 95.w,
              decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(topRight:Radius.circular(16) ,topLeft: Radius.circular(16)),
                  color: AppColors.white
              ),
              child: SingleChildScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                child: Column(
                  children: [
                    Screenshot(

                      controller: cubit.screenshotController,
                      child: Container(
                        decoration: const BoxDecoration(
                            borderRadius: BorderRadius.only(topRight:Radius.circular(16) ,topLeft: Radius.circular(16)),
                            color: AppColors.white
                        ),
                        child: Column(
                          children: [
                            Image.asset(
                              AssetsManager.splash,
                              width: 30.w,
                              height: 16.h,
                            ),
                            Text(
                              "dismissal_notice".tr(),
                              style: Theme.of(context)
                                  .textTheme
                                  .displayLarge!
                                  .copyWith(color: AppColors.primary),
                            ),
                            SizedBox(height: 3.h,),
                            Text(
                              " رقم اذن الصرف: Xs23oo9",
                              style: Theme.of(context)
                                  .textTheme
                                  .displayLarge!
                                  .copyWith(color: AppColors.primary),
                            ),

                            SizedBox(height: 1.h,),
                       //
                            Text(
                              "تاريخ اذن الصرف:${DateTime.now().toString().substring(0,16)}",
                              style: Theme.of(context)
                                  .textTheme
                                  .displayLarge!
                                  .copyWith(color: AppColors.primary),
                            ),
                            SizedBox(height: 1.h,),
                            //
                            // Text(
                            //   "بواسطة: TopBusiness",
                            //   style: Theme.of(context)
                            //       .textTheme
                            //       .bodyMedium!
                            //       .copyWith(color: AppColors.primary),
                            // ),
                            // SizedBox(height: 1.h,),

                            Padding(
                              padding:  EdgeInsets.symmetric(horizontal: 6.w),
                              child: Divider(),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [

                                Text(
                                  "اسم المنتج",
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyMedium!
                                      .copyWith(color: AppColors.primary),
                                ),
                                SizedBox(width: 30.w,),
                                Text(
                                  "كمية",
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyMedium!
                                      .copyWith(color: AppColors.primary),
                                ),
                                // SizedBox(width: 5.w,),
                                // Text(
                                //   "اجمالي",
                                //   style: Theme.of(context)
                                //       .textTheme
                                //       .bodyMedium!
                                //       .copyWith(color: AppColors.primary),
                                // ),

                              ],
                            ),
                           // const SizedBox(height: 10,),
                            //todo--> list of products
                            SizedBox(
                              height: 30.h,
                              child: products!.isNotEmpty?
                              ListView.separated(
                                  itemBuilder: (context, index) {
                                    return
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                      children: [

                                        Text(
                                          " ${products?[index].name}",
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyMedium!
                                              .copyWith(color: AppColors.primary),
                                        ),
                                        SizedBox(width: 30.w,),
                                        Text(
                                          "${products?[index].userOrderedQuantity}",
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyMedium!
                                              .copyWith(color: AppColors.primary),
                                        ),


                                      ],
                                    );
                                  },
                                  separatorBuilder: (context, index) {
                                    return    Padding(
                                      padding:  EdgeInsets.symmetric(horizontal: 6.w),
                                      child: Divider(),
                                    );
                                  },
                                  itemCount: products!.length):
                              SizedBox(),
                            ),



                            Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Text(
                                "www.topbusiness.io",
                                style: Theme.of(context)
                                    .textTheme
                                    .bodySmall!
                                    .copyWith(color: AppColors.primary),
                              ),
                            ),

                            SizedBox(
                              height: 7.h,
                              child: Image.asset(
                                "assets/icon/copy_rights_blue.png",
                                color: Colors.black,
                              ),
                            ),
                            // CustomButton(
                            //     backgroundColor: AppColors.yellow,
                            //     textColor: AppColors.white,
                            //     text: "print".tr(),
                            //     onPressed: () {
                            //     //  Navigator.pushReplacementNamed(context, Routes.receiptRoute);
                            //     }),

                          ],
                        ),
                      ),
                    ),
                    CustomButton(
                        backgroundColor: AppColors.yellow,
                        textColor: AppColors.white,
                        text: "print".tr(),
                        onPressed: () async {
                          await cubit.captureScreenshot();
                          //  Navigator.pushReplacementNamed(context, Routes.receiptRoute);
                        }),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  },
);
  }
}
