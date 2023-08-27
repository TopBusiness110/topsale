class CatchReceiptModel{
  String date;
  String clientName;
  String? memo;
  double amount;
  String paymentMethod;

  CatchReceiptModel(
      { required this.clientName,required this.paymentMethod ,required this.date, this.memo,required this.amount});
}