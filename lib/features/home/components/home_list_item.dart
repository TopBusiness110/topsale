import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../core/widgets/custom_container.dart';

class HomeListItem extends StatelessWidget {
  final String title;
  final String imagePath;
  const HomeListItem({super.key,required this.title,required this.imagePath});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15.0),
      child: CustomContainer(width: 90.w, height: 9.h,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18.0),
              child: Image.asset(imagePath,width: 35,),
            ),
            Text(title,  style: Theme.of(context).textTheme.displayLarge,).tr()
          ],
        ),
      ),
    );
  }
}
