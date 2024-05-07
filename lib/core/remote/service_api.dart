import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:odoo_rpc/odoo_rpc.dart';
import 'package:topsale/core/models/all_journals_model.dart';
import 'package:topsale/core/models/all_leads_model.dart';
import 'package:topsale/core/models/allusers_model.dart';
import 'package:topsale/core/models/company_currency.dart';
import 'package:topsale/core/models/currency_name_model.dart';
import 'package:topsale/core/models/defaul_model.dart';
import 'package:topsale/core/models/get_all_orders.dart';
import 'package:topsale/core/models/get_location.dart';
import 'package:topsale/core/models/get_order_details_model.dart';
import 'package:topsale/core/models/get_orders_model.dart';
import 'package:topsale/core/models/get_partner_orders_model.dart';
import 'package:topsale/core/models/get_payment_by_id.dart';
import 'package:topsale/core/models/order_details_model.dart';
import 'package:topsale/core/models/partner_latlong_model.dart';
import 'package:topsale/core/models/update_payment_state_model.dart';
import 'package:topsale/core/models/user_data_model.dart';

import '../api/base_api_consumer.dart';
import '../api/end_points.dart';
import '../error/exceptions.dart';
import '../error/failures.dart';
import '../models/all_prodyucts_model.dart';
import '../models/category_model.dart';
import '../models/login_model.dart';
import '../preferences/preferences.dart';

