class AddressModel {
  final String id;
  final String flatHouse;
  final String area;
  final String city;
  final String state;
  final String pincode;

  AddressModel({
    required this.id,
    required this.flatHouse,
    required this.area,
    required this.city,
    required this.state,
    required this.pincode,
  });

  factory AddressModel.fromJson(String keyId, Map<String, dynamic> json) =>
      AddressModel(
        id: keyId,
        flatHouse: json['flatHouse'] as String,
        area: json['area'] as String,
        city: json['city'] as String,
        state: json['state'] as String,
        pincode: json['pincode'] as String,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'flatHouse': flatHouse,
        'area': area,
        'city': city,
        'state': state,
        'pincode': pincode,
      };
}
