import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';

import 'app_colors.dart';
import 'get_size.dart';

class DecodedImage extends StatelessWidget {
  DecodedImage({super.key, required this.base64String, required this.context});
  final dynamic base64String;
  BuildContext context;
  Widget convertImage() {
    Image image;
    if (base64String.runtimeType == String) {
      Uint8List bytes = base64.decode(base64String);

      image = Image.memory(
       
        Uint8List.fromList(bytes),
        fit: BoxFit.cover,
      );
    } else {
      image = Image.asset('assets/images/splash.png',
          color: AppColors.primary, fit: BoxFit.cover);
    }
    return image;
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(child: convertImage());
  }
}
