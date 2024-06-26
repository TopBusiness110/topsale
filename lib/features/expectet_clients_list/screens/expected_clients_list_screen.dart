// import 'package:easy_localization/easy_localization.dart'as easy;
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:sizer/sizer.dart';
// import 'package:topsale/core/utils/app_colors.dart';
// import 'package:topsale/features/expectet_clients_list/cubit/expected_clients_list_cubit.dart';
//
//
// import '../../../config/routes/app_routes.dart';
// import '../../../core/widgets/custom_arrow_back.dart';
// import '../../home/cubit/expected_clients_cubit/expected_clients_cubit.dart';
//
// class ExpectedClientsListScreen extends StatelessWidget {
//   const ExpectedClientsListScreen({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return BlocConsumer<ExpectedClientsListCubit, ExpectedClientsListState>(
//   listener: (context, state) {
//     // TODO: implement listener
//   },
//   builder: (context, state) {
//     ExpectedClientsListCubit cubit = context.read<ExpectedClientsListCubit>();
//     return Scaffold(
//       floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
//       floatingActionButton: CircleAvatar(
//         radius: 25,
//         backgroundColor: AppColors.yellow,
//         child: FloatingActionButton(
//           mini: true,
//           backgroundColor: AppColors.white,
//           shape: CircleBorder(),
//           child: Icon(Icons.add, color: AppColors.lightBlue, size: 27,),
//           onPressed: () {
//
//             Navigator.pushNamed(context, Routes.expectedClientsTabRoute);
//           },),
//       ),
//       backgroundColor: AppColors.primary,
//       body: Column(
//         children: [
//           SizedBox(height: 5.h,),
//           Row(
//             children: [
//               Padding(
//                 padding: const EdgeInsets.only(right: 8.0),
//                 child:  Text(
//                   "expected_clients_list",
//                   style: Theme
//                       .of(context)
//                       .textTheme
//                       .displayLarge,
//                 ).tr(),
//
//               ),
//               const Spacer(),
//
//               const CustomArrowBack()
//             ],
//           ),
//           Expanded(
//               child: ListView.builder(
//                 itemCount: context.read<ExpectedClientsCubit>().expectedClients.length,
//                 itemBuilder: (context, index) {
//                return Padding(
//                  padding: const EdgeInsets.all(4.0),
//                  child: Card(
//                    color: AppColors.blue2,
//                    child:Padding(
//                      padding: const EdgeInsets.all(6.0),
//                      child: Column(
//                        children: [
//                          Row(
//                           mainAxisAlignment:MainAxisAlignment.spaceBetween,
//                            children: [
//                              Text(context.read<ExpectedClientsCubit>().expectedClients[index].name,
//                                style: Theme.of(context).textTheme.bodySmall!.copyWith(color: AppColors.yellow),),
//                              Text("${DateTime.now().toString().substring(0,11)}",
//                                textDirection: TextDirection.ltr,
//                                style: Theme.of(context).textTheme.bodySmall!.copyWith(color: AppColors.yellow),),
//                            ],
//                          ) ,
//                          const SizedBox(height: 5,),
//                          Row(
//                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                            children: [
//                              const Icon(Icons.local_phone_outlined,color: AppColors.lightBlue,size: 20,),
//                              Text(context.read<ExpectedClientsCubit>().expectedClients[index].phone,
//                                style: Theme.of(context).textTheme.bodySmall,) ,
//                              SizedBox(width: 8.w,),
//                              const Icon(Icons.mail_outline,color: AppColors.lightBlue,size: 20,),
//                              Text(context.read<ExpectedClientsCubit>().expectedClients[index].email??"",
//                                style: Theme.of(context).textTheme.bodySmall,) ,
//
//
//                            ],
//                          ),
//                          const SizedBox(height: 5,),
//                         Row(
//                           children: [
//                             const Icon(Icons.location_on_outlined,color: AppColors.lightBlue,size: 20),
//                             SizedBox(width: 10,),
//                             Text(context.read<ExpectedClientsCubit>().expectedClients[index].address??"",
//                               style: Theme.of(context).textTheme.bodySmall,) ,
//                           ],
//                         ),
//                          const SizedBox(height: 5,),
//                          Wrap(
//                            alignment: WrapAlignment.start,
//                            children: [
//                              Text("الطلب :",style: TextStyle(fontSize: 15,color: AppColors.lightBlue),),
//                              Text(" ${context.read<ExpectedClientsCubit>().expectedClients[index].opportunity}",
//                                style: Theme.of(context).textTheme.bodySmall,),
//                            ],
//                          ) ,
//
//                        ],
//                      ),
//                    )
//                  ),
//                );
//           },))
//         ],
//       ),
//     );
//   },
// );
//   }
// }

import 'package:easy_localization/easy_localization.dart' as easy;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';
import 'package:topsale/core/utils/app_colors.dart';
import 'package:topsale/features/expectet_clients_list/cubit/expected_clients_list_cubit.dart';
import 'package:flutter_html/flutter_html.dart';

