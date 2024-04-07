import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:odoo_rpc/odoo_rpc.dart';

import '../api/base_api_consumer.dart';
import '../api/end_points.dart';
import '../error/exceptions.dart';
import '../error/failures.dart';
import '../models/all_prodyucts_model.dart';
import '../models/category_model.dart';
import '../preferences/preferences.dart';
// import 'package:http/http.dart' as http;
import 'dart:io';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:topsale/core/preferences/preferences.dart';
import '../api/base_api_consumer.dart';
import '../api/end_points.dart';
import '../error/exceptions.dart';
import '../error/failures.dart';
import 'package:odoo_rpc/odoo_rpc.dart';
import 'package:http/http.dart' as http;

import '../models/login_model.dart';

class ServiceApi {
  final BaseApiConsumer dio;
  ServiceApi(this.dio);
  final odoo = OdooClient(EndPoints.baseUrl);
  Future<Either<Failure, AllProductsModel>> getAllProducts() async {
    try {
      // String? sessionId = 'f5d43568ee2efa5e9a4bb792fb8138a295600e78';
      String? sessionId = await Preferences.instance.getSessionId();
      final response = await dio.get(
        EndPoints.allProducts,
        options: Options(
          headers: {"Cookie": "frontend_lang=en_US;session_id=$sessionId"},
        ),
      );

      return Right(AllProductsModel.fromJson(response));
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  Future<String> getSessionId(
      {required String phone, required String password}) async {
    final odoResponse = await odoo.authenticate(EndPoints.db, phone, password);
    final sessionId = odoResponse.id;
    print("getSessionId = $sessionId");
    return sessionId;
  }

  Future<Either<Failure, AuthModel>> postLoginAsAdmin2(
      String phoneOrMail, String password) async {
    try {
      final response = await dio.post(
        EndPoints.auth,
        body: {
          "params": {
            'login': phoneOrMail,
            "password": password,
            "db": EndPoints.db
          },
        },
      );
      String sessionId =
          await getSessionId(phone: phoneOrMail, password: password);
      //String sessionId = await getSessionId(phone: "api", password: "api");
      await Preferences.instance.setSessionId(sessionId);
      await Preferences.instance.setUser2(AuthModel.fromJson(response));
      await Preferences.instance.isAdmin(true);
      return Right(AuthModel.fromJson(response));
    } on ServerException {
      return Left(ServerFailure());
    }
  }

///////////////////////////////////////////
  Future<Either<Failure, AllCategoriesModel>> getAllCategories() async {
    try {
      String? sessionId = await Preferences.instance.getSessionId();
      final response = await dio.get(
        EndPoints.allCategoriesUrl,
        options: Options(
          headers: {"Cookie": "frontend_lang=en_US;session_id=$sessionId"},
        ),
      );

      return Right(AllCategoriesModel.fromJson(response));
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  Future<Either<Failure, AllProductsModel>> getAllProductsByCategory(
      {required int categoryId}) async {
    try {
      String? sessionId = await Preferences.instance.getSessionId();
      final response = await dio.get(
        EndPoints.allCategoryProducts,
        queryParameters: {
          'filter': '[["categ_id", "=", [$categoryId]]]',
          'query':
              '{id,name,qty_available,list_price,currency_id,uom_name,uom_id,categ_id,image_1920}'
        },
        options: Options(
          headers: {"Cookie": "frontend_lang=en_US;session_id=$sessionId"},
        ),
      );

      return Right(AllProductsModel.fromJson(response));
    } on ServerException {
      return Left(ServerFailure());
    }
  }
//vhmcvmbvm
//   Future<Either<Failure, AuthModel>> postLoginAsAdmin2(
//       String phoneOrMail, String password) async {
//     try {
//       final response = await dio.post(
//         EndPoints.loginUrl,
//         body: {
//           "params": {
//             'login': phoneOrMail,
//             "password": password,
//             "db": "kreezmart.com"
//           },
//         },
//       );
//       String sessionId = await getSessionId(phone: "api", password: "api");

  Future<Either<Failure, AuthModel>> auth(
      String phoneOrMail, String password) async {
    try {
      final response = await dio.post(
        EndPoints.auth,
        body: {
          "params": {
            'login': phoneOrMail,
            "password": password,
            "db": EndPoints.db
          },
        },
      );
      // String sessionId =
      //     await getSessionId(phone: phoneOrMail, password: password);
      // await Preferences.instance.setSessionId(sessionId);

      //  await Preferences.instance.isAdmin(true);
      //  print(response.toString());
      return Right(AuthModel.fromJson(response));
    } on ServerException {
      print('ddddddddddd');
      return Left(ServerFailure());
    }
  }

  Future<Either<Failure, AuthModel>> authWithSession(
      String phoneOrMail, String password, String db) async {
    try {
      final response = await dio.post(
        EndPoints.authWithSession,
        body: {
          "jsonrpc": "2.0",
          "params": {
            "is_system": false,
            'login': phoneOrMail,
            "password": password,
            "db": db
          },
        },
      );
      // String sessionId =
      //     await getSessionId(phone: phoneOrMail, password: password);
      // await Preferences.instance.setSessionId(sessionId);

      //  await Preferences.instance.isAdmin(true);
      //  print(response.toString());
      return Right(AuthModel.fromJson(response));
    } on ServerException {
      print('ddddddddddd');
      return Left(ServerFailure());
    }
  }

/////////////////////////////////////////////////////
  Future<Either<Failure, AuthModel>> postLoginAsTrueUser2(
      String phoneOrMail, String password) async {
    try {
      //todo may be only session id
      String? sessionId = await Preferences.instance.getSessionIdTrueUser();
      final response = await dio.post(
        EndPoints.auth,
        options: Options(
          headers: {"Cookie": "session_id=$sessionId"},
        ),
        body: {
          "params": {
            'login': phoneOrMail,
            "password": password,
            "db": EndPoints.db
          },
        },
      );
      String? sessionId2 =
          await getSessionId(phone: phoneOrMail, password: password);
      await Preferences.instance.setSessionIdTruUser(sessionId2);
      await Preferences.instance.setUser2(AuthModel.fromJson(response));
      await Preferences.instance.isAdmin(false); //todo-->
      return Right(AuthModel.fromJson(response));
    } on ServerException {
      print('ddddddddddd');
      return Left(ServerFailure());
    }
  }

  int? partnerId;
  // Future<Either<Failure, AuthModel>> postRegister2(
  //     String fullName, String password, String phone, String? email) async {
  //   try {
  //     print("&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&#");
  //     String? sessionId = await Preferences.instance.getSessionId();
  //     print("####################################");
  //     print("sessionId =$sessionId ");
  //     final response = await dio.post(
  //       EndPoints.authWithSession,
  //       options: Options(
  //         headers: {"Cookie": "session_id=$sessionId"},
  //       ),
  //       body: {
  //         "params": {
  //           "data": {
  //             "name": fullName,
  //             'login': phone,
  //             "password": password,
  //             //"sel_groups_1_9_10":10
  //           }
  //         },
  //       },
  //     ).onError((error, stackTrace) {
  //       print("XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX");
  //       print("error is $error");
  //     });
  //     String? sessionId2 = await getSessionId(phone: phone, password: password);
  //     print("^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^6");
  //     print("sessionId2 = $sessionId2");
  //     await Preferences.instance.setSessionIdTruUser(sessionId2);
  //     await Preferences.instance.isAdmin(false);
  //     Either either = await postLoginAsTrueUser2(phone, password);
  //     AuthModel? authModel;
  //     either.fold((l) => null, (r) {
  //       authModel = r;
  //     });
  //     await Preferences.instance.setUser2(authModel!);
  //     UserData? result = AuthModel.fromJson(response).result;
  //     print("************************************************");
  //     print(result);
  //     UserData? userData;
  //    var data = await getUserData(result);
  //     data.fold((l) => null, (r) {
  //       userData = r;
  //       Preferences.instance.setPartnerId(userData!.result![0].partnerId!);
  //       //todo add partner id to shared preferences
  //     });
  //     partnerId = await Preferences.instance.getPartnerId();
  //     //  await Preferences.instance.setPartnerId(userData.result[0].id)
  //     print("!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!");
  //     print(userData);
  //     return Right(AuthModel.fromJson(response));
  //   } on ServerException {
  //     return Left(ServerFailure());
  //   }
  // }

//   Future<Either<Failure, UserData>> getUserData(int result) async {
//     try {
//       String? sessionId = await Preferences.instance.getSessionId();
//       final response = await dio.get(
//         EndPoints.getUserDateUrl +
//             '?query={id, name,partner_id}&filter=[["id","=","$result"]]',
//         options: Options(
//           headers: {"Cookie": "session_id=$sessionId"},
//         ),
//         // queryParameters: {
//         //   "query":"{id, name,partner_id}",
//         //   "filter":[["id","=","$result"]]
//         // }
//       );
//       return Right(UserData.fromJson(response));
//     } on ServerException {
//       return Left(ServerFailure());
//     }
//   }

//   Future<Either<Failure, CheckUserModel>> checkUser(String phone) async {
//     try {
//       String? sessionId = await Preferences.instance.getSessionId();
//       final response = await dio.get(
//         EndPoints.checkUserUrl +
//             "?query={id, name,partner_id}" +
//             '&filter=[["login","=","$phone"]]',
//         options: Options(
//           headers: {"Cookie": "session_id=$sessionId"},
//         ),
//         // queryParameters: {
//         //   "query":"{id, name,partner_id}",
//         //   "filter":[["login","=","0107777777"]]
//         // }
//       );
//       return Right(CheckUserModel.fromJson(response));
//     } on ServerException {
//       return Left(ServerFailure());
//     }
//   }

//   Future<Either<Failure, AllCategoriesModel>> getAllCategories() async {
//     try {
//       String? sessionId = await Preferences.instance.getSessionId();
//       final response = await dio.get(
//         EndPoints.allCategoriesUrl,
//         options: Options(
//           headers: {"Cookie": "session_id=$sessionId"},
//         ),
//       );

//       return Right(AllCategoriesModel.fromJson(response));
//     } on ServerException {
//       return Left(ServerFailure());
//     }
//   }

//   Future<Either<Failure, AllProductsModel>> getAllProducts() async {
//     try {
//       String? sessionId = await Preferences.instance.getSessionId();
//       final response = await dio.get(
//         EndPoints.allProductsUrl,
//         options: Options(
//           headers: {"Cookie": "session_id=$sessionId"},
//         ),
//       );

//       return Right(AllProductsModel.fromJson(response));
//     } on ServerException {
//       return Left(ServerFailure());
//     }
//   }

//   Future<Either<Failure, AuthModel>> createSaleOrder() async {
//     String? sessionId = await Preferences.instance.getSessionId();
//     AuthModel authModel = await Preferences.instance.getUserModel2();
//     print("*****************************************************");
//     print("session id  = $sessionId");
//     print("partner id  = ${authModel.result.partnerId}");
//     try {
//       final response = await dio.post(EndPoints.createSaleOrderUrl,
//           options: Options(
//             headers: {"Cookie": "frontend_lang=en_US;session_id=$sessionId"},
//           ),
//           body: {
//             "params": {
//               "data": {
//                 "partner_id": authModel.result!.partnerId,
//                 //  "partner_id": 66,
//                 "pricelist_id": 1,
//                 "team_id": 2,
//                 "website_id": 1
//                 // "partner_id":partnerId,
//                 // "pricelist_id": 1,
//                 // "team_id":2,
//                 // "website_id":1
//               }
//             }
//           }).onError((error, stackTrace) {
//         print("%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%");
//         print(error.toString());
//       });
//       var r = response;
//       print("_____________________________________________________");
//       print(response);
//       Preferences.instance.setSaleOrder(AuthModel.fromJson(response).result);

//       return Right(AuthModel.fromJson(response));
//     } on ServerException {
//       return Left(ServerFailure());
//     }
//   }

//   Future<Either<Failure, AuthModel>> createSaleOrderLines(
//       {required orderId,
//       required int productId,
//       required String productName,
//       required double productQuantity}) async {
//     String? sessionId = await Preferences.instance.getSessionId();

//     try {
//       final response = await dio.post(EndPoints.createSaleOrderLineUrl,
//           options: Options(
//             headers: {"Cookie": "session_id=$sessionId"},
//           ),
//           body: {
//             "params": {
//               "data": {
//                 "order_id": orderId,
//                 "product_id": productId,
//                 "name": productName,
//                 "product_uom_qty": productQuantity
//               }
//             }
//           });

//       return Right(AuthModel.fromJson(response));
//     } on ServerException {
//       return Left(ServerFailure());
//     }
//   }

//   Future<Either<Failure, GetAllSaleOrderModel>>
//       getAllSaleOrderForPartner() async {
//     try {
//       String? sessionId = await Preferences.instance.getSessionId();
//       AuthModel authModel = await Preferences.instance.getUserModel2();
//       final partnerId = authModel.result.partnerId;
//       final response = await dio.get(
//         EndPoints.getAllSaleOrderForPartnerUrl +
//             '?filter=[["partner_id", "=",$partnerId]]&query={id,display_name,state,write_date,amount_total}',
//         options: Options(
//           headers: {"Cookie": "session_id=$sessionId"},
//         ),
//         // queryParameters: {
//         //   "query":"{id,display_name,state,write_date,amount_total}",
//         //
//         // }
//       );
//       return Right(GetAllSaleOrderModel.fromJson(response));
//     } on ServerException {
//       return Left(ServerFailure());
//     }
//   }

//   Future<Either<Failure, ProductsByCategoryIdModel>> getProductsByCategoryId(
//       int categoryId) async {
//     try {
//       String? sessionId = await Preferences.instance.getSessionId();
//       final response = await dio.get(
//         'https://kreezmart.com/api/product.product/?query={id,name,list_price,currency_id,is_published,uom_name,uom_id,public_categ_ids,website_ribbon_id,description_sale,image_1920}&filter=[["public_categ_ids", "=", [$categoryId]]]',
//         // EndPoints.getProductsByCategoryIdUrl,
//         options: Options(
//           headers: {"Cookie": "session_id=$sessionId"},
//         ),
//         // queryParameters: {
//         //   "query" : "{id,name,list_price,currency_id,is_published,uom_name,uom_id,public_categ_ids,website_ribbon_id,description_sale,image_1920}",
//         //   "filter" : [["public_categ_ids=[$categoryId]"]]
//         // }
//       );
//       return Right(ProductsByCategoryIdModel.fromJson(response));
//     } on ServerException {
//       return Left(ServerFailure());
//     }
//   }

//   Future<Either<Failure, ProductsByCategoryIdModel>> searchProduct(
//       String keyWord) async {
//     try {
//       String? sessionId = await Preferences.instance.getSessionId();
//       final response = await dio.get(
//         'https://kreezmart.com/api/product.product/?query={id,name,list_price,currency_id,is_published,uom_name,uom_id,public_categ_ids,website_ribbon_id,description_sale,image_1920}&filter=[["name", "=like", "%$keyWord%"],["is_published", "=", true]]',
//         //EndPoints.searchProductUrl,
//         options: Options(
//           headers: {"Cookie": "session_id=$sessionId"},
//         ),
//         // queryParameters: {
//         //   "query" : "{id,name,list_price,currency_id,is_published,uom_name,uom_id,public_categ_ids,website_ribbon_id,description_sale,image_1920}",
//         //   "filter" : [["name", "=", "$keyWord"]]}
//       );
//       return Right(ProductsByCategoryIdModel.fromJson(response));
//     } on ServerException {
//       return Left(ServerFailure());
//     }
//   }
}
