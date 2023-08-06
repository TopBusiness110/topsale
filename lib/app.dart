import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:topsale/config/routes/app_routes.dart';
import 'package:topsale/core/preferences/preferences.dart';
import 'package:topsale/core/utils/app_strings.dart';

class TopSale extends StatelessWidget{
  const TopSale({super.key});

  @override
  Widget build(BuildContext context) {

    Preferences.instance.saveLanguage(
      EasyLocalization.of(context)!.locale.languageCode
    );
    return
      MultiBlocProvider(
      providers: [
      // BlocProvider(create: (context) => injector.serviceLocator<ContactUsCubit>(), ,)
      ], child:  MaterialApp(
         supportedLocales: context.supportedLocales,
        locale: context.locale,
        themeMode: ThemeMode.light,
        darkTheme: ThemeData.light(),
        localizationsDelegates: context.localizationDelegates,
        debugShowCheckedModeBanner: false,
        title: AppStrings.appName,
        onGenerateRoute: AppRoutes.onGenerateRoute,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),

      ),
      
    );
  }
}
