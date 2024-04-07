import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:topsale/config/routes/app_routes.dart';
import 'package:topsale/core/preferences/preferences.dart';
import 'package:topsale/core/utils/app_strings.dart';
import 'package:topsale/features/cart/cart_cubit.dart';
import 'package:topsale/features/create_sales_order/cubit/create_sales_order_cubit.dart';
import 'package:topsale/features/customer_payments/cubit/customer_payments_cubit.dart';
import 'package:topsale/features/dismissal_notice_details/cubit/dismissal_notice_details_cubit.dart';
import 'package:topsale/features/home/cubit/home_tab_cubit/home_cubit.dart';
import 'package:topsale/features/new_product/cubit/new_product_cubit.dart';
import 'package:topsale/features/payments/cubit/payments_cubit.dart';
import 'package:topsale/features/products/cubit/products_cubit.dart';
import 'package:topsale/features/signup/cubit/signup_cubit.dart';

import 'core/utils/app_colors.dart';
import 'features/ receipt/cubit/receipt_cubit.dart';
import 'features/dismissal_notice/cubit/dismissal_notice_cubit.dart';
import 'features/expectet_clients_list/cubit/expected_clients_list_cubit.dart';
import 'features/forgot_password/cubit/forgot_password_cubit.dart';
import 'features/home/cubit/expected_clients_cubit/expected_clients_cubit.dart';
import 'features/home/cubit/itinerary_cubit/itinerary_cubit.dart';
import 'features/itinerary_details/cubit/itinerary_details_cubit.dart';
import 'features/login/cubit/login_cubit.dart';
import 'features/onboarding/cubit/onboarding_cubit.dart';
import 'features/product_of_category/cubit/cubit.dart';
import 'features/returns/cubit/returns_cubit.dart';
import 'features/returns_list/cubit/returns_list_cubit.dart';
import 'features/sales_ordered_list/cubit/sales_ordered_list_cubit.dart';
import 'injector.dart' as injector;

class TopSale extends StatelessWidget {
  const TopSale({super.key});
  @override
  Widget build(BuildContext context) {
    Preferences.instance
        .saveLanguage(EasyLocalization.of(context)!.locale.languageCode);
    // checkLocationPermission();
    return MultiBlocProvider(
      providers: [
        BlocProvider(
            create: (context) => injector.serviceLocator<OnBoardingCubit>()),
        BlocProvider(
            create: (context) => injector.serviceLocator<LoginCubit>()),
        BlocProvider(
            create: (context) => injector.serviceLocator<SignupCubit>()),
        BlocProvider(
            create: (context) =>
                injector.serviceLocator<ForgotPasswordCubit>()),
        BlocProvider(create: (context) => injector.serviceLocator<HomeCubit>()),
        BlocProvider(
            create: (context) => injector.serviceLocator<ProductsCubit>()),
        BlocProvider(
            create: (context) => injector.serviceLocator<NewProductCubit>()),
        BlocProvider(
            create: (context) =>
                injector.serviceLocator<CreateSalesOrderCubit>()),
        BlocProvider(
            create: (context) => injector.serviceLocator<PaymentsCubit>()),
        BlocProvider(
            create: (context) => injector.serviceLocator<ReceiptCubit>()),
        BlocProvider(
            create: (context) => injector.serviceLocator<ReturnsCubit>()),
        BlocProvider(
            create: (context) =>
                injector.serviceLocator<CustomerPaymentsCubit>()),
        BlocProvider(create: (context) => injector.serviceLocator<CartCubit>()),
        BlocProvider(
            create: (context) =>
                injector.serviceLocator<DismissalNoticeCubit>()),
        BlocProvider(
            create: (context) =>
                injector.serviceLocator<ExpectedClientsCubit>()),
        BlocProvider(
            create: (context) =>
                injector.serviceLocator<DismissalNoticeDetailsCubit>()),
        BlocProvider(
            create: (context) =>
                injector.serviceLocator<ExpectedClientsListCubit>()),
        BlocProvider(
            create: (context) => injector.serviceLocator<ItineraryCubit>()),
        BlocProvider(
            create: (context) =>
                injector.serviceLocator<ItineraryDetailsCubit>()),
        BlocProvider(
            create: (context) =>
                injector.serviceLocator<SalesOrderedListCubit>()),
        BlocProvider(
            create: (context) => injector.serviceLocator<ReturnsListCubit>()),
        BlocProvider(
            create: (context) =>
                injector.serviceLocator<ProductsOfCategoryCubit>()),
      ],
      child: MaterialApp(
        supportedLocales: context.supportedLocales,
        locale: context.locale,
        themeMode: ThemeMode.light,
        darkTheme: ThemeData.light(),
        localizationsDelegates: context.localizationDelegates,
        debugShowCheckedModeBanner: false,
        title: AppStrings.appName,
        onGenerateRoute: AppRoutes.onGenerateRoute,
        theme: ThemeData(
            scaffoldBackgroundColor: AppColors.primary,
            appBarTheme: AppBarTheme(
              backgroundColor: AppColors.primary,
            ),
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
            useMaterial3: true,
            textTheme: const TextTheme(
              displayLarge: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                  color: AppColors.white),
              displayMedium: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: AppColors.white),
              bodyMedium: TextStyle(
                  color: AppColors.white,
                  fontWeight: FontWeight.w600,
                  fontSize: 14),
              bodySmall: TextStyle(
                  color: AppColors.white,
                  fontWeight: FontWeight.w600,
                  fontSize: 12),
            )),
      ),
    );
  }
}
