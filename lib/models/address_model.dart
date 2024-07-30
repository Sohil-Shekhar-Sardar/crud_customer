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
