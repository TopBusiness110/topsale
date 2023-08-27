part of 'dismissal_notice_cubit.dart';

@immutable
abstract class DismissalNoticeState {}

class DismissalNoticeInitial extends DismissalNoticeState {}
class ChangingStockState extends DismissalNoticeState {}
class AddDismissalProductsState extends DismissalNoticeState {}
class RemoveDismissalProductsState extends DismissalNoticeState {}
