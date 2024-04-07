part of 'login_cubit.dart';

@immutable
abstract class LoginState {}

class LoginInitial extends LoginState {}
class SuccessLoginState extends LoginState {}
class FailureLoginState extends LoginState {}
class LoadingLoginState extends LoginState {}