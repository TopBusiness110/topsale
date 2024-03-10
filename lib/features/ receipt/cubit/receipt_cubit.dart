
import 'dart:io';
import 'dart:typed_data';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:path_provider/path_provider.dart';
import 'package:screenshot/screenshot.dart';
import 'package:share/share.dart';

part 'receipt_state.dart';

class ReceiptCubit extends Cubit<ReceiptState> {
  ReceiptCubit() : super(ReceiptInitial());
  ScreenshotController screenshotController = ScreenshotController();

  captureScreenshot() async {

    Uint8List? imageInUnit8List = await screenshotController.capture();// store unit8List image here ;
    final tempDir = await getTemporaryDirectory();
    File file = await File('${tempDir.path}/image.png').create();
    file.writeAsBytesSync(imageInUnit8List!.toList(growable: true));


    Share.shareFiles([file.path],text: "share receipt ",);
    emit(ScreenshootState());
  }
}
