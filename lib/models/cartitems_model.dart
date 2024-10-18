class CartModel {
  final String id;
  final String productId;
  final int qty;

  CartModel({
    required this.id,
    required this.productId,
    required this.qty,
  });

  factory CartModel.fromJson(Map<String, dynamic> json) =>
      CartModel(
        id: json['id'],
        productId: json['productId'] as String,
        qty: json['qty'] as int,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'productId': productId,
        'qty': qty,
      };
}
