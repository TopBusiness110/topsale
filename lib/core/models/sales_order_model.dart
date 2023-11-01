class SalesOrderModel{
  String billingNumber;
  DateTime creationDate;
  String customer;
  String status;
  double total;

  SalesOrderModel(
      {required this.billingNumber,required this.creationDate,required this.customer,required this.status,required this.total});
}