import 'package:flutter/material.dart';

import '../utils/app_colors.dart';

class CustomContainer extends StatelessWidget{
  const CustomContainer({super.key,required this.width, required this.height,this.color=AppColors.blue2,
  this.child});
  final double width;
  final double height;
  final Widget? child;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return   Container(
      // alignment: Alignment.center,
      width: width,
      height: height,
      decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(16)
      ),
      child: child,
    );
  }
}
