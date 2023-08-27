import 'package:easy_localization/easy_localization.dart' as easy;
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:topsale/core/widgets/custom_button.dart';

import '../../../core/utils/app_colors.dart';
import '../../../core/widgets/custom_arrow_back.dart';

class ItineraryDetailsScreen extends StatelessWidget {
  const ItineraryDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primary,
      body: Column(
          children: [
            SizedBox(height: 5.h,),
        Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: Text(
                "itinerary_details",
                style: Theme.of(context).textTheme.displayLarge,
              ).tr(),
            ),
            const Spacer(),
            const CustomArrowBack()
          ],
        ),
        Expanded(
          child:
          Container(
            margin: EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: AppColors.blue2,
              borderRadius: BorderRadius.circular(19)
            ),
            child: ListView.separated(
                itemBuilder: (context, index) {
                  //when we clicked on client
                  return InkWell(
                    onTap: () {},
                    child: Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "حامل هاتف معدني",
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                          Text(
                            //cubit.matches.isEmpty?
                            "120قطعة",
                            textDirection: TextDirection.ltr,
                            style: Theme.of(context).textTheme.bodySmall!.copyWith(
                              color: AppColors.white.withOpacity(0.5)
                            ),
                          ),

                        ],
                      ),
                    ),
                  );
                },
                separatorBuilder: (context, index) {
                  return Divider(
                    indent: 10,
                    endIndent: 10,
                    color: AppColors.white.withOpacity(0.7),
                    thickness: 1,
                  );
                },
                itemCount: 3),
          ),
        ),
           // SizedBox(height: 5,),
            Container(
              decoration: BoxDecoration(
                shape:BoxShape.rectangle, 
              ),
              child: Image.asset("assets/images/map.png"),
            ),
            SizedBox(height: 10,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                CustomButton(
                  fontSize: 14,
                  width: 30.w,
                    height: 4.5.h,
                    backgroundColor: AppColors.lightBlue, textColor: AppColors.white,
                    text: "start_trip".tr(), onPressed: (){}),
                CustomButton(
                    fontSize: 14,
                    width: 30.w,
                    height: 4.5.h,
                    backgroundColor: AppColors.yellow, textColor: AppColors.white,
                    text: "end_trip".tr(), onPressed: (){}),
                CustomButton(
                    fontSize: 14,
                    width: 30.w,
                    height: 4.5.h,
                    backgroundColor: AppColors.red, textColor: AppColors.white,
                    text: "cancel".tr(), onPressed: (){})
              ],
            ),
            SizedBox(height: 10,),
            
      ]),
    );
  }
}

// void showClientsPopup(BuildContext context, List<ClientModel> clients) {
//   showDialog(
//     context: context,
//     builder: (context) {
//       return Dialog(
//         shape:
//         RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
//         backgroundColor: AppColors.blue2,
//         child: BlocBuilder<CreateSalesOrderCubit, CreateSalesOrderState>(
//           builder: (context, state) {
//             CreateSalesOrderCubit cubit =
//             context.read<CreateSalesOrderCubit>();
//             return ListView(
//               physics: const NeverScrollableScrollPhysics(),
//               shrinkWrap: true,
//               // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//               children: [
//                 SizedBox(
//                   height: 2.h,
//                 ),
//                 Center(
//                     child: Text(
//                       "client",
//                       textAlign: TextAlign.center,
//                       style: Theme.of(context).textTheme.displayLarge,
//                     ).tr()),
//                 SizedBox(
//                   height: 2.h,
//                 ),
//                 CustomTextField(
//                     onchange: (value) {
//                       cubit.searchForName(value);
//                     },
//                     title: "الاسم / الرقم",
//                     textInputType: TextInputType.text,
//                     backgroundColor: AppColors.primary,
//                     textColor: AppColors.white),
//                 Container(
//                   alignment: Alignment.center,
//                   width: 95.w,
//                   height: 60.h,
//                   margin: const EdgeInsets.all(15),
//                   padding: const EdgeInsets.all(8),
//                   decoration: BoxDecoration(
//                       borderRadius: BorderRadius.circular(10),
//                       color: AppColors.primary),
//                   child: state is NoClientsMatchesState
//                       ? SizedBox(
//                     height: 50,
//                     width: 50,
//                     child: IconButton(
//                       style: IconButton.styleFrom(
//                           backgroundColor: AppColors.yellow,
//                           shape: CircleBorder()),
//                       onPressed: () {
//                         showNewClientPopUp(context);
//                       },
//                       icon: const Icon(
//                         Icons.add,
//                         color: AppColors.primary,
//                         size: 30,
//                       ),
//                     ),
//                   )
//                       : ListView.separated(
//                       itemBuilder: (context, index) {
//                         //when we clicked on client
//                         return InkWell(
//                           onTap: () {
//                             cubit.matches.isEmpty
//                                 ? cubit
//                                 .selectClientName(clients[index].name)
//                                 : cubit.selectClientName(
//                                 cubit.matches[index].name);
//                             cubit.matches.clear();
//                             Navigator.pop(context);
//                           },
//                           child: Padding(
//                             padding: EdgeInsets.all(8.0),
//                             child: Row(
//                               mainAxisSize: MainAxisSize.min,
//                               mainAxisAlignment:
//                               MainAxisAlignment.spaceBetween,
//                               children: [
//                                 Text(
//                                   state is SearchingResultsState
//                                       ? cubit.matches[index].name
//                                       :
//                                   // cubit.matches.isEmpty ?
//                                   clients[index].name,
//                                   //  : cubit.matches[index].name,
//                                   style: Theme.of(context)
//                                       .textTheme
//                                       .bodyMedium,
//                                 ),
//                                 Text(
//                                   //cubit.matches.isEmpty?
//                                   state is SearchingResultsState
//                                       ? cubit.matches[index].phoneNumber
//                                       : clients[index].phoneNumber,
//                                   //:cubit.matches[index].phoneNumber,
//                                   textDirection: TextDirection.ltr,
//                                   style: Theme.of(context)
//                                       .textTheme
//                                       .bodyMedium,
//                                 ),
//                               ],
//                             ),
//                           ),
//                         );
//                       },
//                       separatorBuilder: (context, index) {
//                         return Divider(
//                           indent: 10,
//                           endIndent: 10,
//                           color: AppColors.white.withOpacity(0.7),
//                           thickness: 1,
//                         );
//                       },
//                       itemCount: cubit.matches.isEmpty
//                           ? clients.length
//                           : cubit.matches.length),
//                 ),
//                 // SizedBox(
//                 //   height: 50,
//                 //   width: 50,
//                 //   child: IconButton(
//                 //     style: IconButton.styleFrom(
//                 //       backgroundColor: AppColors.yellow,
//                 //       shape: CircleBorder()
//                 //     ),
//                 //     onPressed: () {
//                 //       showNewClientPopUp(context);
//                 //     }, icon: Icon(Icons.add,color: AppColors.primary,size: 30,),),
//                 // ),
//               ],
//             );
//           },
//         ),
//       );
//     },
//   );
// }
