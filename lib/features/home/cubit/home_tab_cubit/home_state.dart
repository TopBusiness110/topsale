part of 'home_cubit.dart';

@immutable
abstract class HomeState {}

class HomeInitial extends HomeState {}
class ChangingTabs extends HomeState {}
class GettingUserDataState extends HomeState {}
