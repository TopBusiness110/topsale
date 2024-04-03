class EndPoints {
  static const String baseUrl = "https://demo17.topbuziness.com";

  ///
  static const String auth = "$baseUrl/auth/";
  static const String allCategoriesUrl = "$baseUrl/api/product.category/";
  static const String allProducts =
      '$baseUrl/api/product.product/?query={id,name,qty_available,list_price,currency_id,uom_name,uom_id,categ_id,image_1920}&filter=[["sale_ok", "=", "True"]]';
}
