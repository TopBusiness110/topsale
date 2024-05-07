import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:topsale/core/models/company_currency.dart';
import 'package:topsale/core/models/currency_name_model.dart';
import 'package:topsale/core/models/login_model.dart';
import 'package:topsale/core/models/user_data_model.dart';
import 'package:topsale/core/preferences/preferences.dart';
import 'package:topsale/core/remote/service_api.dart';
import 'package:topsale/features/home/tabs/home_tab.dart';
import 'package:topsale/features/home/tabs/itinerary_tab.dart';
import 'package:topsale/features/home/tabs/more_tab.dart';

import '../../../../core/utils/app_assets.dart';
import '../../../expectet_clients_list/screens/expected_clients_list_screen.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit(this.api) : super(HomeInitial());
  ServiceApi api;

  int currentIndex = 0;
  List<String> titles = [
    "products",
    "sales",
    "returns",
    "customer_payments",
    "dismissal_notice"
  ];
  List<String> imagesPath = [
    AssetsManager.packageDelivery,
    AssetsManager.deliveryTruck,
    AssetsManager.cashFlow,
    AssetsManager.budget,
    AssetsManager.order
  ];
  List<Widget> tabs = [
    HomeTab(),
    ExpectedClientsListScreen(),
    ItineraryTab(),
    MoreTab()
  ];
  changeTabs(int value) {
    currentIndex = value;
    emit(ChangingTabs());
  }

  String userName = '';
  String email = '';
  String profileImage = 'false';
  String currencyName = '';
  AuthModel? sharedUserData;

  GetUserDataModel? getUserDataModel;
  getUserData() async {
    emit(LoadingGettingUserDataState());

    final response = await api.getUserData();
    response.fold((l) {
      emit(FailureGettingUserDataState());
    }, (r) {
      getUserDataModel = r;
      userName = r.result![0].name!;
      email = r.result![0].login!;
      profileImage = r.result![0].image1920!.toString();
      print('555555555555555 $profileImage');

      emit(SuccessGettingUserDataState());
    });
  }

//   getUserData() async {
//     sharedUserData = await Preferences.instance.getUser();

//     print(sharedUserData.toString());

//     if (sharedUserData != null) {
//       userName = sharedUserData!.result!.name!;
//       userName = (sharedUserData!.result!.name != null
//           ? sharedUserData!.result!.name
//           : "loll")!;
// email =(sharedUserData!.result!.username != null
//           ? sharedUserData!.result!.username
//           : "")!;
// //
//       // if (sharedUserData!.data!.phone!.contains('+964'))
//       //   phoneController.text = sharedUserData!.data!.phone!.replaceAll("+964", "");
//       // else
//       // phoneController.text = sharedUserData!.data!.phone!;
//       // dateOfBirthController.text =
//       //     sharedUserData!.data!.birth!.toString().substring(0, 10);
//     }
//     emit(GettingUserDataState());
//   }

  GetCompanyCurrencyModel? companyCurrencyNameModel;
  getCompanyCurrency() async {
    emit(LoadingCompanyCurrencyState());
    // authModel = await Preferences.instance.getUserModel2();
    final response = await api.getCompanyCurrency();
    response.fold((l) => emit(FailureCompanyCurrencyState()), (r) {
      emit(SuccessAllCompanyCurrencyState());
      companyCurrencyNameModel = r;

      getCurrencyName();
      print("***************************************************");
      print(r);
      print("**************************${r.result}");
      // r.result!.map((e) => print(e.image1920));
    });
  }

  GetCurrencyNameModel? getCurrencyNameModel;
  getCurrencyName() async {
    emit(LoadingCompanyCurrencyState());
    // authModel = await Preferences.instance.getUserModel2();
    final response = await api
        .getCurrencyName(companyCurrencyNameModel!.result![0].currencyId!);
    response.fold((l) => emit(FailureCompanyCurrencyState()), (r) {
      emit(SuccessAllCompanyCurrencyState());
      getCurrencyNameModel = r;
      currencyName = r.result![0].name!;

      print("***************************************************");
      print(r);
      print("**************************${r.result}");
    });
  }
}
