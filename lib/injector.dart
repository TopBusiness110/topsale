import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:topsale/core/api/dio_consumer.dart';
import 'package:topsale/core/remote/service_api.dart';
import 'package:topsale/features/%20receipt/cubit/receipt_cubit.dart';
import 'package:topsale/features/cart/cart_cubit.dart';
import 'package:topsale/features/create_sales_order/cubit/create_sales_order_cubit.dart';
import 'package:topsale/features/customer_payments/cubit/customer_payments_cubit.dart';
import 'package:topsale/features/dismissal_notice/cubit/dismissal_notice_cubit.dart';
import 'package:topsale/features/home/cubit/home_tab_cubit/home_cubit.dart';
import 'package:topsale/features/login/cubit/login_cubit.dart';
import 'package:topsale/features/new_product/cubit/new_product_cubit.dart';
import 'package:topsale/features/onboarding/cubit/onboarding_cubit.dart';
import 'package:topsale/features/payments/cubit/payments_cubit.dart';
import 'package:topsale/features/products/cubit/products_cubit.dart';
import 'package:topsale/features/signup/cubit/signup_cubit.dart';

import 'core/api/app_interceptors.dart';
import 'core/api/base_api_consumer.dart';
import 'features/dismissal_notice_details/cubit/dismissal_notice_details_cubit.dart';
import 'features/expectet_clients_list/cubit/expected_clients_list_cubit.dart';
import 'features/forgot_password/cubit/forgot_password_cubit.dart';

import 'features/home/cubit/expected_clients_cubit/expected_clients_cubit.dart';
import 'features/home/cubit/itinerary_cubit/itinerary_cubit.dart';
import 'features/itinerary_details/cubit/itinerary_details_cubit.dart';
import 'features/returns/cubit/returns_cubit.dart';
import 'features/returns_list/cubit/returns_list_cubit.dart';
import 'features/sales_ordered_list/cubit/sales_ordered_list_cubit.dart';

final serviceLocator = GetIt.instance;
//*************** Blocs *****************
Future<void> setUp() async {
  // serviceLocator.registerFactory(
  //       () => LocaleCubit(
  //     changeLanguageUseCase: serviceLocator(),
  //     getSavedLanguageUseCase: serviceLocator(),
  //   ),
  // );
  serviceLocator.registerFactory(() => OnBoardingCubit(
      //serviceLocator(),
      ));
  serviceLocator.registerFactory(() => LoginCubit(
      //serviceLocator(),
      ));
  serviceLocator.registerFactory(() => SignupCubit(
      //serviceLocator(),
      ));
  serviceLocator.registerFactory(() => ForgotPasswordCubit(
      //serviceLocator(),
      ));
  serviceLocator.registerFactory(() => HomeCubit(
      //serviceLocator(),
      ));
  serviceLocator.registerFactory(() => ProductsCubit(
        serviceLocator(),
      ));
  serviceLocator.registerFactory(() => NewProductCubit(
      //serviceLocator(),
      ));
  serviceLocator.registerFactory(() => CreateSalesOrderCubit(
      //serviceLocator(),
      ));
  serviceLocator.registerFactory(() => PaymentsCubit(
      //serviceLocator(),
      ));
  serviceLocator.registerFactory(() => ReceiptCubit(
      //serviceLocator(),
      ));
  serviceLocator.registerFactory(() => ReturnsCubit(
      //serviceLocator(),
      ));
  serviceLocator.registerFactory(() => CustomerPaymentsCubit(
      //serviceLocator(),
      ));
  serviceLocator.registerFactory(() => CartCubit(
      //serviceLocator(),
      ));
  serviceLocator.registerFactory(() => DismissalNoticeCubit(
      //serviceLocator(),
      ));
  serviceLocator.registerFactory(() => ExpectedClientsCubit(
      //serviceLocator(),
      ));
  serviceLocator.registerFactory(() => DismissalNoticeDetailsCubit(
      //serviceLocator(),
      ));
  serviceLocator.registerFactory(() => ExpectedClientsListCubit(
      //serviceLocator(),
      ));
  serviceLocator.registerFactory(() => ItineraryCubit(
      //serviceLocator(),
      ));
  serviceLocator.registerFactory(() => ItineraryDetailsCubit(
      //serviceLocator(),
      ));
  serviceLocator.registerFactory(() => SalesOrderedListCubit(
      //serviceLocator(),
      ));
  serviceLocator.registerFactory(() => ReturnsListCubit(
      //serviceLocator(),
      ));
  //*********************************************
  // ! External
  // shared preferences

  final sharedPreferences = await SharedPreferences.getInstance();
  serviceLocator.registerLazySingleton(() => sharedPreferences);

  serviceLocator.registerLazySingleton(() => ServiceApi(serviceLocator()));

  serviceLocator.registerLazySingleton<BaseApiConsumer>(
      () => DioConsumer(client: serviceLocator()));
  serviceLocator.registerLazySingleton(() => AppInterceptors());

  // Dio
  serviceLocator.registerLazySingleton(
    () => Dio(
      BaseOptions(
        contentType: "application/x-www-form-urlencoded",
        headers: {
          "Accept": "application/json",
          'Content-Type': 'application/x-www-form-urlencoded',
        },
      ),
    ),
  );
  serviceLocator.registerLazySingleton(
    () => LogInterceptor(
      request: true,
      requestBody: true,
      requestHeader: true,
      responseBody: true,
      responseHeader: true,
      error: true,
    ),
  );
}
