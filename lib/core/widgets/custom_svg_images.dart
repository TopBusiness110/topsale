import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../utils/app_colors.dart';

class MySvgWidget extends StatelessWidget {
  const MySvgWidget({Key? key, required this.path, required this.imageColor, required this.size})
      : super(key: key);

  final String path;
  final Color imageColor;
  final double size;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: size,
      width: size,
      child: SvgPicture.asset(
        path,
       color: AppColors.primary,
       colorFilter: ColorFilter.mode(imageColor, BlendMode.srcIn),
        height: size,
        width: size,
      ),
    );
  }
}
