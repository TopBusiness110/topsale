import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';
import 'package:topsale/features/home/cubit/home_tab_cubit/home_cubit.dart';

import '../../../config/routes/app_routes.dart';
import '../../../core/models/selected_products.dart';
import '../../../core/utils/app_assets.dart';
import '../../../core/utils/app_colors.dart';
import '../components/home_list_item.dart';

class HomeTab extends StatelessWidget{
  const HomeTab({super.key});

  @override
  Widget build(BuildContext context) {
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

                 child:Image.asset(AssetsManager.profile),),
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
      body: Column(
        children: [
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 18.0,vertical: 10),
                child: Text("processes",

                  style: Theme.of(context).textTheme.displayLarge,).tr(),
              ),
            ],
          ),
          Expanded(
            child: ListView.separated(
              separatorBuilder: (context, index) => SizedBox(height: 3.h,),
              itemCount: 5,

              itemBuilder: (context, index) {
             return InkWell(
               onTap: () {
                 if(index==0){
                   Navigator.pushNamed(context, Routes.productsRoute);
                 }
                 else   if(index==1){
                   Navigator.pushNamed(context, Routes.createSalesOrderRoute,arguments: SelectedProducts([]));
                 }
                 else   if(index==2){
                   Navigator.pushNamed(context, Routes.returnsRoute);
                 }
                 else   if(index==3){
                   Navigator.pushNamed(context, Routes.customerPaymentsRoute);
                 }
                 else   if(index==4){
                   Navigator.pushNamed(context, Routes.dismissalNoticeRoute);
                 }
               },
                 child: HomeListItem(title:cubit.titles[index] ,imagePath: cubit.imagesPath[index],));
            },),
          ),
          SizedBox(height: 2.h,)
        ],
      ),
    );
  },
);
  }
}
