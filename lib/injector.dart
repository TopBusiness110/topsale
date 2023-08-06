

import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:topsale/core/api/dio_consumer.dart';
import 'package:topsale/core/remote/service_api.dart';

import 'core/api/base_api_consumer.dart';

final serviceLocator = GetIt.instance;
//*************** Blocs *****************
Future<void> setUp()async{
  // serviceLocator.registerFactory(
  //       () => LocaleCubit(
  //     changeLanguageUseCase: serviceLocator(),
  //     getSavedLanguageUseCase: serviceLocator(),
  //   ),
  // );
  // serviceLocator.registerFactory(
  //       () => LoginCubit(
  //     serviceLocator(),
  //   ),
  // );

  //*********************************************
  // ! External
  // shared preferences
  final sharedPreferences = await SharedPreferences.getInstance();
  serviceLocator.registerLazySingleton(() => sharedPreferences);
  serviceLocator.registerLazySingleton(() =>ServiceApi(serviceLocator()) );
  serviceLocator.registerLazySingleton<BaseApiConsumer>(
          () => DioConsumer(dioClient: serviceLocator()));

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