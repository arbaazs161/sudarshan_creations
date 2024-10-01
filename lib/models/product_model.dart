class ProductModel {
  final String docId;
  final String name;
  final String lowerName;
  final String combinationNames;
  final String mainCatDocId;
  final String subCatDocId;
  final String vendorDocId;
  final bool available;
  final String description;
  final bool isActive;
  final bool topSelling;
  final List<String> images;
  final List<String> tags; // should be lower
  final List<VariantModel> variants;

  ProductModel({
    required this.docId,
    required this.name,
    required this.lowerName,
    required this.combinationNames,
    required this.mainCatDocId,
    required this.subCatDocId,
    required this.vendorDocId,
    required this.available,
    required this.description,
    required this.isActive,
    required this.topSelling,
    required this.images,
    required this.tags,
    required this.variants,
  });

  // Convert a ProductModel instance to JSON
  Map<String, dynamic> toJson() {
    return {
      'docId': docId,
      'name': name,
      'lowerName': lowerName,
      'combinationNames': combinationNames,
      'mainCatDocId': mainCatDocId,
      'subCatDocId': subCatDocId,
      'vendorDocId': vendorDocId,
      'available': available,
      'description': description,
      'isActive': isActive,
      'topSelling': topSelling,
      'images': images,
      'tags': tags, // Convert tags to lowercase
      'variants': variants.map((variant) => variant.toJson()).toList(),
    };
  }

  // Create a ProductModel instance from JSON
  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      docId: json['docId'],
      name: json['name'],
      lowerName: json['lowerName'],
      combinationNames: json['combinationNames'],
      mainCatDocId: json['mainCatDocId'],
      subCatDocId: json['subCatDocId'],
      vendorDocId: json['vendorDocId'],
      available: json['available'],
      description: json['description'],
      isActive: json['isActive'],
      topSelling: json['topSelling'],
      images: List<String>.from(json['images']),
      tags: List<String>.from(json['tags']), // Ensure tags are lowercase
      variants: (json['variants'] as List<dynamic>)
          .map((variant) =>
              VariantModel.fromJson(variant, variant as Map<String, dynamic>))
          .toList(),
    );
  }
}

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
