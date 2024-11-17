import 'package:sudarshan_creations/models/product_model.dart';

class CartModel {
  final String id;
  final String productId;
  final String vId;
  final ProductModel? product;
  int qty;

  CartModel({
    required this.id,
    required this.productId,
    required this.vId,
    required this.qty,
    this.product,
  });

  factory CartModel.fromJson(id, Map<String, dynamic> json) => CartModel(
        id: id,
        productId: json['productId'] as String,
        vId: json['vId'] as String,
        qty: json['qty'] as int,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'productId': productId,
        'qty': qty,
        'vId': vId,
      };
}
