import 'address_model.dart';
import 'cartitems_model.dart';

class UserModel {
  final String docId;
  final String name;
  final String number;
  final String email;
  final List<String> favourites;
  final List<CartModel> cartItems;
  final List<AddressModel> addresses;

  UserModel({
    required this.docId,
    required this.name,
    required this.number,
    required this.email,
    required this.favourites,
    required this.cartItems,
    required this.addresses,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        docId: json['docId'] as String,
        name: json['name'] as String,
        number: json['number'] as String,
        email: json['email'] as String,
        favourites: List<String>.from(json['favourites']),
        cartItems: (json['cartItems'] as List<dynamic>)
            .map((cartItem) =>
                CartModel.fromJson(cartItem, cartItem as Map<String, dynamic>))
            .toList(),
        addresses: (json['addresses'] as List<dynamic>)
            .map((address) =>
                AddressModel.fromJson(address, address as Map<String, dynamic>))
            .toList(),
      );

  Map<String, dynamic> toJson() => {
        'docId': docId,
        'name': name,
        'number': number,
        'email': email,
        'favourites': favourites,
        'cartItems': cartItems.map((e) => e.toJson()).toList(),
        'addresses': addresses.map((e) => e.toJson()).toList(),
      };
}
