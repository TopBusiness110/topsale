import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../core/utils/app_colors.dart';

class CustomDataContainer extends StatelessWidget {
  final String label ;
 final IconData icon ;
  const CustomDataContainer({super.key,required this.label,required this.icon});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 80.w,
      height: 5.h,
      decoration: BoxDecoration(
          color: AppColors.yellow, borderRadius: BorderRadius.circular(15)),
      child: Stack(
        alignment: Alignment.bottomLeft,
        children: [
          Container(
            padding: EdgeInsets.only(left: 20.w),
            alignment: Alignment.center,
            width: 70.w,
            height: 5.h,
            decoration: const BoxDecoration(
                color: AppColors.primary,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(15),
                    bottomLeft: Radius.circular(15))),
            child: Text(label,style: const TextStyle(fontSize: 14,),),
          ),
          Positioned(
              right: 7,
              top: 0,
              bottom: 0,
              child:Icon(icon,color: AppColors.white,)
          ),
        ],
      ),
    );
  }
}
