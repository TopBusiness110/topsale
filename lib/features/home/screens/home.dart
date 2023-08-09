import 'package:easy_localization/easy_localization.dart' as easy;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sizer/sizer.dart';
import 'package:topsale/core/utils/app_assets.dart';
import 'package:topsale/features/home/cubit/home_cubit.dart';

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
      appBar: AppBar(
        // leading:   Padding(
        //   padding: EdgeInsets.only(bottom: 9.h),
        //   child: const Icon(Icons.menu,color: AppColors.white,),
        // ),
        title: Row(
         mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
           Row(
             mainAxisAlignment: MainAxisAlignment.center,
             children: [  Container(
               decoration: const BoxDecoration(
                 shape:BoxShape.circle,

               ),

               child:Image.asset(ImageAssets.profile),),
             const SizedBox(width: 5,),
             Text("اهلا, مصطفي خليل",style: Theme.of(context).textTheme.bodyMedium,),],),

            const SizedBox(width: 5,),
            Column(
              children: [
                Text("3265.25 EGP",style: Theme.of(context).textTheme.bodySmall,),
                const SizedBox(height: 10,),
                Text("الميزاينية الاساسية",style: Theme.of(context).textTheme.bodySmall,),
              ],
            ),


          ],
        ),
          // this property hide the back arrow
        automaticallyImplyLeading: false,
        toolbarHeight: MediaQuery.of(context).size.height / 6,
        backgroundColor: AppColors.lightBlue,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.horizontal(
              left: Radius.circular(50), right: Radius.circular(50)),
        ),
      ),
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
                icon:SvgPicture.asset(ImageAssets.homeIcon,width: 25,),label: "home".tr(),
              activeIcon: SvgPicture.asset(ImageAssets.homeIcon,color: AppColors.yellow,width: 25,)
            ),
            BottomNavigationBarItem(icon:SvgPicture.asset(ImageAssets.ordersIcon,width: 25,),
                activeIcon: SvgPicture.asset(ImageAssets.ordersIcon,color: AppColors.yellow,width: 25,),
                label: "delivery_orders".tr()),
            BottomNavigationBarItem(icon:SvgPicture.asset(ImageAssets.itineraryIcon,width: 25,),
                activeIcon: SvgPicture.asset(ImageAssets.itineraryIcon,color: AppColors.yellow,width: 25,),
                label: "itinerary".tr()),
            BottomNavigationBarItem(
              icon:SvgPicture.asset(ImageAssets.moreIcon,width: 25,),
              activeIcon:SvgPicture.asset(ImageAssets.moreIcon,color: AppColors.yellow,width: 25,) ,
              label: "more".tr(),),

          ],
        ),
      ),

    );
  },
);
  }
}
