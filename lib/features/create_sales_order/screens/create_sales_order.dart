import 'package:easy_localization/easy_localization.dart' as easy;
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:topsale/core/utils/app_colors.dart';
import 'package:topsale/core/widgets/custom_button.dart';
import 'package:topsale/core/widgets/custom_container.dart';
import 'package:topsale/core/widgets/custom_textfield.dart';

import '../../../core/widgets/custom_arrow_back.dart';

class CreateSalesOrder extends StatelessWidget {
  const CreateSalesOrder({super.key});

  @override
  Widget build(BuildContext context) {
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
                      showClientsPopup(context);
                    },
                    child: Container(
                      width: 80.w,
                      height: 6.h,
                      padding: const EdgeInsets.all(15),
                      decoration: BoxDecoration(
                        border: Border.all(color: AppColors.white, width: 1),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Text(
                        "client".tr(),
                        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
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
                  Spacer(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 8.0, horizontal: 20),
                        child: Text(
                          "الاجمالي: 564.50 USD",
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      CustomButton(
                        backgroundColor: AppColors.yellow,
                        //  width: 35.w,
                        textColor: AppColors.white,
                        onPressed: () {
                          showProductsPopup(context);
                        },
                        text: "add_product+",
                      ),
                      CustomButton(
                        backgroundColor: AppColors.lightBlue,
                        textColor: AppColors.white,
                        onPressed: () {},
                        text: "confirm",
                      )
                    ],
                  ),
                  SizedBox(
                    height: 2.h,
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  void showClientsPopup(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          backgroundColor: AppColors.blue2,
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
                "client",
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.displayLarge,
              ).tr()),
              SizedBox(
                height: 2.h,
              ),
              const CustomTextField(
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
                            Navigator.pop(context);
                          },
                          child: Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "مصطفي خليل",
                                  style: Theme.of(context).textTheme.bodyMedium,
                                ),
                                Text(
                                  "+201012532144",
                                  textDirection: TextDirection.ltr,
                                  style: Theme.of(context).textTheme.bodyMedium,
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
                      itemCount: 20)),
            ],
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
                            showProductTypesPopup(context);
                            // Navigator.pushNamed(context, routeName);
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
                                      "حامل هاتف معدني",
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
                      itemCount: 20)),
            ],
          ),
        );
      },
    );
  }

  void showProductTypesPopup(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          backgroundColor: AppColors.blue2,
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
                "products",
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.displayLarge,
              ).tr()),
              SizedBox(
                height: 2.h,
              ),
              const CustomTextField(
                  title: "مصطفي خليل",
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
                      color: AppColors.blue2),
                  child: ListView.separated(
                      itemBuilder: (context, index) {
                        return InkWell(
                          onTap: () {},
                          child: Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text("حامل هاتف معدني",
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodySmall),
                                          SizedBox(
                                            width: 6.w,
                                          ),
                                          Text(
                                            "[D-RSL2568]",
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodySmall!
                                                .copyWith(
                                                    fontSize: 10,
                                                    color: AppColors.white
                                                        .withOpacity(0.5)),
                                          ),
                                        ],
                                      ),
                                      Text(
                                        "355.76 USD",
                                        textDirection: TextDirection.ltr,
                                        textAlign: TextAlign.start,
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodySmall!
                                            .copyWith(
                                                fontSize: 10,
                                                color: AppColors.white
                                                    .withOpacity(0.5)),
                                      ),
                                    ],
                                  ),
                                  Container(
                                    width: 20.w,
                                    height: 10.h,
                                    decoration: BoxDecoration(
                                        color: AppColors.primary,
                                        borderRadius:
                                            BorderRadius.circular(16)),
                                  ),
                                ],
                              )),
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
                      itemCount: 20)),
            ],
          ),
        );
      },
    );
  }
}
