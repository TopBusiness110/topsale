part of 'signup_cubit.dart';

@immutable
abstract class SignupState {}

class SignupInitial extends SignupState {}
class SuccessSignupState extends SignupState {}
class FailureSignupState extends SignupState {}
class LoadingSignupState extends SignupState {}