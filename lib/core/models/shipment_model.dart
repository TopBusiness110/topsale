import 'package:topsale/core/models/product_model.dart';

import '../utils/app_assets.dart';

class ShipmentModel{
  String? shipmentCode;
  String? clientName;
  String? clientPhoneNumber;
  double? clientLat;
  double? clientLng;
  String? address;
  DateTime? dateTime;
  List<ProductModel>? products;

  ShipmentModel(
      {this.shipmentCode,
      this.clientName,
      this.clientPhoneNumber,
      this.clientLat,
      this.clientLng,
      this.address,
      this.dateTime,
      this.products});
}

List<ShipmentModel> shipments = [
  ShipmentModel(address: "shebin el kom",clientName: "mohammed ahmed",clientLat: 30.5503,clientLng: 31.0106,
  clientPhoneNumber: "010207555799",shipmentCode: "0X1870098",dateTime: DateTime.now(),
  products: [
    ProductModel(image: AssetsManager.mobileImage,name: " samsung mobile",price:1000 ,
        quantity: 10,code: "VB-123",userOrderedQuantity: 3),
    ProductModel(image: AssetsManager.mobile2Image,name: " Iphone mobile",price:10000 ,quantity: 20,code: "BUR-152",userOrderedQuantity: 8),
  ]),
  ShipmentModel(address: "tanta",clientName: "Ebrahim etman",clientLat: 30.7865,clientLng: 31.0004,
      clientPhoneNumber: "01020446799",shipmentCode: "0X129998",dateTime: DateTime.now(),
      products: [
        ProductModel(image: AssetsManager.thermalCupImage,name: " Thermal cup",
            price:500 ,quantity: 30,code: "NUY-87654",userOrderedQuantity: 4),
        ProductModel(image: AssetsManager.lightImage,name: "Light",price:700 ,
            quantity: 40,code: "BUY-87111",userOrderedQuantity: 2),


      ]),
  ShipmentModel(address: "cairo",clientName: "Mostafa mosaab",clientLat: 30.0444,clientLng:  31.2357,
      clientPhoneNumber: "0102333716799",shipmentCode: "0X1880098",dateTime: DateTime.now(),
  products: [
    ProductModel(image: AssetsManager.laptopImage,name: "Dell Laptop",price:20000 ,
        quantity: 50,code: "NUY-0987",userOrderedQuantity: 1),
    ProductModel(image: AssetsManager.laptop2Image,name: "Lenovo Laptop",
        price:30000 ,quantity: 60,code: "QOI-3109",userOrderedQuantity: 5),
  ])
];