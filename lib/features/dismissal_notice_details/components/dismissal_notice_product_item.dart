import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:topsale/core/models/all_prodyucts_model.dart';
import 'package:topsale/core/utils/decode_image.dart';
import 'package:topsale/features/dismissal_notice/cubit/dismissal_notice_cubit.dart';

import '../../../core/utils/app_colors.dart';

class DismissalNoticeProductItem extends StatelessWidget {
  final ProductModelData product;
  const DismissalNoticeProductItem({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DismissalNoticeCubit, DismissalNoticeState>(
      builder: (context, state) {
        DismissalNoticeCubit cubit = context.read<DismissalNoticeCubit>();
        return Container(
          decoration: BoxDecoration(
              color: AppColors.lightBlue,
              borderRadius: BorderRadius.circular(18)),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                child: Container(
                    decoration: BoxDecoration(shape: BoxShape.rectangle),
                    margin: EdgeInsets.all(8),
                    child: DecodedImage(
                        base64String: product.image1920, context: context)),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 2),
                child: Text(product.name ?? '',
                    maxLines: 1,
                    textAlign: TextAlign.start,
                    style: Theme.of(context).textTheme.bodySmall),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Flexible(
                    child: Text(
                      product.uomId.toString(),
                      maxLines: 1,
                      style: Theme.of(context)
                          .textTheme
                          .bodySmall!
                          .copyWith(fontSize: 10),
                    ),
                  ),
                  Text("${product.listPrice.toString()} USD",
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
