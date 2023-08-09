import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:meta/meta.dart';

part 'onboarding_state.dart';

class OnBoardingCubit extends Cubit<OnBoardingState> {
  OnBoardingCubit() : super(OnBoardingInitial());

  PageController pageController = PageController(initialPage: 0) ;
  int numPages = 2 ;
  double currentPage = 0;

  changePages(){
    currentPage = pageController.page!;
    emit(ChangingPagesState());

  }

  onPageChanged(int page){
    currentPage = page.toDouble();
    emit(ChangingPagesState());

  }


}
