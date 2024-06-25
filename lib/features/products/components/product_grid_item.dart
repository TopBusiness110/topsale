import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';
import 'package:topsale/features/home/cubit/home_tab_cubit/home_cubit.dart';
import 'package:topsale/features/products/cubit/products_cubit.dart';
import '../../../core/models/all_prodyucts_model.dart';
import '../../../core/utils/app_colors.dart';
import '../../../core/utils/decode_image.dart';

class ProductGridItem extends StatelessWidget {
  final ProductModelData product;
  const ProductGridItem({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductsCubit, ProductsState>(
      builder: (context, state) {
        ProductsCubit cubit = context.read<ProductsCubit>();
        return Container(
          decoration: BoxDecoration(
              color: AppColors.lightBlue,
              borderRadius: BorderRadius.circular(18)),
          child: Column(
            children: [
              Flexible(
                fit: FlexFit.tight,
                child: Container(
                    decoration: BoxDecoration(shape: BoxShape.rectangle),
                    margin: EdgeInsets.all(8),
                    child: product.image1920.toString() == "false"
                        ? Image.asset('assets/images/splash.png',
                            color: AppColors.primary, fit: BoxFit.cover)
                        : DecodedImage(
                            base64String: product.image1920, context: context)),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 2),
                child: Text(product.name ?? '',
                    maxLines: 2,
                    textAlign: TextAlign.center,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.bodySmall),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  SizedBox(
                    width: 1,
                  ),
                  // Flexible(
                  //   child: Text(
                  //     product.uomId.toString(),
                  //     maxLines: 1,
                  //     style: Theme.of(context)
                  //         .textTheme
                  //         .bodySmall!
                  //         .copyWith(fontSize: 10),
                  //   ),
                  // ),
                  Text(
                      "${product.listPrice!.toStringAsFixed(2)} ${context.read<HomeCubit>().currencyName}",
                      maxLines: 1,
                      style: Theme.of(context)
                          .textTheme
                          .bodySmall!
                          .copyWith(fontSize: 10)),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircleAvatar(
                      radius: 12,
                      backgroundColor: AppColors.primary,
                      child: IconButton(
                        padding: EdgeInsets.zero,
                        onPressed: () {
                          print(
                              "product.userOrderedQuantity ${product.qty_available}");

                          //todo-->
                          cubit.addProduct(product: product);
                        },
                        icon: const Icon(
                          Icons.add,
                          color: AppColors.yellow,
                          size: 17,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Text("${product.userOrderedQuantity.toString()}"),
                    ),
                    CircleAvatar(
                      radius: 12,
                      backgroundColor: AppColors.primary,
                      child: IconButton(
                        padding: EdgeInsets.zero,
                        onPressed: () {
                          cubit.removeProduct(product: product);
                        },
                        icon: const Icon(
                          Icons.remove,
                          color: AppColors.yellow,
                          size: 17,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
