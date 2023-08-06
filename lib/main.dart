import 'package:device_preview/device_preview.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:get_it/get_it.dart';
import 'package:sizer/sizer.dart';
import 'package:topsale/injector.dart'as injector;

import 'app.dart';
import 'app_bloc_observer.dart';

final locator = GetIt.instance;//unused variable


Future<void> main() async {

  //     WidgetsFlutterBinding.ensureInitialized();
  //     await EasyLocalization.ensureInitialized();
  // WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  //
  // await Firebase.initializeApp(
  //   options: DefaultFirebaseOptions.currentPlatform,
  // );
    await injector.setUp();
    Bloc.observer = AppBlocObserver();
    runApp(
        Sizer(
            builder: (context, orientation, deviceType) {
               return DevicePreview(
                   builder: (context) =>EasyLocalization(
                    supportedLocales: [Locale('ar',''),Locale('en','')],
                       path: 'assets/lang',
                       saveLocale: true,
                       startLocale: Locale("ar",""),
                       fallbackLocale: Locale("ar",""),
                       child: Phoenix(
                         child: TopSale(),
                       ),
                   ) ,
               );
            },
        ),
    );

}



