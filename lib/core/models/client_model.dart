class ClientModel{
  String name;
  String phoneNumber;
  String? address;

  ClientModel({required this.name, required this.phoneNumber, this.address});

  @override
  String toString() {
    return 'ClientModel{name: $name, phoneNumber: $phoneNumber, address: $address}';
  }
}