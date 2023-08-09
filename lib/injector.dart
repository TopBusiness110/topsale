

import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:topsale/core/api/dio_consumer.dart';
import 'package:topsale/core/remote/service_api.dart';
import 'package:topsale/features/create_sales_order/cubit/create_sales_order_cubit.dart';
import 'package:topsale/features/create_sales_order/screens/create_sales_order.dart';
import 'package:topsale/features/home/cubit/home_cubit.dart';
import 'package:topsale/features/login/cubit/login_cubit.dart';
import 'package:topsale/features/new_product/cubit/new_product_cubit.dart';
import 'package:topsale/features/onboarding/cubit/onboarding_cubit.dart';
import 'package:topsale/features/products/cubit/products_cubit.dart';
import 'package:topsale/features/signup/cubit/signup_cubit.dart';

import 'core/api/base_api_consumer.dart';
import 'features/forgot_password/cubit/forgot_password_cubit.dart';

final serviceLocator = GetIt.instance;
//*************** Blocs *****************
Future<void> setUp()async{
  // serviceLocator.registerFactory(
  //       () => LocaleCubit(
  //     changeLanguageUseCase: serviceLocator(),
  //     getSavedLanguageUseCase: serviceLocator(),
  //   ),
  // );
  serviceLocator.registerFactory(
        () => OnBoardingCubit(
      //serviceLocator(),
    )
   );
  serviceLocator.registerFactory(
          () => LoginCubit(
        //serviceLocator(),
      )
  );
  serviceLocator.registerFactory(
          () => SignupCubit(
        //serviceLocator(),
      )
  );  serviceLocator.registerFactory(
          () => ForgotPasswordCubit(
        //serviceLocator(),
      )
  );
  serviceLocator.registerFactory(
          () => HomeCubit(
        //serviceLocator(),
      )
  );
  serviceLocator.registerFactory(
          () => ProductsCubit(
        //serviceLocator(),
      )
  );
  serviceLocator.registerFactory(
          () => NewProductCubit(
        //serviceLocator(),
      )
  );
  serviceLocator.registerFactory(
          () => CreateSalesOrderCubit(
        //serviceLocator(),
      )
  );

  //*********************************************
  // ! External
  // shared preferences
  final sharedPreferences = await SharedPreferences.getInstance();
  serviceLocator.registerLazySingleton(() => sharedPreferences);
  serviceLocator.registerLazySingleton(() =>ServiceApi(serviceLocator()) );
  serviceLocator.registerLazySingleton<BaseApiConsumer>(
          () => DioConsumer(client: serviceLocator()));

  serviceLocator.registerLazySingleton(() =>
      Dio(
        BaseOptions(
          contentType: "application/x-www-form-urlencoded",
          headers: {
            "Accept": "application/json",
            'Content-Type': 'application/x-www-form-urlencoded',
          },
        ),
      ),);

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