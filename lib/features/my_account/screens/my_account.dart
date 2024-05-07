import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';
import 'package:topsale/config/routes/app_routes.dart';
import 'package:topsale/core/utils/app_colors.dart';
import 'package:topsale/core/utils/decode_image.dart';
import 'package:topsale/features/home/cubit/home_tab_cubit/home_cubit.dart';
import 'package:topsale/features/my_account/components/custom_data_container.dart';

import '../../../core/utils/app_assets.dart';
import '../../../core/widgets/custom_arrow_back.dart';

class MyAccount extends StatefulWidget {
  const MyAccount({super.key});

  @override
  State<MyAccount> createState() => _MyAccountState();
}

class _MyAccountState extends State<MyAccount> {
  @override
  Widget build(BuildContext context) {
    HomeCubit cubit = context.read<HomeCubit>();
    return Scaffold(
      backgroundColor: AppColors.primary,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Row(
                children: [
                  // Padding(
                  //   padding: const EdgeInsets.only(right: 8.0),
                  //   child: IconButton(
                  //       onPressed: () {
                  //         Navigator.pushNamed(context, Routes.editAccountRoute);
                  //       },
                  //       icon: Image.asset(
                  //         AssetsManager.editIcon,
                  //         width: 25,
                  //       )),
                  // ),
                  Spacer(),
                  Text(
                    "my_account",
                    style: Theme.of(context).textTheme.displayLarge,
                  ).tr(),
                  const CustomArrowBack()
                ],
              ),
              SizedBox(
                height: 7.h,
              ),
              Stack(
                children: [
                  Container(
                    margin: EdgeInsets.only(top: 50),
                    height: 70.h,
                    width: double.infinity,
                    clipBehavior: Clip.antiAlias,
                    decoration: const ShapeDecoration(
                        color: AppColors.lightBlue,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(64),
                                topRight: Radius.circular(64)))),
                    child: Column(
                      children: [
                        SizedBox(
                          height: 10.h,
                        ),
                        Text(
                          cubit.userName,
                          style: Theme.of(context).textTheme.displayMedium,
                        ),
                        const Spacer(),
                        // SizedBox(height: 10,),
                        CustomDataContainer(
                          label: cubit.userName,
                          icon: Icons.person,
                        ),
                        SizedBox(
                          height: 3.h,
                        ),
                        // CustomDataContainer(
                        //   label: "+201012535465 ",
                        //   // label: cubit.sharedUserData!.result!.,
                        //   icon: Icons.phone,
                        // ),
                        // SizedBox(
                        //   height: 3.h,
                        // ),
                        CustomDataContainer(
                          // label: cubit.sharedUserData!.result!.,
                          label: cubit.email,
                          icon: Icons.mail,
                        ),
                        const Spacer()
                      ],
                    ),
                  ),
                  const Positioned(
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
                        child: context
                                    .read<HomeCubit>()
                                    .profileImage
                                    .toString() ==
                                "false"
                            ? Image.asset('assets/images/splash.png',
                                fit: BoxFit.cover)
                            : ClipRRect(
                                borderRadius: BorderRadius.circular(100),
                                child: DecodedImage(
                                    base64String:
                                        context.read<HomeCubit>().profileImage,
                                    context: context),
                              ),
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
