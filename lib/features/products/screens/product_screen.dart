import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:topsale/config/routes/app_routes.dart';
import 'package:topsale/core/models/selected_products.dart';
import 'package:topsale/core/widgets/custom_textfield.dart';
import 'package:topsale/features/products/cubit/products_cubit.dart';
import '../../../core/methods/products.dart';
import '../../../core/models/product_model.dart';
import '../../../core/utils/app_colors.dart';
import '../../../core/widgets/custom_arrow_back.dart';
import '../components/product_grid_item.dart';

class ProductsScreen extends StatelessWidget {
  const ProductsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProductsCubit, ProductsState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        ProductsCubit cubit =  context.read<ProductsCubit>();
        return Scaffold(
          backgroundColor: AppColors.primary,
          body: SafeArea(
            child: Column(
              children: [
                Row(
                  children: [
                    // Padding(
                    //   padding: const EdgeInsets.only(right: 8.0),
                    //   child: IconButton(
                    //       onPressed: () {},
                    //       icon: Icon(
                    //         Icons.menu,
                    //         color: AppColors.white,
                    //       )),
                    // ),
                    Spacer(),
                    Text(
                      "products",
                      style: Theme
                          .of(context)
                          .textTheme
                          .displayLarge,
                    ).tr(),
                    CustomArrowBack()
                  ],
                ),
                //text field for search
                CustomTextField(
                  onchange: (keyValue) {
                 cubit.searchInProducts(keyValue, products);
                  },
                  textColor: AppColors.white.withOpacity(0.5),
                  borderSide: BorderSide(color: AppColors.lightBlue, width: 2),
                  title: "search".tr(),
                  textInputType: TextInputType.text,
                  backgroundColor: AppColors.primary,
                ),
                const SizedBox(
                  height: 10,
                ),
                Expanded(
                    child: GridView.builder(
                      itemCount: cubit.matches.isEmpty?
                          products.length:
                      cubit.matches.length,
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          mainAxisExtent: 230,
                          crossAxisSpacing: 10,
                          mainAxisSpacing: 20),
                      itemBuilder: (context, index) {
                        return ProductGridItem(
                            product:
                            cubit.matches.isEmpty?
                            products[index]:
                            cubit.matches[index]);
                        //products[index],);
                      },
                    )),
              ],
            ),

          ),
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

                Navigator.pushNamed(context, Routes.createSalesOrderRoute,arguments: SelectedProducts(cubit.selectedProducts));
              },),
          ),
        );
      },
    );
  }
}
