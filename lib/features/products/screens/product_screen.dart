import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:topsale/config/routes/app_routes.dart';
import 'package:topsale/core/utils/app_assets.dart';
import 'package:topsale/core/widgets/custom_textfield.dart';

import '../../../core/utils/app_colors.dart';
import '../../../core/widgets/custom_arrow_back.dart';

class ProductsScreen extends StatelessWidget {
  const ProductsScreen({super.key});

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: AppColors.primary,
      body: SafeArea(
        child: Column(
          children: [
            Row(
              children: [
                // Padding(
                //   padding: const EdgeInsets.only(right: 8.0),
                //   child: IconButton(
                //       onPressed: () {},
                //       icon: Icon(
                //         Icons.menu,
                //         color: AppColors.white,
                //       )),
                // ),
                Spacer(),
                Text(
                  "products",
                  style: Theme.of(context).textTheme.displayLarge,
                ).tr(),
                CustomArrowBack()
              ],
            ),
            CustomTextField(
              textColor: AppColors.white.withOpacity(0.5),
              borderSide: BorderSide(color: AppColors.lightBlue, width: 2),
              title: "search".tr(),
              textInputType: TextInputType.text,
              backgroundColor: AppColors.primary,
            ),
            const SizedBox(
              height: 10,
            ),
            Expanded(
                child: GridView.builder(
              padding: EdgeInsets.symmetric(horizontal: 15),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisExtent: 230,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 20),
              itemBuilder: (context, index) {
                return Container(
                  decoration: BoxDecoration(
                      color: AppColors.lightBlue,
                      borderRadius: BorderRadius.circular(18)),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        decoration: BoxDecoration(shape: BoxShape.rectangle),
                        margin: EdgeInsets.all(8),
                        child: Image.asset(ImageAssets.mobile,fit: BoxFit.cover,),


                      ),
                      Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 8.0),
                            child: Text("حامل هاتف معدني",
                                textAlign: TextAlign.start,
                                style: Theme.of(context).textTheme.bodySmall),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Text(
                            '[D-RSL2568]',
                            style: Theme.of(context)
                                .textTheme
                                .bodySmall!
                                .copyWith(fontSize: 10),
                          ),
                          Text('355.76 USD',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodySmall!
                                  .copyWith(fontSize: 10)),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            CircleAvatar(
                              radius: 10,
                              backgroundColor: AppColors.primary,
                              child: IconButton(
                                padding: EdgeInsets.zero,
                                onPressed: () {},
                                icon: Icon(
                                  Icons.add,
                                  color: AppColors.yellow,
                                  size: 15,
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 8.0),
                              child: Text("0"),
                            ),
                            CircleAvatar(
                              radius: 10,
                              backgroundColor: AppColors.primary,
                              child: IconButton(
                                padding: EdgeInsets.zero,
                                onPressed: () {},
                                icon: const Icon(
                                  Icons.remove,
                                  color: AppColors.yellow,
                                  size: 15,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
            )),
          ],
        ),

      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
      floatingActionButton: CircleAvatar(
        radius: 25,
        backgroundColor: AppColors.yellow,
        child: FloatingActionButton(
          mini: true,
          backgroundColor: AppColors.white,
          shape: CircleBorder(),
          child: Icon(Icons.add,color: AppColors.lightBlue,size: 27,),
          onPressed: () {
          Navigator.pushNamed(context, Routes.newProductRoute);
        },),
      ),
    );
  }
}
