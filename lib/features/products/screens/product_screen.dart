import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:topsale/config/routes/app_routes.dart';
import 'package:topsale/core/models/selected_products.dart';
import 'package:topsale/core/widgets/custom_textfield.dart';
import 'package:topsale/features/product_of_category/screen/products_of_category.dart';
import 'package:topsale/features/products/cubit/products_cubit.dart';

import '../../../core/utils/app_colors.dart';
import '../../../core/utils/get_size.dart';
import '../components/product_grid_item.dart';

class ProductsScreen extends StatefulWidget {
  const ProductsScreen({super.key});

  @override
  State<ProductsScreen> createState() => _ProductsScreenState();
}

class _ProductsScreenState extends State<ProductsScreen> {
  bool isLoading = true;
  bool isLoadingProducts = true;
  @override
  void initState() {
    print(BlocProvider.of<ProductsCubit>(context).categoriesModel == null);
    if (BlocProvider.of<ProductsCubit>(context).categoriesModel == null ||
        BlocProvider.of<ProductsCubit>(context).productsModel == null) {
      BlocProvider.of<ProductsCubit>(context).getAllCategories();
      BlocProvider.of<ProductsCubit>(context).getAllProducts();
    } else {
      isLoadingProducts = false;
      isLoading = false;
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProductsCubit, ProductsState>(
      listener: (context, state) {
        if (state is LoadingAllCategoriesState) {
          isLoading = true;
        } else if (state is AllCategoriesSuccessState) {
          isLoading = false;
        } else if (state is AllCategoriesFailureState) {
          isLoadingProducts = false;
        } else if (state is LoadingAllProductsState) {
          isLoadingProducts = true;
        } else if (state is AllProductsFailureState) {
          isLoadingProducts = false;
        } else if (state is AllProductsSuccessState) {
          isLoadingProducts = false;
        } else {
          isLoadingProducts = false;
          isLoading = false;
        }
      },
      builder: (context, state) {
        ProductsCubit cubit = context.read<ProductsCubit>();
        return Scaffold(
          appBar: AppBar(
            backgroundColor: AppColors.primary,
            leading: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: const Icon(
                  Icons.arrow_back_ios,
                  color: AppColors.lightBlue,
                )),
            title: Text(
              "products".tr(),
              style: Theme.of(context).textTheme.displayLarge,
            ),
          ),
          backgroundColor: AppColors.primary,
          body: (isLoading || isLoadingProducts)
              ? Center(
                  child: CircularProgressIndicator(color: AppColors.yellow),
                )
              : SafeArea(
                  child: Column(
                    children: [
                      //text field for search
                      CustomTextField(
                        onchange: (keyValue) {
                          cubit.searchInProducts(
                              keyValue, cubit.productsModel!.result ?? []);
                        },
                        textColor: AppColors.white.withOpacity(0.5),
                        borderSide:
                            BorderSide(color: AppColors.lightBlue, width: 2),
                        title: "search".tr(),
                        textInputType: TextInputType.text,
                        backgroundColor: AppColors.primary,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      SizedBox(
                          height: MediaQuery.of(context).size.height / 14,
                          child: ListView.builder(
                            shrinkWrap: true,
                            scrollDirection: Axis.horizontal,
                            physics: const BouncingScrollPhysics(),
                            itemCount: cubit.categoriesModel?.result!.length,
                            itemBuilder: (BuildContext context, int index) {
                              return InkWell(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              ProductsOfCategory(
                                                  categoryId: cubit
                                                      .categoriesModel!
                                                      .result![index]
                                                      .id!,
                                                  catName: cubit
                                                      .categoriesModel!
                                                      .result![index]
                                                      .name!)));
                                  //!  nav to api of products of category
                                },
                                child: Container(
                                    alignment: Alignment.center,
                                    margin: EdgeInsets.all(5),
                                    decoration: BoxDecoration(
                                        color: AppColors.lightBlue,
                                        borderRadius: BorderRadius.circular(
                                            getSize(context) / 32)),
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 15, vertical: 5),
                                    child: Text(
                                      cubit.categoriesModel!.result![index]
                                          .name!,
                                    )),
                              );
                            },
                          )),
                      const SizedBox(
                        height: 10,
                      ),
                      Expanded(
                          child: GridView.builder(
                        shrinkWrap: true,
                        physics: const BouncingScrollPhysics(),
                        itemCount: cubit.matches.isEmpty
                            ? cubit.productsModel?.result!.length
                            : cubit.matches.length,
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                mainAxisExtent: 230,
                                crossAxisSpacing: 10,
                                mainAxisSpacing: 20),
                        itemBuilder: (context, index) {
                          return ProductGridItem(
                              product: cubit.matches.isEmpty
                                  ? cubit.productsModel!.result![index]
                                  : cubit.matches[index]);
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
              child: Icon(
                Icons.add,
                color: AppColors.lightBlue,
                size: 27,
              ),
              onPressed: () {
                Navigator.pushNamed(context, Routes.createSalesOrderRoute,
                    arguments: SelectedProducts(cubit.selectedProducts));
              },
            ),
          ),
        );
      },
    );
  }
}
