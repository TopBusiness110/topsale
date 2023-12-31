import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:topsale/config/routes/app_routes.dart';
import 'package:topsale/core/utils/app_colors.dart';
import 'package:topsale/features/my_account/components/custom_data_container.dart';

import '../../../core/utils/app_assets.dart';
import '../../../core/widgets/custom_arrow_back.dart';

class MyAccount extends StatelessWidget {
  const MyAccount({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: AppColors.primary,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 8.0),
                    child: IconButton(
                        onPressed: () {
                          Navigator.pushNamed(context, Routes.editAccountRoute);
                        },
                        icon: Image.asset(AssetsManager.editIcon,width: 25,)

                    ),
                  ),
                  Spacer(),
                  Text(
                    "my_account",
                    style: Theme
                        .of(context)
                        .textTheme
                        .displayLarge,
                  ).tr(),
                  const CustomArrowBack()
                ],
              ),
              SizedBox(height: 7.h,),
              Stack(
                children: [
                  Container(
                    margin: EdgeInsets.only(top: 50),
                    height: 70.h,
                    width: double.infinity,
                    clipBehavior: Clip.antiAlias,
                    decoration:const ShapeDecoration(
                      color: AppColors.lightBlue,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(topLeft:Radius.circular(64) ,topRight:Radius.circular(64) )
                      )
                    ),
                  child: Column(
                    children: [
                      SizedBox(height: 10.h,),
                      Text("مصطفى خليل",style: Theme.of(context).textTheme.displayMedium,),
                      const Spacer(),
                      // SizedBox(height: 10,),
                  const CustomDataContainer(label: "مصطفى خليل",icon: Icons.person,),
                      SizedBox(height: 3.h,),
                      const CustomDataContainer(label: "+201012535465 ",icon: Icons.phone,),
                      SizedBox(height: 3.h,),
                      const CustomDataContainer(label: " mostafa_khalil@gmail.com",icon: Icons.mail,),
                    const Spacer()

                    ],
                  ),
                  ),
                    const  Positioned(

                      right: 0,
                      left: 0,
                      child: CircleAvatar(
                        radius: 60,
                        backgroundColor: AppColors.primary,
                      )),
                       Positioned(
                    top: 5,
                      right: 0,
                      left: 0,
                        child: CircleAvatar(
                        radius: 54,
                       // backgroundColor: AppColors.white,
                       // backgroundImage: AssetImage(AssetsManager.aly,),
                        child:Image.asset(AssetsManager.aly) ,
                      ))
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
