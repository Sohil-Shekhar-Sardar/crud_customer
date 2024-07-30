class Customer {
  String pan;
  String fullName;
  String email;
  String mobileNumber;
  List<Address> addresses;

  Customer({
    required this.pan,
    required this.fullName,
    required this.email,
    required this.mobileNumber,
    required this.addresses,
  });

  // Convert Customer object to JSON
  Map<String, dynamic> toJson() => {
        'pan': pan,
        'fullName': fullName,
        'email': email,
        'mobileNumber': mobileNumber,
        'addresses': addresses.map((e) => e.toJson()).toList(),
      };

  // Convert JSON to Customer object
  factory Customer.fromJson(Map<String, dynamic> json) => Customer(
        pan: json['pan'],
        fullName: json['fullName'],
        email: json['email'],
        mobileNumber: json['mobileNumber'],
        addresses: List<Address>.from(json['addresses'].map((e) => Address.fromJson(e))),
      );
}

class Address {
  String addressLine1;
  String? addressLine2;
  String postcode;
  String state;
  String city;

  Address({
    required this.addressLine1,
    this.addressLine2,
    required this.postcode,
    required this.state,
    required this.city,
  });

  // Convert Address object to JSON
  Map<String, dynamic> toJson() => {
        'addressLine1': addressLine1,
        'addressLine2': addressLine2,
        'postcode': postcode,
        'state': state,
        'city': city,
      };

  // Convert JSON to Address object
  factory Address.fromJson(Map<String, dynamic> json) => Address(
        addressLine1: json['addressLine1'],
        addressLine2: json['addressLine2'],
        postcode: json['postcode'],
        state: json['state'],
        city: json['city'],
      );
}
