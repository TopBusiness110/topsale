import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:topsale/features/product_of_category/cubit/cubit.dart';
import 'package:topsale/features/products/cubit/products_cubit.dart';

import '../../../core/utils/app_colors.dart';
import '../../products/components/product_grid_item.dart';
import '../cubit/state.dart';

class ProductsOfCategory extends StatefulWidget {
  ProductsOfCategory(
      {required this.categoryId, required this.catName, super.key});
  int categoryId;
  String catName;
  @override
  State<ProductsOfCategory> createState() => _ProductsOfCategoryState();
}

class _ProductsOfCategoryState extends State<ProductsOfCategory> {
  @override
  void initState() {
    context
        .read<ProductsOfCategoryCubit>()
        .getAllProductsByCategory(widget.categoryId);
    super.initState();
  }

  bool isLoadng = true;
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProductsOfCategoryCubit, ProductsOfCategoryState>(
      listener: (context, state) {
        if (state is LoadingAllCategoriesState) {
          isLoadng = true;
        } else {
          isLoadng = false;
        }
        // TODO: implement listener
      },
      builder: (context, state) {
        var cubit = context.read<ProductsOfCategoryCubit>();
        return Scaffold(
          backgroundColor: AppColors.primary,
          appBar: AppBar(
            backgroundColor: AppColors.primary,
            foregroundColor: AppColors.white,
            title: Text(
              widget.catName,
              style: TextStyle(
                  fontWeight: FontWeight.w600, color: AppColors.white),
            ),
          ),
          body: GridView.builder(
            shrinkWrap: true,
            physics: const BouncingScrollPhysics(),
            itemCount: cubit.allProductsModel?.result!.length,
            padding: const EdgeInsets.symmetric(horizontal: 15),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisExtent: 230,
                crossAxisSpacing: 10,
                mainAxisSpacing: 20),
            itemBuilder: (context, index) {
              return ProductGridItem(
                  product: cubit.allProductsModel!.result![index]);
              //products[index],);
            },
          ),
        );
      },
    );
  }
}
