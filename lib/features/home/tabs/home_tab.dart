import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';
import 'package:topsale/features/home/cubit/home_cubit.dart';

import '../../../config/routes/app_routes.dart';
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
                   Navigator.pushNamed(context, Routes.createSalesOrderRoute);
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
