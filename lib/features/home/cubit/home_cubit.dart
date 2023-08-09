import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:topsale/features/home/tabs/delivery_orders_tab.dart';
import 'package:topsale/features/home/tabs/home_tab.dart';
import 'package:topsale/features/home/tabs/itinerary_tab.dart';
import 'package:topsale/features/home/tabs/more_tab.dart';

import '../../../core/utils/app_assets.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeInitial());

  int currentIndex = 0 ;
  List<String> titles = ["products","sales","returns","customer_payments","dismissal_notice"];
  List<String> imagesPath = [ImageAssets.packageDelivery,ImageAssets.deliveryTruck,ImageAssets.cashFlow,ImageAssets.budget,ImageAssets.order];
  List<Widget> tabs=[HomeTab(),DeliveryOrdersTab(),ItineraryTab(),MoreTab()];
  changeTabs(int value){
currentIndex = value ;
emit(ChangingTabs());
  }
}
