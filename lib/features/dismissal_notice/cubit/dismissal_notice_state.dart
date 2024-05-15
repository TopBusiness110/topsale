part of 'dismissal_notice_cubit.dart';

@immutable
abstract class DismissalNoticeState {}

class DismissalNoticeInitial extends DismissalNoticeState {}
class ChangingStockState extends DismissalNoticeState {}
class AddDismissalProductsState extends DismissalNoticeState {}
class RemoveDismissalProductsState extends DismissalNoticeState {}
class FailureGetToLocationsState extends DismissalNoticeState {}
class LoadingGetToLocationsState extends DismissalNoticeState {}
class SuccessGetToLocationsState extends DismissalNoticeState {}
class FailureGetFromLocationsState extends DismissalNoticeState {}
class LoadingGetFromLocationsState extends DismissalNoticeState {}
class SuccessGetFromLocationsState extends DismissalNoticeState {}
class FailureCreatePickingState extends DismissalNoticeState {}
class LoadingCreatePickingState extends DismissalNoticeState {}
class SuccessCreatePickingState extends DismissalNoticeState {}
class FailureCreateStockMoveState extends DismissalNoticeState {}
class LoadingCreateStockMoveState extends DismissalNoticeState {}
class SuccessCreateStockMoveState extends DismissalNoticeState {}
class LoadingAllProductsState extends DismissalNoticeState {}
class Loading2AllProductsState extends DismissalNoticeState {}

class AllProductsFailureState extends DismissalNoticeState {}

class AllProductsSuccessState extends DismissalNoticeState {}
class AddProductsState extends DismissalNoticeState {}

class RemoveProductsState extends DismissalNoticeState {}