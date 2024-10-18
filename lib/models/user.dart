import 'package:cloud_firestore/cloud_firestore.dart';

import 'address_model.dart';
import 'cartitems_model.dart';

class UserModel {
  final String? docId;
  final String? name;
  final String? phone;
  final String email;
  final String authEmail;
  final String password;
  final String? defaultAddressId;
  final List<String>? favourites;
  final List<CartModel> cartItems;
  final List<AddressModel> addresses;

  UserModel({
    required this.docId,
    required this.name,
    required this.phone,
    required this.email,
    required this.authEmail,
    required this.password,
    required this.defaultAddressId,
    required this.favourites,
    required this.cartItems,
    required this.addresses,
  });

  // factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
  //       docId: json['docId'],
  //       name: json['name'],
  //       phone: json['phone'],
  //       authEmail: json['authEmail'],
  //       defaultAddressId: json['defaultAddressId'],
  //       password: json['password'] as String,
  //       email: json['email'],
  //       favourites: json.containsKey('favourites') && json['favourites'] is List
  //     ? List<String>.from(json['favourites'])
  //     : [],
  //       cartItems: (json['cartItems'] as List<dynamic>)
  //           .map((cartItem) =>
  //               CartModel.fromJson(cartItem, cartItem as Map<String, dynamic>))
  //           .toList(),
  //       addresses: (json['addresses'] as List<dynamic>)
  //           .map((address) =>
  //               AddressModel.fromJson(address, address as Map<String, dynamic>))
  //           .toList(),
  //     );

factory UserModel.fromJson(DocumentSnapshot<Map<String, dynamic>> json) => UserModel(
  docId: json.id, // Handle missing docId
  name: json['name'] ?? '', // If name is null, assign empty string
  phone: json['phone'] ?? '', // Assign an empty string if phone is null
  authEmail: json['authEmail'] ?? '',
  defaultAddressId: json['defaultAddressId'], // Leave as null if it's null
  password: json['password'] ?? '',
  email: json['email'] ?? '',

  // If 'favourites' exists and is a list, convert it; otherwise, return an empty list
  favourites: (json.data()?.containsKey('favourites')??false) && json['favourites'] is List
      ? List<String>.from(json['favourites'])
      : [],

  // Handling cartItems, check if it's a list and properly initialize
  cartItems: json['cartItems'] != null && json['cartItems'] is List
      ? (json['cartItems'] as List<dynamic>)
          .map((cartItem) =>
              CartModel.fromJson(cartItem ))
          .toList()
      : [],

  // Handling addresses similarly, check if it's a map or a list
  addresses: json['addresses'] != null && json['addresses'] is List
      ? (json['addresses'] as List<dynamic>)
          .map((address) =>
              AddressModel.fromJson(address, address as Map<String, dynamic>))
          .toList()
      : [],
);


  Map<String, dynamic> toJson() => {
        'docId': docId,
        'name': name,
        'phone': phone,
        'email': email,
        'favourites': favourites,
        'cartItems': cartItems.map((e) => e.toJson()).toList(),
        'addresses': addresses.map((e) => e.toJson()).toList(),
      };
}
