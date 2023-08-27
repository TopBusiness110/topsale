class ExpectedClientModel{
  String name;
  String phone;
  String? address;
  String opportunity;
  String? email;

  ExpectedClientModel(
      {required this.name,required this.phone, this.address,required this.opportunity, this.email});

  @override
  String toString() {
    return 'ExpectedClientModel{name: $name, phone: $phone, address: $address, opportunity: $opportunity, email: $email}';
  }
}