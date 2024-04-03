import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:topsale/core/utils/app_colors.dart';
import 'package:topsale/core/widgets/custom_arrow_back.dart';

class ReportsScreen extends StatelessWidget {
  const ReportsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(

        backgroundColor: AppColors.primary,
       body: SafeArea(
         child: Column(
           // mainAxisAlignment: MainAxisAlignment.start,
           crossAxisAlignment: CrossAxisAlignment.start,
           children: [
             Row(
               children: [
                 Padding(
                   padding: const EdgeInsets.only(right: 8.0),
                   child:  Text(
                     "reports",
                     style: Theme
                         .of(context)
                         .textTheme
                         .displayLarge,
                   ).tr(),

                 ),
                 const Spacer(),

                 const CustomArrowBack()
               ],
             ),
           Container(
             height: 50,
             decoration: BoxDecoration(
                 borderRadius: BorderRadius.circular(20), color: AppColors.blue2),
             child: TabBar(
               // indicator:
               //
               // BoxDecoration(
               //   color: AppColors.lightBlue,
               //   borderRadius: BorderRadius.circular(10),
               // ),
               labelColor: Colors.orange,
               dividerColor: Colors.yellow,
               tabs: [

                 Tab(
                   child: Text("sales".tr(),style: Theme.of(context).textTheme.displayMedium,),
                 ),
                 Tab(
                   child: Text("clients".tr(),style: Theme.of(context).textTheme.displayMedium,),
                 ),
                 Tab(
                   child: Text("reports".tr(),style: Theme.of(context).textTheme.displayMedium,),

                 ),
               ],
             ),
           ),
             Expanded(
                 child: TabBarView(
                  children: [
                  Container(
                  // width: 70.w,
                  //  height: double.infinity,
                   decoration: BoxDecoration(
                     color: AppColors.primary,
                     borderRadius: BorderRadius.circular(20)
                   ),
                 ),
                 Container(
                  // width: 70.w,
                  // height: double.infinity,
                   decoration: BoxDecoration(
                       color:AppColors.primary,
                       borderRadius: BorderRadius.circular(20)
                   ),
                 ),
                 Container(
                   // width: 70.w,
                   // height: double.infinity,
                   decoration: BoxDecoration(
                       color: AppColors.primary,
                       borderRadius: BorderRadius.circular(20)
                   ),
                 ),
               ],
             ))
           ],
         ),
       ),
      ),

    );
  }
}
