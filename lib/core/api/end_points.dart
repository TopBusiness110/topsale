class EndPoints{
  static const String baseUrl = "https://demo17.topbuziness.com";
  static const String db = "demo17.topbuziness.com";

  ///
  static const String auth = "$baseUrl/auth/";
  static const String allCategoriesUrl = "$baseUrl/api/product.category/";
  static const String allProducts =
      '$baseUrl/api/product.product/?query={id,name,qty_available,list_price,currency_id,uom_name,uom_id,categ_id,image_1920}&filter=[["sale_ok", "=", "True"]]';
  static const String authWithSession = "$baseUrl/web/session/authenticate";

  static const String allCategoryProducts = '$baseUrl/api/product.product/';
  static const String getUsers = '$baseUrl/api/res.partner';
  static const String addPartner = '$baseUrl/api/res.partner/';
  static const String newLead = '$baseUrl/api/crm.lead/';
  static const String createPicking = '$baseUrl/api/stock.picking/';
  static const String createStokeMove = '$baseUrl/api/stock.move';
  static const String fromLocation = '$baseUrl/api/stock.location/?query={id,name}&filter=[["usage", "=", "internal"]]';
  static const String toLocation = '$baseUrl//api/stock.location/?query={id,name}&filter=[["usage", "=", "internal"]]';

  static const String saleOrder = '$baseUrl/api/sale.order/';
  static const String saleOrderLine = '$baseUrl/api/sale.order.line';
  static const String getSaleOrder = '$baseUrl/api/sale.order/';
  static const String createPayment = '$baseUrl/api/account.payment/';
  static const String createInvoice = '$baseUrl/api/account.move/';
  static const String invoiceLine = '$baseUrl/api/account.move.line';
  static const String getAllJournals = '$baseUrl/api/account.journal/?query={id, display_name}&filter=[["payment_sequence", "=","true"]]';

}


//d