class ServiceApi {
  final BaseApiConsumer dio;
  ServiceApi(this.dio);
  Future<Either<Failure, AllProductsModel>> getAllProducts(int page) async {
    try {
      // String? sessionId = '135b0fdbcf1b433641f448914ed5015d84a5c903';
      String? sessionId = await Preferences.instance.getSessionId();

      final response = await dio.get(
        EndPoints.allProducts + "page=$page",
        options: Options(
          headers: {"Cookie": "frontend_lang=en_US;session_id=$sessionId"},
        ),
      );
      print("lllllllllllll" + response.toString());
      return Right(AllProductsModel.fromJson(response));
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  Future<Either<Failure, AllProductsModel>> searchProducts(
      int page, String name) async {
    try {
      // String? sessionId = '135b0fdbcf1b433641f448914ed5015d84a5c903';
      String? sessionId = await Preferences.instance.getSessionId();

      final response = await dio.get(
        EndPoints.allProducts +
            'page=$page&filter=[["name", "=like", "%$name%"]]',
        options: Options(
          headers: {"Cookie": "frontend_lang=en_US;session_id=$sessionId"},
        ),
      );
      print("lllllllllllll" + response.toString());
      return Right(AllProductsModel.fromJson(response));
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  Future<String> getSessionId(
      {required String phone,
      required String password,
      String? baseUrl,
      String? database}) async {
    final odoo = OdooClient(baseUrl ?? EndPoints.baseUrl);

    final odoResponse =
        await odoo.authenticate(database ?? EndPoints.db, phone, password);

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

  Future<Either<Failure, GetCompanyCurrencyModel>> getCompanyCurrency() async {
    AuthModel authModel = await Preferences.instance.getUser();
    try {
      String? sessionId = await Preferences.instance.getSessionId();
      final response = await dio.get(
        EndPoints.companyCurecncy +
            'query={id, name,currency_id}&filter=[["id","=","${authModel.result!.userCompanies!.currentCompany!}"]]',
        options: Options(
          headers: {"Cookie": "frontend_lang=en_US;session_id=$sessionId"},
        ),
      );

      return Right(GetCompanyCurrencyModel.fromJson(response));
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  Future<Either<Failure, GetCurrencyNameModel>> getCurrencyName(
      int companyId) async {
    try {
      String? sessionId = await Preferences.instance.getSessionId();
      final response = await dio.get(
        EndPoints.currencyName +
            'query={id, name}&filter=[["id","=","$companyId"]]',
        options: Options(
          headers: {"Cookie": "frontend_lang=en_US;session_id=$sessionId"},
        ),
      );

      return Right(GetCurrencyNameModel.fromJson(response));
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

  Future<Either<Failure, AllUsersModel>> getAllUsers(
      int page, int pageSize) async {
    try {
      AuthModel authModel = await Preferences.instance.getUser();
      print("lllllllllll${authModel.result!.userSettings!.id}");

      String? sessionId = await Preferences.instance.getSessionId();
      final response = await dio.get(
        EndPoints.getUsers +
            '&page_size=$pageSize&page=$page&filter=[["user_id", "=",${authModel.result!.userContext!.uid}]]',
        options: Options(
          headers: {"Cookie": "frontend_lang=en_US;session_id=$sessionId"},
        ),
      );

      return Right(AllUsersModel.fromJson(response));
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  Future<Either<Failure, GetUserDataModel>> getUserData() async {
    try {
      AuthModel authModel = await Preferences.instance.getUser();
      print("lllllllllll${authModel.result!.userSettings!.id}");

      String? sessionId = await Preferences.instance.getSessionId();
      final response = await dio.get(
        EndPoints.getUserData +
            '&filter=[["id", "=","${authModel.result!.userContext!.uid}"]]',
        options: Options(
          headers: {"Cookie": "frontend_lang=en_US;session_id=$sessionId"},
        ),
      );

      return Right(GetUserDataModel.fromJson(response));
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
      String phoneOrMail, String password, String db) async {
    String? sessionId = await Preferences.instance.getSessionId();
    String sessionIddd =
        await getSessionId(phone: phoneOrMail, password: password);
    print('ddddddddddddd $sessionIddd');

    try {
      final response = await dio.post(
        EndPoints.auth,
        options: Options(
          headers: {"Cookie": "frontend_lang=en_US;session_id=$sessionId"},
        ),
        body: {
          "params": {'login': phoneOrMail, "password": password, "db": db},
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

  Future<Either<Failure, AuthModel>> authWithDB({
    required String phoneOrMail,
    required String password,
    required String db,
    required String name,
    required String odooLink,
  }) async {
    try {
      String? sessionId = await getSessionId(
          phone: phoneOrMail,
          password: password,
          baseUrl: odooLink,
          database: db);

      EndPoints.baseUrl = odooLink;
      EndPoints.db = db;
      final response = await dio.post(
        odooLink + "/auth/",
        options: Options(
          headers: {"Cookie": "frontend_lang=en_US;session_id=$sessionId"},
        ),
        body: {
          "params": {'login': phoneOrMail, "password": password, "db": db},
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

  Future<Either<Failure, DefaultModel>> createSaleOrder(int userId) async {
    String? sessionId = await Preferences.instance.getSessionId();
    AuthModel authModel = await Preferences.instance.getUser();
    print("*****************************************************");
    print("session id  = $sessionId");
    print("partner id  = ${authModel.result!.partnerId!}");
    try {
      final response = await dio.post(EndPoints.saleOrder,
          options: Options(
            headers: {"Cookie": "session_id=$sessionId"},
          ),
          body: {
            "params": {
              "data": {
                "partner_id": userId,

                "user_id": authModel.result!.userContext!.uid,
                "state": "sale",
                "type_name": "Sales Order",

                //  "partner_id": authModel.result!.partnerId,
                //   "pricelist_id": 1,
                //  "user_id":userId
                //"website_id": 1
                // "partner_id":partnerId,
                // "pricelist_id": 1,
                // "team_id":2,
                // "website_id":1
              }
            }
          }).onError((error, stackTrace) {
        print("%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%");
        print(error.toString());
      });
      var r = response;
      print("_____________________________________________________");
      print(response);
      // Preferences.instance.setSaleOrder(AuthModel.fromJson(response).result);
      return Right(DefaultModel.fromJson(response));
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  Future<Either<Failure, DefaultModel>> createSaleOrderLines(
      {required orderId,
      required int productId,
      required productQuantity}) async {
    String? sessionId = await Preferences.instance.getSessionId();
    try {
      final response = await dio.post(EndPoints.saleOrderLine,
          options: Options(
            headers: {"Cookie": "session_id=$sessionId"},
          ),
          body: {
            "params": {
              "data": {
                "order_id": orderId,
                "product_id": productId,
                "state": "sale",
                "product_uom_qty": productQuantity
              }
            }
          });
      return Right(DefaultModel.fromJson(response));
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  Future<Either<Failure, DefaultModel>> createPayment(
      {required partnerId, required journalId, required amount}) async {
    String? sessionId = await Preferences.instance.getSessionId();
    try {
      final response = await dio.post(EndPoints.createPayment,
          options: Options(
            headers: {"Cookie": "session_id=$sessionId"},
          ),
          body: {
            "params": {
              "data": {
                "partner_id": partnerId,
                "payment_type": "inbound",
                "partner_type": "customer",
                "journal_id": journalId,
                "amount": amount
              }
            }
          });
      return Right(DefaultModel.fromJson(response));
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  Future<Either<Failure, DefaultModel>> createInvoice({
    required partnerId,
  }) async {
    String? sessionId = await Preferences.instance.getSessionId();
    AuthModel authModel = await Preferences.instance.getUser();
    try {
      final response = await dio.post(EndPoints.createInvoice,
          options: Options(
            headers: {"Cookie": "session_id=$sessionId"},
          ),
          body: {
            "params": {
              "data": {
                "partner_id": partnerId,
                "journal_id": 1,
                "invoice_user_id": authModel.result!.userContext!.uid,
                "move_type": "out_invoice"
              }
            }
          });
      return Right(DefaultModel.fromJson(response));
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  Future<Either<Failure, DefaultModel>> invoiceLine(
      {required moveId, required productId, required quantity}) async {
    String? sessionId = await Preferences.instance.getSessionId();
    try {
      final response = await dio.post(EndPoints.invoiceLine,
          options: Options(
            headers: {"Cookie": "session_id=$sessionId"},
          ),
          body: {
            "params": {
              "data": {
                "move_id": moveId,
                "product_id": productId,
                "quantity": quantity
              }
            }
          });
      return Right(DefaultModel.fromJson(response));
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  Future<Either<Failure, DefaultModel>> createPartner(
      {required String name,
      required String mobile,
      required String street}) async {
    String? sessionId = await Preferences.instance.getSessionId();
    try {
      final response = await dio.post(EndPoints.addPartner,
          options: Options(
            headers: {"Cookie": "session_id=$sessionId"},
          ),
          body: {
            "params": {
              "data": {
                "name": name,
                "mobile": mobile,
                "street": street,
                //  "country_id": "2"
              }
            }
          });
      return Right(DefaultModel.fromJson(response));
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  Future<Either<Failure, DefaultModel>> addNewLead(
      {required String name,
      required String mobile,
      required String description,
      required int partnerId,
      required String street}) async {
    AuthModel authModel = await Preferences.instance.getUser();
    String? sessionId = await Preferences.instance.getSessionId();
    try {
      final response = await dio.post(EndPoints.newLead,
          options: Options(
            headers: {"Cookie": "session_id=$sessionId"},
          ),
          body: {
            "params": {
              "data": {
                "name": name,
                "partner_id": partnerId,
                "phone": mobile,
                "street": street,
                "expected_revenue": 0,
                "description": description,
                "user_id": authModel.result!.userContext!.uid
              }
            }
          });
      return Right(DefaultModel.fromJson(response));
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  Future<Either<Failure, GetAllLeadsModel>> getAllLeads() async {
    AuthModel authModel = await Preferences.instance.getUser();
    String? sessionId = await Preferences.instance.getSessionId();
    try {
      final response = await dio.get(
        EndPoints.newLead +
            '?query={name,create_date, description,street,phone}&filter=[["user_id", "=",${authModel.result!.userContext!.uid}]]',
        options: Options(
          headers: {"Cookie": "session_id=$sessionId"},
        ),
      );
      return Right(GetAllLeadsModel.fromJson(response));
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  ///////// orders
  Future<Either<Failure, GetOrdersModel>> getOrders() async {
    AuthModel authModel = await Preferences.instance.getUser();
    String? sessionId = await Preferences.instance.getSessionId();
    try {
      final response = await dio.get(
        EndPoints.saleOrder +
            '?query={id,partner_id,display_name,state,write_date,amount_total}&filter=[["user_id", "=",${authModel.result!.userContext!.uid}]]',
        // '?query={id,partner_id,display_name,state,write_date,amount_total}&filter=[["user_id", "=",1]]',
        options: Options(
          headers: {"Cookie": "session_id=$sessionId"},
        ),
      );
      return Right(GetOrdersModel.fromJson(response));
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  Future<Either<Failure, GetOrderDetailsModel>> getOrderDetails(
      int orderId) async {
    String? sessionId = await Preferences.instance.getSessionId();
    try {
      final response = await dio.get(
        EndPoints.saleOrderLine +
            '?query={ name,product_uom_qty,product_uom}&filter=[["order_id", "=", $orderId]]',
        options: Options(
          headers: {"Cookie": "session_id=$sessionId"},
        ),
      );
      return Right(GetOrderDetailsModel.fromJson(response));
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  Future<Either<Failure, GetPartnerLatLongModel>> getPartnerLatLong(
      int partnerId) async {
    String? sessionId = await Preferences.instance.getSessionId();
    try {
      final response = await dio.get(
        EndPoints.addPartner +
            '?query={ name,partner_latitude,partner_longitude}&filter=[["id","=","$partnerId"]]',
        options: Options(
          headers: {"Cookie": "session_id=$sessionId"},
        ),
      );
      return Right(GetPartnerLatLongModel.fromJson(response));
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  Future<Either<Failure, GetSaleOrderForPartnerModel>> getAllSaleOrderForMan(
      int partnerId) async {
    String? sessionId = await Preferences.instance.getSessionId();
    try {
      final response = await dio.get(
        EndPoints.saleOrder +
            '?filter=[["partner_id", "=",$partnerId]]&query={id,display_name,state,write_date,amount_total}',
        options: Options(
          headers: {"Cookie": "session_id=$sessionId"},
        ),
      );
      return Right(GetSaleOrderForPartnerModel.fromJson(response));
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  Future<Either<Failure, GetManOrderDetailsModel>> getAllSaleOrderForManDetails(
      int orderId) async {
    String? sessionId = await Preferences.instance.getSessionId();
    try {
      final response = await dio.get(
        EndPoints.saleOrderLine +
            '?filter=[["order_id", "=",$orderId]]&query={id,name,display_name,product_id,product_uom_qty,order_id}',
        options: Options(
          headers: {"Cookie": "session_id=$sessionId"},
        ),
      );
      return Right(GetManOrderDetailsModel.fromJson(response));
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  Future<Either<Failure, GetLocationModel>> getfromLocations() async {
    // AuthModel authModel = await Preferences.instance.getUser();
    String? sessionId = await Preferences.instance.getSessionId();
    try {
      final response = await dio.get(
        EndPoints.fromLocation,
        options: Options(
          headers: {"Cookie": "session_id=$sessionId"},
        ),
      );
      return Right(GetLocationModel.fromJson(response));
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  Future<Either<Failure, GetLocationModel>> getToLocations() async {
    // AuthModel authModel = await Preferences.instance.getUser();
    String? sessionId = await Preferences.instance.getSessionId();
    try {
      final response = await dio.get(
        EndPoints.toLocation,
        options: Options(
          headers: {"Cookie": "session_id=$sessionId"},
        ),
      );
      return Right(GetLocationModel.fromJson(response));
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  Future<Either<Failure, DefaultModel>> createPicking({
    required int fromLocationId,
    required int toLocationId,
  }) async {
    //  AuthModel authModel = await Preferences.instance.getUser();
    String? sessionId = await Preferences.instance.getSessionId();
    try {
      final response = await dio.post(EndPoints.createPicking,
          options: Options(
            headers: {"Cookie": "session_id=$sessionId"},
          ),
          body: {
            "params": {
              "data": {
                "picking_type_id": 5,
                "location_id": fromLocationId,
                "location_dest_id": toLocationId
              }
            }
          });
      return Right(DefaultModel.fromJson(response));
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  Future<Either<Failure, DefaultModel>> createStockMove({
    required int fromLocationId,
    required int toLocationId,
    required int productId,
    required int qty,
    required int pickingId,
    required String name,
  }) async {
    //  AuthModel authModel = await Preferences.instance.getUser();
    String? sessionId = await Preferences.instance.getSessionId();
    try {
      final response = await dio.post(EndPoints.createStokeMove,
          options: Options(
            headers: {"Cookie": "session_id=$sessionId"},
          ),
          body: {
            "params": {
              "data": {
                "name": name,
                "location_id": fromLocationId,
                "location_dest_id": toLocationId,
                "product_id": productId,
                "product_uom_qty": qty,
                "picking_id": pickingId
              }
            }
          });
      return Right(DefaultModel.fromJson(response));
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  Future<Either<Failure, GetAllOrdersModel>> getAllSaleOrderForPartner() async {
    try {
      String? sessionId = await Preferences.instance.getSessionId();
      AuthModel authModel = await Preferences.instance.getUser();
      final userId = authModel.result!.userSettings!.id;
      final response = await dio.get(
        EndPoints.saleOrder +
            '?filter=[["user_id", "=",$userId]]&query={id,partner_id,display_name,state,write_date,amount_total}',
        options: Options(
          headers: {"Cookie": "session_id=$sessionId"},
        ),
        // queryParameters: {
        //   "query":"{id,display_name,state,write_date,amount_total}",
        //
        // }
      );
      return Right(GetAllOrdersModel.fromJson(response));
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  Future<Either<Failure, GetAllJournalsModel>> getAllJournals() async {
    try {
      String? sessionId = await Preferences.instance.getSessionId();

      final response = await dio.get(
        EndPoints.getAllJournals,
        options: Options(
          headers: {"Cookie": "session_id=$sessionId"},
        ),
      );
      return Right(GetAllJournalsModel.fromJson(response));
    } on ServerException {
      return Left(ServerFailure());
    }
  }

//////////////  مدفوعات العملاء

  Future<Either<Failure, DefaultModel>> createPaymentMethod(
      {required partnerId,
      required journalId,
      required amount,
      required String ref,
      required String date}) async {
    String? sessionId = await Preferences.instance.getSessionId();
    try {
      final response = await dio.post(EndPoints.createPayment,
          options: Options(
            headers: {"Cookie": "session_id=$sessionId"},
          ),
          body: {
            "params": {
              "data": {
                "partner_id": partnerId,
                "payment_type": "inbound",
                "partner_type": "customer",
                "journal_id": journalId,
                "amount": amount,
                "ref": ref,
                "date": date
              }
            }
          });
      return Right(DefaultModel.fromJson(response));
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  Future<Either<Failure, GetPaymentByIdModel>> getPaymentById(
      {required int paymentId}) async {
    try {
      String? sessionId = await Preferences.instance.getSessionId();

      final response = await dio.get(
        EndPoints.createPayment +
            '?query={move_id}&filter=[["id", "=",$paymentId]]',
        options: Options(
          headers: {"Cookie": "session_id=$sessionId"},
        ),
      );
      return Right(GetPaymentByIdModel.fromJson(response));
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  Future<Either<Failure, UpdatePaymentStateModel>> updatePaymentState(
      {required int paymentId}) async {
    String? sessionId = await Preferences.instance.getSessionId();
    try {
      final response = await dio.put(EndPoints.createInvoice,
          options: Options(
            headers: {"Cookie": "session_id=$sessionId"},
          ),
          body: {
            "params": {
              "filter": [
                ["id", "=", paymentId]
              ],
              "data": {"state": "posted"}
            }
          });
      return Right(UpdatePaymentStateModel.fromJson(response));
    } on ServerException {
      return Left(ServerFailure());
    }
  }

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
