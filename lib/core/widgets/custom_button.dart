import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class CustomButton extends StatelessWidget{
  final Color backgroundColor ;
  final Color textColor ;
 final double fontSize ;
 final double width;
  final double height;
 final String text ;
  final void Function()? onPressed;
  const CustomButton({super.key,required this.backgroundColor,required this.textColor,
    this.width = 156,this.height = 46,

    this.fontSize=18,required this.text,required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return   SizedBox(
      width: width,
      height: height,

      child: ElevatedButton(onPressed: onPressed,


        child: Text(text, style:  TextStyle(
        
        color:textColor ,
        fontSize:fontSize ,
      )).tr(),
        style: ElevatedButton.styleFrom(
         // fixedSize: Size(10.w, 5.h),
            backgroundColor: backgroundColor,
          //   minimumSize: Size(20.w, 5.h),
          // maximumSize: Size(20.w, 5.h),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
        ),),
    );
  }
}