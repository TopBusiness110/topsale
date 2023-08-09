import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sizer/sizer.dart';
import 'package:topsale/config/routes/app_routes.dart';
import 'package:topsale/core/widgets/custom_arrow_back.dart';
import 'package:topsale/core/widgets/custom_button.dart';
import 'package:topsale/core/widgets/custom_container.dart';
import 'package:topsale/core/widgets/custom_textfield.dart';

import '../../../core/utils/app_colors.dart';

class NewProduct extends StatelessWidget {
  const NewProduct({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: AppColors.primary,
      body: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              width: double.infinity,
              height: 78.h,
              decoration: const BoxDecoration(
                color: AppColors.lightBlue,
                borderRadius: BorderRadius.only(topLeft:Radius.circular(60) ,topRight:Radius.circular(60) )
              ),
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [

                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Text("add_new_product",style: Theme.of(context).textTheme.displayMedium,).tr(),
                      ),
                      Center(
                          child:CustomContainer(height: 20.h,width: 40.w,color: AppColors.primary,
                            child: Container(

                        margin:EdgeInsets.symmetric(horizontal:16.w,vertical: 17.w) ,
                        alignment: Alignment.center,

                        decoration: BoxDecoration(
                          color: AppColors.white,
                          borderRadius: BorderRadius.circular(10)
                        ),
                        child: InkWell(
                          onTap: () {

                          },
                            child: const Icon(
                              Icons.add,size: 23,)),
                      ),)),
                      const SizedBox(height: 10,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                       SvgPicture.asset("assets/icon/edit.svg",width: 30,),
                           Expanded(
                            child: SizedBox(
                              height: 50,
                              child: CustomTextField(
                                textColor: AppColors.white.withOpacity(0.5),
                                title: "product_name".tr(), textInputType: TextInputType.text,
                                  backgroundColor: AppColors.primary,
                              horizantalTape: 5,),
                            ),
                          )
                        ],
                      ),
                      const SizedBox(height: 10,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SvgPicture.asset("assets/icon/dollar.svg",width: 30,),
                           Expanded(
                            child: SizedBox(

                              height: 50,
                              child: CustomTextField(
                                  textColor: AppColors.white.withOpacity(0.5),
                                horizantalTape: 5,
                                  title: "price".tr(), textInputType: TextInputType.text,
                                  backgroundColor: AppColors.primary),
                            ),
                          )
                        ],
                      ),
                      const SizedBox(height: 10,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                         // SvgPicture.asset("assets/icon/edit.svg",width: 30,),
                          Image.asset("assets/icon/filter.png",width: 30,),
                           Expanded(
                            child: SizedBox(

                              height: 50,
                              child: CustomTextField(
                                  title: "department", textInputType: TextInputType.text,
                                  textColor: AppColors.white.withOpacity(0.5),
                                  backgroundColor: AppColors.primary,horizantalTape: 5),
                            ),
                          )
                        ],
                      ),
                      const SizedBox(height: 10,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding:  EdgeInsets.only(bottom: 12.h),
                            child: SvgPicture.asset("assets/icon/file.svg",width: 30,),
                          ),
                           Expanded(
                            child: CustomTextField(
                                textColor: AppColors.white.withOpacity(0.5),
                              horizantalTape: 5,
                              minLine: 7,
                                title: "description", textInputType: TextInputType.text,
                                backgroundColor: AppColors.primary),
                          )
                        ],
                      ),
                      const SizedBox(height: 10,),
                      CustomButton(
                        width: 20.w,
                        backgroundColor: AppColors.yellow, textColor: AppColors.white, text: "done".tr(), onPressed: () {
                      Navigator.pushNamed(context, Routes.productsRoute);
                      },),
                      SizedBox(height: 0.5.h,)
                    ],
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            left: 2.w,
              top: 5.h,
              child: CustomArrowBack())
        ],
      ),
    );
  }
}
