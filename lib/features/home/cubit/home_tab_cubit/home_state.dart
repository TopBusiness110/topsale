part of 'home_cubit.dart';

@immutable
abstract class HomeState {}

class HomeInitial extends HomeState {}

class ChangingTabs extends HomeState {}

class LoadingGettingUserDataState extends HomeState {}
class FailureGettingUserDataState extends HomeState {}
class SuccessGettingUserDataState extends HomeState {}
class GettingUserDataState extends HomeState {}

class LoadingCompanyCurrencyState extends HomeState {}

class FailureCompanyCurrencyState extends HomeState {}

class SuccessAllCompanyCurrencyState extends HomeState {}
