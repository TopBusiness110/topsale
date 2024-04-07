import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:topsale/core/models/login_model.dart';
import 'package:topsale/core/preferences/preferences.dart';
import 'package:topsale/features/home/tabs/home_tab.dart';
import 'package:topsale/features/home/tabs/itinerary_tab.dart';
import 'package:topsale/features/home/tabs/more_tab.dart';

import '../../../../core/utils/app_assets.dart';
import '../../../expectet_clients_list/screens/expected_clients_list_screen.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeInitial());

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
  AuthModel? sharedUserData;
  getUserData() async {
    sharedUserData = await Preferences.instance.getUser();

    print(sharedUserData.toString());

    if (sharedUserData != null) {
      userName = sharedUserData!.result!.name!;
      userName = (sharedUserData!.result!.name != null
          ? sharedUserData!.result!.name
          : "loll")!;
//
      // if (sharedUserData!.data!.phone!.contains('+964'))
      //   phoneController.text = sharedUserData!.data!.phone!.replaceAll("+964", "");
      // else
      // phoneController.text = sharedUserData!.data!.phone!;
      // dateOfBirthController.text =
      //     sharedUserData!.data!.birth!.toString().substring(0, 10);
    }
    emit(GettingUserDataState());
  }
}