import '../../../config/routes/app_routes.dart';
import '../../../core/widgets/custom_arrow_back.dart';

class ExpectedClientsListScreen extends StatefulWidget {
  const ExpectedClientsListScreen({super.key});

  @override
  State<ExpectedClientsListScreen> createState() =>
      _ExpectedClientsListScreenState();
}

class _ExpectedClientsListScreenState extends State<ExpectedClientsListScreen> {
  @override
  void initState() {
    context.read<ExpectedClientsListCubit>().getAllLeads();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ExpectedClientsListCubit, ExpectedClientsListState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        ExpectedClientsListCubit cubit =
            context.read<ExpectedClientsListCubit>();
        return SafeArea(
          child: Scaffold(
            floatingActionButtonLocation:
                FloatingActionButtonLocation.startFloat,
            floatingActionButton: CircleAvatar(
              radius: 25,
              backgroundColor: AppColors.yellow,
              child: FloatingActionButton(
                mini: true,
                backgroundColor: AppColors.white,
                shape: CircleBorder(),
                child: Icon(
                  Icons.add,
                  color: AppColors.lightBlue,
                  size: 27,
                ),
                onPressed: () {
                  Navigator.pushNamed(context, Routes.expectedClientsTabRoute);
                },
              ),
            ),
            backgroundColor: AppColors.primary,
            body: Column(
              children: [
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 8.0),
                      child: Text(
                        "expected_clients_list",
                        style: Theme.of(context).textTheme.displayLarge,
                      ).tr(),
                    ),
                    const Spacer(),
                    SizedBox(
                      height: 6.h,
                    ),
                    // const CustomArrowBack()
                  ],
                ),
                Expanded(
                    child: cubit.allLeadsModel == null
                        ? const Center(
                            child: CircularProgressIndicator(
                                color: AppColors.yellow))
                        : ListView.builder(
                            itemCount: cubit.allLeadsModel!.result!.length,
                            itemBuilder: (context, index) {
                              return Padding(
                                padding: const EdgeInsets.all(4.0),
                                child: Card(
                                    color: AppColors.blue2,
                                    child: Padding(
                                      padding: EdgeInsets.all(3.w),
                                      child: Column(
                                        children: [
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                cubit.allLeadsModel!
                                                        .result![index].name ??
                                                    "",
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodySmall!
                                                    .copyWith(
                                                        color:
                                                            AppColors.yellow),
                                              ),
                                              Text(
                                                cubit
                                                        .allLeadsModel!
                                                        .result![index]
                                                        .createDate ??
                                                    "",
                                                textDirection:
                                                    TextDirection.ltr,
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodySmall!
                                                    .copyWith(
                                                        color:
                                                            AppColors.yellow),
                                              ),
                                            ],
                                          ),
                                          const SizedBox(
                                            height: 5,
                                          ),
                                          Row(
                                            children: [
                                              const Icon(
                                                Icons.local_phone_outlined,
                                                color: AppColors.lightBlue,
                                                size: 20,
                                              ),
                                              SizedBox(
                                                width: 2.w,
                                              ),
                                              Text(
                                                cubit.allLeadsModel!
                                                        .result![index].phone ??
                                                    "",
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodySmall,
                                              ),
                                              Spacer(),
                                              const Icon(
                                                Icons.mail_outline,
                                                color: AppColors.lightBlue,
                                                size: 20,
                                              ),
                                              SizedBox(
                                                width: 2.w,
                                              ),
                                              Text(
                                                "",
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodySmall,
                                              ),
                                            ],
                                          ),
                                          const SizedBox(
                                            height: 5,
                                          ),
                                          Row(
                                            children: [
                                              const Icon(
                                                  Icons.location_on_outlined,
                                                  color: AppColors.lightBlue,
                                                  size: 20),
                                              SizedBox(
                                                width: 10,
                                              ),
                                              Text(
                                                cubit
                                                        .allLeadsModel!
                                                        .result![index]
                                                        .street ??
                                                    "",
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodySmall,
                                              ),
                                            ],
                                          ),
                                          const SizedBox(
                                            height: 5,
                                          ),
                                          Wrap(
                                            alignment: WrapAlignment.start,
                                            children: [
                                              const Text(
                                                "الوصف أو الفرصة :",
                                                style: TextStyle(
                                                    fontSize: 15,
                                                    color: AppColors.lightBlue),
                                              ),

                                              Html(
                                                data: cubit
                                                        .allLeadsModel!
                                                        .result![index]
                                                        .description ??
                                                    '',
                                              ),

                                              //  Text(
                                              //    cubit
                                              //            .allLeadsModel!
                                              //            .result![index]
                                              //            .description ??
                                              //        '',
                                              //    style: Theme.of(context)
                                              //        .textTheme
                                              //        .bodySmall,
                                              //  ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    )),
                              );
                            },
                          ))
              ],
            ),
          ),
        );
      },
    );
  }
}
