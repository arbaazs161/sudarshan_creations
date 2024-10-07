class VariantModel {
  final String id;
  final List<String> images;
  final List<PriceRangeModel> priceRange;
  final String? color;
  final String? material;
  final String description;
  final bool defaultt;
  final bool available;
  final String priceType; // priceType= (range, fixed price, inquiry)
  final num? fixedPrice;
  final num? size;

  VariantModel({
    required this.id,
    required this.images,
    required this.priceRange,
    required this.color,
    required this.material,
    required this.description,
    required this.defaultt,
    required this.available,
    required this.priceType,
    required this.fixedPrice,
    required this.size,
  });

  factory VariantModel.fromJson(String keyId, Map<String, dynamic> json) =>
      VariantModel(
        id: keyId,
        images: json['images'],
        priceRange: (json['priceRange'] as List<dynamic>)
            .map((e) => PriceRangeModel.fromJson(e, e as Map<String, dynamic>))
            .toList(),
        color: json['color'],
        material: json['material'],
        description: json['description'],
        defaultt: json['defaultt'],
        available: json['available'],
        priceType: json['priceType'],
        fixedPrice: json['fixedPrice'],
        size: json['size'],
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'images': images,
        'priceRange': priceRange,
        'color': color,
        'material': material,
        'description': description,
        'defaultt': defaultt,
        'available': available,
        'priceType': priceType,
        'fixedPrice': fixedPrice,
        'size': size,
      };
}

class PriceRangeModel {
  final String id;
  final String startQty;
  final String endQty;
  final num price;

  PriceRangeModel({
    required this.id,
    required this.startQty,
    required this.endQty,
    required this.price,
  });

  factory PriceRangeModel.fromJson(String keyId, Map<String, dynamic> json) =>
      PriceRangeModel(
        id: keyId,
        startQty: json['startQty'] as String,
        endQty: json['endQty'] as String,
        price: json['price'],
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'startQty': startQty,
        'endQty': endQty,
        'price': price,
      };
}
