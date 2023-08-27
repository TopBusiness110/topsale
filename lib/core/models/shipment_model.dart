class ShipmentModel{
  String? shipmentCode;
  String? clientName;
  String? clientPhoneNumber;
  double? clientLat;
  double? clientLng;
  String? address;
  DateTime? dateTime;

  ShipmentModel(
      {this.shipmentCode,
      this.clientName,
      this.clientPhoneNumber,
      this.clientLat,
      this.clientLng,
      this.address,
      this.dateTime});
}

List<ShipmentModel> shipments = [
  ShipmentModel(address: "shebin el kom",clientName: "mohammed ahmed",clientLat: 31.1234567,clientLng: 31.123887654,
  clientPhoneNumber: "010207555799",shipmentCode: "0X1870098",dateTime: DateTime.now()),
  ShipmentModel(address: "tanta",clientName: "Ebrahim etman",clientLat: 31.1267,clientLng: 31.127654,
      clientPhoneNumber: "01020446799",shipmentCode: "0X129998",dateTime: DateTime.now()),
  ShipmentModel(address: "cairo",clientName: "Mostafa mosaab",clientLat: 31.10634567,clientLng: 31.1533887654,
      clientPhoneNumber: "0102333716799",shipmentCode: "0X1880098",dateTime: DateTime.now())
];