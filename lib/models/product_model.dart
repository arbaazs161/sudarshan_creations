import 'variants_model.dart';

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
  final num minPrice;
  final num maxPrice;
  final List<String>
      variantTypes; // ['enquiry', 'order'] if product varaint contain enquiryand order variants;

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
    required this.minPrice,
    required this.maxPrice,
    required this.variantTypes,
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
      maxPrice: json['maxPrice'],
      minPrice: json['minPrice'],
      topSelling: json['topSelling'],
      images: List<String>.from(json['images']),
      variantTypes: List<String>.from(json['variantTypes']),
      tags: List<String>.from(json['tags']), // Ensure tags are lowercase
      variants: (json['variants'] as List<dynamic>)
          .map((variant) =>
              VariantModel.fromJson(variant, variant as Map<String, dynamic>))
          .toList(),
    );
  }
}
