class AllProductsModel {
  int? count;
  dynamic prev;
  int? current;
  dynamic next;
  int? totalPages;
  List<ProductModelData>? result;

  AllProductsModel({
    this.count,
    this.prev,
    this.current,
    this.next,
    this.totalPages,
    this.result,
  });

  factory AllProductsModel.fromJson(Map<String, dynamic> json) =>
      AllProductsModel(
        count: json["count"],
        prev: json["prev"],
        current: json["current"],
        next: json["next"],
        totalPages: json["total_pages"],
        result: json["result"] == null
            ? []
            : List<ProductModelData>.from(
                json["result"]!.map((x) => ProductModelData.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "count": count,
        "prev": prev,
        "current": current,
        "next": next,
        "total_pages": totalPages,
        "result": result == null
            ? []
            : List<dynamic>.from(result!.map((x) => x.toJson())),
      };
}

class ProductModelData {
  int? id;
  String? name;
  double? listPrice;
  int? currencyId;
  String? uomName;
  int? uomId;
  int? categId;
  int userOrderedQuantity;
  dynamic qty_available;
  dynamic image1920;

  ProductModelData({
    this.id,
    this.name,
    this.listPrice,
    this.currencyId,
    this.uomName,
    this.uomId,
    this.categId,
    this.qty_available,
    this.image1920,
    this.userOrderedQuantity = 0,
  });

  factory ProductModelData.fromJson(Map<String, dynamic> json) =>
      ProductModelData(
        id: json["id"],
        name: json["name"],
        listPrice: json["list_price"]?.toDouble(),
        currencyId: json["currency_id"],
        uomName: json["uom_name"]!,
        uomId: json["uom_id"],
        qty_available: json["qty_available"],
        categId: json["categ_id"],
        image1920: json["image_1920"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "list_price": listPrice,
        "currency_id": currencyId,
        "uom_name": uomName,
        "qty_available": qty_available,
        "uom_id": uomId,
        "categ_id": categId,
        "image_1920": image1920,
      };
}
