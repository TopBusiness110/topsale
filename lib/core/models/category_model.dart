class AllCategoriesModel {
  int? count;
  dynamic prev;
  int? current;
  dynamic next;
  int? totalPages;
  List<CategoriesModelData>? result;

  AllCategoriesModel({
    this.count,
    this.prev,
    this.current,
    this.next,
    this.totalPages,
    this.result,
  });

  factory AllCategoriesModel.fromJson(Map<String, dynamic> json) =>
      AllCategoriesModel(
        count: json["count"],
        prev: json["prev"],
        current: json["current"],
        next: json["next"],
        totalPages: json["total_pages"],
        result: json["result"] == null
            ? []
            : List<CategoriesModelData>.from(
                json["result"]!.map((x) => CategoriesModelData.fromJson(x))),
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

class CategoriesModelData {
  String? name;
  String? completeName;
  dynamic parentId;
  String? parentPath;
  List<int>? childId;
  int? productCount;
  List<dynamic>? productPropertiesDefinition;
  int? id;
  String? displayName;
  int? createUid;
  dynamic createDate;
  int? writeUid;
  dynamic writeDate;
  int? propertyAccountIncomeCategId;
  int? propertyAccountExpenseCategId;
  List<dynamic>? routeIds;
  bool? removalStrategyId;
  List<dynamic>? totalRouteIds;
  List<dynamic>? putawayRuleIds;
  dynamic packagingReserveMethod;
  bool? filterForStockPutawayRule;
  dynamic propertyValuation;
  dynamic propertyCostMethod;
  int? propertyStockJournal;
  dynamic propertyStockAccountInputCategId;
  dynamic propertyStockAccountOutputCategId;
  dynamic propertyStockValuationAccountId;
  bool? propertyAccountCreditorPriceDifferenceCateg;
  bool? isShopifyProductCat;

  CategoriesModelData({
    this.name,
    this.completeName,
    this.parentId,
    this.parentPath,
    this.childId,
    this.productCount,
    this.productPropertiesDefinition,
    this.id,
    this.displayName,
    this.createUid,
    this.createDate,
    this.writeUid,
    this.writeDate,
    this.propertyAccountIncomeCategId,
    this.propertyAccountExpenseCategId,
    this.routeIds,
    this.removalStrategyId,
    this.totalRouteIds,
    this.putawayRuleIds,
    this.packagingReserveMethod,
    this.filterForStockPutawayRule,
    this.propertyValuation,
    this.propertyCostMethod,
    this.propertyStockJournal,
    this.propertyStockAccountInputCategId,
    this.propertyStockAccountOutputCategId,
    this.propertyStockValuationAccountId,
    this.propertyAccountCreditorPriceDifferenceCateg,
    this.isShopifyProductCat,
  });

  factory CategoriesModelData.fromJson(Map<String, dynamic> json) =>
      CategoriesModelData(
        name: json["name"],
        completeName: json["complete_name"],
        parentId: json["parent_id"],
        parentPath: json["parent_path"],
        childId: json["child_id"] == null
            ? []
            : List<int>.from(json["child_id"]!.map((x) => x)),
        productCount: json["product_count"],
        productPropertiesDefinition:
            json["product_properties_definition"] == null
                ? []
                : List<dynamic>.from(
                    json["product_properties_definition"]!.map((x) => x)),
        id: json["id"],
        displayName: json["display_name"],
        createUid: json["create_uid"],
        createDate: json["create_date"]!,
        writeUid: json["write_uid"],
        writeDate: json["write_date"]!,
        propertyAccountIncomeCategId: json["property_account_income_categ_id"],
        propertyAccountExpenseCategId:
            json["property_account_expense_categ_id"],
        routeIds: json["route_ids"] == null
            ? []
            : List<dynamic>.from(json["route_ids"]!.map((x) => x)),
        removalStrategyId: json["removal_strategy_id"],
        totalRouteIds: json["total_route_ids"] == null
            ? []
            : List<dynamic>.from(json["total_route_ids"]!.map((x) => x)),
        putawayRuleIds: json["putaway_rule_ids"] == null
            ? []
            : List<dynamic>.from(json["putaway_rule_ids"]!.map((x) => x)),
        packagingReserveMethod: json["packaging_reserve_method"]!,
        filterForStockPutawayRule: json["filter_for_stock_putaway_rule"],
        propertyValuation: json["property_valuation"]!,
        propertyCostMethod: json["property_cost_method"]!,
        propertyStockJournal: json["property_stock_journal"],
        propertyStockAccountInputCategId:
            json["property_stock_account_input_categ_id"],
        propertyStockAccountOutputCategId:
            json["property_stock_account_output_categ_id"],
        propertyStockValuationAccountId:
            json["property_stock_valuation_account_id"],
        propertyAccountCreditorPriceDifferenceCateg:
            json["property_account_creditor_price_difference_categ"],
        isShopifyProductCat: json["is_shopify_product_cat"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "complete_name": completeName,
        "parent_id": parentId,
        "parent_path": parentPath,
        "child_id":
            childId == null ? [] : List<dynamic>.from(childId!.map((x) => x)),
        "product_count": productCount,
        "product_properties_definition": productPropertiesDefinition == null
            ? []
            : List<dynamic>.from(productPropertiesDefinition!.map((x) => x)),
        "id": id,
        "display_name": displayName,
        "create_uid": createUid,
        "create_date": createDate,
        "write_uid": writeUid,
        "write_date": writeDate,
        "property_account_income_categ_id": propertyAccountIncomeCategId,
        "property_account_expense_categ_id": propertyAccountExpenseCategId,
        "route_ids":
            routeIds == null ? [] : List<dynamic>.from(routeIds!.map((x) => x)),
        "removal_strategy_id": removalStrategyId,
        "total_route_ids": totalRouteIds == null
            ? []
            : List<dynamic>.from(totalRouteIds!.map((x) => x)),
        "putaway_rule_ids": putawayRuleIds == null
            ? []
            : List<dynamic>.from(putawayRuleIds!.map((x) => x)),
        "packaging_reserve_method": packagingReserveMethod,
        "filter_for_stock_putaway_rule": filterForStockPutawayRule,
        "property_valuation": propertyValuation,
        "property_cost_method": propertyCostMethod,
        "property_stock_journal": propertyStockJournal,
        "property_stock_account_input_categ_id":
            propertyStockAccountInputCategId,
        "property_stock_account_output_categ_id":
            propertyStockAccountOutputCategId,
        "property_stock_valuation_account_id": propertyStockValuationAccountId,
        "property_account_creditor_price_difference_categ":
            propertyAccountCreditorPriceDifferenceCateg,
        "is_shopify_product_cat": isShopifyProductCat,
      };
}
