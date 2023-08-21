import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:topsale/features/products/cubit/products_cubit.dart';
import '../../../core/models/product_model.dart';
import '../../../core/utils/app_colors.dart';

class ProductGridItem extends StatelessWidget {
 final ProductModel product;
  const ProductGridItem({super.key,required this.product});

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
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            decoration: BoxDecoration(shape: BoxShape.rectangle),
            margin: EdgeInsets.all(8),
            child: Image.asset(product.image!,fit: BoxFit.cover,),


          ),
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Text(product.name!,
                    textAlign: TextAlign.start,
                    style: Theme.of(context).textTheme.bodySmall),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text(
                product.code!,
                style: Theme.of(context)
                    .textTheme
                    .bodySmall!
                    .copyWith(fontSize: 10),
              ),
              Text("${product.price!} USD",
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
                  radius: 10,
                  backgroundColor: AppColors.primary,
                  child: IconButton(
                    padding: EdgeInsets.zero,
                    onPressed: () {
                      //todo-->
                      cubit.addProduct(product: product);
                    },
                    icon: const Icon(
                      Icons.add,
                      color: AppColors.yellow,
                      size: 15,
                    ),
                  ),
                ),
                 Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Text("${product.userOrderedQuantity}"),
                ),
                CircleAvatar(
                  radius: 10,
                  backgroundColor: AppColors.primary,
                  child: IconButton(
                    padding: EdgeInsets.zero,
                    onPressed: () {
                      cubit.removeProduct(product: product);
                    },
                    icon: const Icon(
                      Icons.remove,
                      color: AppColors.yellow,
                      size: 15,
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
