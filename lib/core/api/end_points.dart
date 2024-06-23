import 'package:topsale/core/preferences/preferences.dart';

class EndPoints {
  //static const String baseUrl = "https://demo17.topbuziness.com";
  static String baseUrl = "";
  static String db = "demo17.topbuziness.com";

  ///
  static String auth = "$baseUrl/auth/";
  static String allCategoriesUrl =
      "$baseUrl/api/product.category?query={id,name,display_name}";
  static String allProducts =
      '$baseUrl/api/product.product/';
  static String authWithSession = "$baseUrl/web/session/authenticate";

  static String allCategoryProducts = '$baseUrl/api/product.product/';
  static String getUsers =
      '$baseUrl/api/res.partner?query={name,mobile,id, city,street,phone,is_company}';
  static String getAllPartners =
      '$baseUrl/api/res.partner?';
      // '$baseUrl/api/res.partner?query={name,id, phone,total_overdue,total_due,total_invoiced,sale_order_ids,credit_to_invoice}';
  static String getUserData =
      '$baseUrl/api/res.users/?query={id, name,partner_id,image_1920,login}';
  static String addPartner = '$baseUrl/api/res.partner/';
  static String newLead = '$baseUrl/api/crm.lead/';
  static String companyData = '$baseUrl/api/res.company/?';
  static String currencyName = '$baseUrl/api/res.currency/?';
  static String createPicking = '$baseUrl/api/stock.picking/';
  static String objectSaleOrder = '$baseUrl/object/sale.order/';
  static String objectAccountMove = '$baseUrl/object/account.move/';
  static String createStokeMove = '$baseUrl/api/stock.move';
  static String getTaxes =
      '$baseUrl/api/account.tax/?query={id, display_name}&';
  static String fromLocation =
      '$baseUrl/api/stock.location/?query={id,name}&filter=[["usage", "=", "internal"]]';
  static String toLocation =
      '$baseUrl//api/stock.location/?query={id,name}&filter=[["usage", "=", "internal"]]';

  static String saleOrder = '$baseUrl/api/sale.order/';
  static String wareHouse = '$baseUrl/api/stock.warehouse/';
  static String saleOrderLine = '$baseUrl/api/sale.order.line';
  static String getSaleOrder = '$baseUrl/api/sale.order/';
  static String createPayment = '$baseUrl/api/account.payment/';
  static String confirmPayment = '$baseUrl/object/account.payment/';
  static String createInvoice = '$baseUrl/api/account.move/';
  static String invoiceLine = '$baseUrl/api/account.move.line';
  static String getAllJournals =
      '$baseUrl/api/account.journal/?query={id, display_name}';
}


//d