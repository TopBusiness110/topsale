import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';
import 'package:topsale/core/utils/app_colors.dart';
import 'package:topsale/features/expectet_clients_list/cubit/expected_clients_list_cubit.dart';

import '../../../core/widgets/custom_arrow_back.dart';
import '../../../core/widgets/custom_button.dart';
import '../../../core/widgets/custom_textfield.dart';
import '../cubit/expected_clients_cubit/expected_clients_cubit.dart';
//العملاء المحتملين
class ExpectedClientsTab extends StatelessWidget {
   ExpectedClientsTab({super.key});
  final formKey = GlobalKey<FormState>(debugLabel: "expected clients tab");

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ExpectedClientsCubit, ExpectedClientsState>(
  listener: (context, state) {
    // TODO: implement listener
  },
  builder: (context, state) {
    ExpectedClientsCubit cubit = context.read<ExpectedClientsCubit>();
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: AppColors.primary,
      body: SingleChildScrollView(
        child: Column(
         // alignment: Alignment.bottomCenter,
          children: [
            SizedBox(height: 5.h,),
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child:  Text(
                    "add_expected_client",
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
            SizedBox(height: 25.h,),
            Container(
              width: double.infinity,
              height: 60.h,
              decoration: const BoxDecoration(
                  color: AppColors.lightBlue,
                  borderRadius: BorderRadius.only(topLeft:Radius.circular(60) ,topRight:Radius.circular(60) )
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Form(
                        key:formKey ,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            SizedBox(height: 11.h,),
                            CustomTextField(
                              controller: cubit.nameController,
                              textColor: AppColors.white.withOpacity(0.5),
                              title: "name".tr(),
                              textInputType: TextInputType.text,
                              backgroundColor: AppColors.primary,
                              horizantalTape: 5,
                              validatorMessage: "Enter The Name",
                            ),
                            const SizedBox(height: 10,),
                            CustomTextField(
                              controller: cubit.phoneController,
                                textColor: AppColors.white.withOpacity(0.5),
                                horizantalTape: 5,
                                title: "phone_number".tr(),
                              textInputType: TextInputType.phone,
                                backgroundColor: AppColors.primary,
                              validatorMessage: "Enter The phone",),
                            const SizedBox(height: 10,),
                            CustomTextField(
                              controller: cubit.opportunityController,
                                textColor: AppColors.white.withOpacity(0.5),
                                horizantalTape: 5,
                                title: "opportunity".tr(), textInputType: TextInputType.text,
                                backgroundColor: AppColors.primary,
                              validatorMessage: "Enter The Opportunity",),
                            const SizedBox(height: 10,),

                          ],
                        ),
                      ),
                      CustomTextField(
                        controller: cubit.emailController,
                        title: "email".tr(),
                        textInputType: TextInputType.emailAddress,
                        textColor: AppColors.white.withOpacity(0.5),
                        backgroundColor: AppColors.primary,horizantalTape: 5,
                        // validatorMessage: "Enter The Email",
                      ),
                      const SizedBox(height: 10,),
                      CustomTextField(
                        controller: cubit.addressController,
                        title: "address".tr(), textInputType: TextInputType.text,
                        textColor: AppColors.white.withOpacity(0.5),
                        backgroundColor: AppColors.primary,horizantalTape: 5,
                        // validatorMessage: "Enter The Address",
                      ),
                      const SizedBox(height: 10,),
                      CustomButton(
                        width: 28.w,
                        height: 5.h,
                        backgroundColor: AppColors.yellow, textColor: AppColors.white, text: "registration".tr(),
                        onPressed: () {
                          if(formKey.currentState!.validate()){
                            cubit.addExpectedClient();
                            context.read<ExpectedClientsListCubit>().fillExpectedClientsList(name: cubit.nameController.text,
                            opportunity: cubit.opportunityController.text,phone: cubit.phoneController.text,address: cubit.addressController.text,
                            email: cubit.emailController.text);
                            Navigator.pop(context);
                           // Navigator.pushNamed(context, Routes.expectedClientsListRoute);
                            cubit.clearFields();
                          }
                          // Navigator.pushNamed(context, Routes.productsRoute);
                        },),
                    ],
                  ),
                ),
              ),
            ),



          ],
        ),
      ),
    );
  },
);
  }
}
