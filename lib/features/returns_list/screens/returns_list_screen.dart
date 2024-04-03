// ignore_for_file: unused_local_variable

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sizer/sizer.dart';
import 'package:topsale/features/returns_list/cubit/returns_list_cubit.dart';

import '../../../config/routes/app_routes.dart';
import '../../../core/utils/app_colors.dart';
import '../../../core/widgets/custom_arrow_back.dart';

class ReturnsListScreen extends StatelessWidget {
  const ReturnsListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ReturnsListCubit, ReturnsListState>(
  listener: (context, state) {
    // TODO: implement listener
  },
    builder: (context, state) {
      ReturnsListCubit cubit = context.read<ReturnsListCubit>();
      return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
      floatingActionButton: CircleAvatar(
        radius: 25,
        backgroundColor: AppColors.yellow,
        child: FloatingActionButton(
          mini: true,
          backgroundColor: AppColors.white,
          shape: CircleBorder(),
          child: Icon(Icons.add, color: AppColors.lightBlue, size: 27,),
          onPressed: () {
            Navigator.pushNamed(context, Routes.returnsRoute);
            // Navigator.pushNamed(context, Routes.expectedClientsTabRoute);
          },),
      ),
      backgroundColor: AppColors.primary,
      body: Column(
        children: [
          SizedBox(height: 5.h,),
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 8.0),
                child:  Text(
                  "sales_ordered_list",
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
          Expanded(
              child: ListView.builder(
                //itemCount: cubit.salesOrderedList?.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: Stack(
                      children: [
                        Container(
                          margin: EdgeInsets.only(top: 20),
                          width:97.w,
                          height: 17.h,
                          padding: const EdgeInsets.symmetric(horizontal: 10.0,vertical: 20),
                          decoration: BoxDecoration(
                              color: AppColors.primary,
                              borderRadius: BorderRadius.circular(15),
                              border: Border.all(color: AppColors.blue2,width: 2)
                          ),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment:MainAxisAlignment.end,
                                children: [
                                  SvgPicture.asset("assets/icon/bill.svg",width: 20),
                                  const SizedBox(width: 15,),
                                  Text(
                                    "uytgggh",
                                   // cubit.salesOrderedList![index]?.billingNumber??"",
                                    style: Theme.of(context).textTheme.bodySmall,),
                                ],
                              ) ,
                              const SizedBox(height: 5,),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  SvgPicture.asset("assets/icon/name.svg",width: 20),
                                  SizedBox(width: 10,),
                                  Text("8888888",
                                   // cubit.salesOrderedList?[index]?.customer??"",
                                    style: Theme.of(context).textTheme.bodySmall,) ,
                                  SizedBox(width: 8.w,),
                                ],
                              ),
                              const SizedBox(height: 15,),
                              Row(
                                children: [
                                  SvgPicture.asset("assets/icon/date.svg",width: 20),
                                  SizedBox(width: 10,),
                                  Text( "7777777",
                                    //"${cubit.salesOrderedList?[index]!.creationDate.toString().substring(0,16)}",
                                    //cubit.expectedClients?[index]?.address??"",
                                    style: Theme.of(context).textTheme.bodySmall,) ,
                                  SizedBox(width: 30.w,),
                                  Text( "66666666",
                                    //"الاجمالي : ${cubit.salesOrderedList?[index]!.total} ",
                                    //cubit.expectedClients?[index]?.address??"",
                                    style: Theme.of(context).textTheme.bodySmall,) ,
                                ],
                              ),


                            ],
                          ),
                        ),
                        Positioned(
                            right: 5.w,
                            // top: -10,
                            child: Container(
                              alignment: Alignment.center,
                              width: 27.w,
                              height: 5.h,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  color: AppColors.lightBlue
                              ),
                              child: Text(
                                "444444444",
                                 // cubit.salesOrderedList![index]!.status
                              ),
                            ))
                      ],
                    ),
                  );
                },))
        ],
      ),
    );
  },
);
  }
}
