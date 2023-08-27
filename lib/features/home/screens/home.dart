import 'package:easy_localization/easy_localization.dart' as easy;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sizer/sizer.dart';
import 'package:topsale/core/utils/app_assets.dart';
import 'package:topsale/features/home/cubit/home_tab_cubit/home_cubit.dart';

import '../../../core/utils/app_colors.dart';
import '../../../core/widgets/copy_right_widget.dart';
import '../../../core/widgets/custom_svg_images.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    String? lang = easy.EasyLocalization.of(context)!.locale.countryCode;
    return BlocConsumer<HomeCubit, HomeState>(
  listener: (context, state) {
    // TODO: implement listener
  },
  builder: (context, state) {
    HomeCubit cubit = context.read<HomeCubit>();
    return Scaffold(
      backgroundColor: AppColors.primary,

      body:cubit.tabs[cubit.currentIndex] ,
      bottomNavigationBar: Theme(
        data: Theme.of(context).copyWith(
           canvasColor: AppColors.blue2
        ),
        child: BottomNavigationBar(
          onTap: (value) {
            cubit.changeTabs(value);
          },
           currentIndex: cubit.currentIndex,
          showSelectedLabels: true,
          showUnselectedLabels: true,
          selectedItemColor: AppColors.yellow,
         selectedIconTheme: const IconThemeData(
           color: AppColors.yellow
         ),
         unselectedItemColor: AppColors.white,
          items: [
            BottomNavigationBarItem(
                icon:SvgPicture.asset(AssetsManager.homeIcon,width: 25,),label: "home".tr(),
              activeIcon: SvgPicture.asset(AssetsManager.homeIcon,color: AppColors.yellow,width: 25,)
            ),
            BottomNavigationBarItem(icon:SvgPicture.asset(AssetsManager.ordersIcon,width: 25,),
                activeIcon: SvgPicture.asset(AssetsManager.ordersIcon,color: AppColors.yellow,width: 25,),
                label: "expected_clients".tr()),
            BottomNavigationBarItem(icon:SvgPicture.asset(AssetsManager.itineraryIcon,width: 25,),
                activeIcon: SvgPicture.asset(AssetsManager.itineraryIcon,color: AppColors.yellow,width: 25,),
                label: "itinerary".tr()),
            BottomNavigationBarItem(
              icon:SvgPicture.asset(AssetsManager.moreIcon,width: 25,),
              activeIcon:SvgPicture.asset(AssetsManager.moreIcon,color: AppColors.yellow,width: 25,) ,
              label: "more".tr(),),

          ],
        ),
      ),

    );
  },
);
  }
}
