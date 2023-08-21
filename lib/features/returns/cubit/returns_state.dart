part of 'returns_cubit.dart';

@immutable
abstract class ReturnsState {}

class ReturnsInitial extends ReturnsState {}
class SearchingResultsState extends ReturnsState {}
class SelectingNameState extends ReturnsState {}
class AddingProductState extends ReturnsState {}
class ClientCartFounded extends ReturnsState {}
class AddedState extends ReturnsState {}
class ProductRemoved extends ReturnsState {}
