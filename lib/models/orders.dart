import 'package:cloud_firestore/cloud_firestore.dart';

class OrderModel {
  final String? docId;
  final String? userDocId;
  final List<OrderProductModel> products;
  final String addressId;
  final DateTime orderDate;
  final String totalPrice;
  final bool orderConfirmed; // New field
  final String paymentMethod; // New field
  final bool isPaid; // New field

  OrderModel({
    required this.docId,
    required this.userDocId,
    required this.addressId,
    required this.orderDate,
    required this.products,
    required this.totalPrice,
    required this.orderConfirmed,
    required this.paymentMethod,
    required this.isPaid,
  });

  // Convert OrderModel to JSON
  Map<String, dynamic> toJson() {
    return {
      'docId': docId,
      'totalPrice': totalPrice,
      'userDocId': userDocId,
      'addressId': addressId,
      'orderDate':
          orderDate.toIso8601String(), // Convert DateTime to ISO 8601 string
      'products': products.map((product) => product.toJson()).toList(),
      'orderConfirmed': orderConfirmed, // New field
      'paymentMethod': paymentMethod, // New field
      'isPaid': isPaid, // New field
    };
  }

  // Create OrderModel from JSON
  factory OrderModel.fromJson(Map<String, dynamic> json) {
    return OrderModel(
      docId: json['docId'] as String?,
      userDocId: json['userDocId'] as String?,
      addressId: json['addressId'] as String,
      totalPrice: json['totalPrice'] as String,
      orderDate: DateTime.parse(json['orderDate'] as String),
      products: (json['products'] as List)
          .map((product) =>
              OrderProductModel.fromJson(product as Map<String, dynamic>))
          .toList(),
      orderConfirmed: json['orderConfirmed'] as bool, // New field
      paymentMethod: json['paymentMethod'] as String, // New field
      isPaid: json['isPaid'] as bool, // New field
    );
  }

  // Create OrderModel from Firestore DocumentSnapshot
  factory OrderModel.fromSnap(DocumentSnapshot<Map<String, dynamic>> snap) {
    final data = snap.data()!;
    return OrderModel(
      docId: snap.id,
      totalPrice: data['totalPrice'] as String,
      userDocId: data['userDocId'] as String?,
      addressId: data['addressId'] as String,
      orderDate: DateTime.parse(data['orderDate'] as String),
      products: (data['products'] as List)
          .map((product) =>
              OrderProductModel.fromJson(product as Map<String, dynamic>))
          .toList(),
      orderConfirmed: data['orderConfirmed'] as bool, // New field
      paymentMethod: data['paymentMethod'] as String, // New field
      isPaid: data['isPaid'] as bool, // New field
    );
  }
}

class OrderProductModel {
  final String docId;
  final String name;
  final String variantId;
  final num fixedPrice;
  final num qty;
  final num tax;

  OrderProductModel({
    required this.docId,
    required this.name,
    required this.variantId,
    required this.fixedPrice,
    required this.qty,
    required this.tax,
  });

  // Convert OrderProductModel to JSON
  Map<String, dynamic> toJson() {
    return {
      'docId': docId,
      'name': name,
      'variantId': variantId,
      'fixedPrice': fixedPrice,
      'qty': qty,
      'tax': tax,
    };
  }

  // Create OrderProductModel from JSON
  factory OrderProductModel.fromJson(Map<String, dynamic> json) {
    return OrderProductModel(
      docId: json['docId'] as String,
      name: json['name'] as String,
      variantId: json['variantId'] as String,
      fixedPrice: json['fixedPrice'] as num,
      qty: json['qty'] as num,
      tax: json['tax'] as num,
    );
  }

  // Create OrderProductModel from Firestore DocumentSnapshot
  factory OrderProductModel.fromSnap(
      DocumentSnapshot<Map<String, dynamic>> snap) {
    final data = snap.data()!;
    return OrderProductModel(
      docId: data['docId'] as String,
      name: data['name'] as String,
      variantId: data['variantId'] as String,
      fixedPrice: data['fixedPrice'] as num,
      qty: data['qty'] as num,
      tax: data['tax'] as num,
    );
  }
}
