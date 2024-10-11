import 'package:cloud_firestore/cloud_firestore.dart';
import 'variants_model.dart';

class ProductModel {
  final String docId;
  final String name;
  final String lowerName;
  final List<String> combinationNames;
  final String mainCatDocId;
  final String subCatDocId;
  final String vendorDocId;
  bool available;
  final String description;
  final bool isActive;
  final Timestamp createdAt;
  bool topSelling;
  final List<VariantModel> variants;
  final num minPrice;
  final num maxPrice;
  final List<String> variantTypes;
  // ['enquiry', 'order'] if product varaint contain enquiryand order variants;

  ProductModel({
    required this.docId,
    required this.name,
    required this.lowerName,
    required this.combinationNames,
    required this.mainCatDocId,
    required this.subCatDocId,
    required this.vendorDocId,
    required this.available,
    required this.createdAt,
    required this.description,
    required this.isActive,
    required this.topSelling,
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
      'minPrice': minPrice,
      'maxPrice': maxPrice,
      'variantTypes': variantTypes,
      'crecreatedAt': createdAt,
      'description': description,
      'isActive': isActive,
      'topSelling': topSelling,
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
      createdAt: json['createdAt'],
      isActive: json['isActive'],
      maxPrice: json['maxPrice'],
      minPrice: json['minPrice'],
      topSelling: json['topSelling'],
      variantTypes: List<String>.from(json['variantTypes']),
      variants: Map.from(json['variants'])
          .entries
          .map((variantJson) =>
              VariantModel.fromJson(variantJson.key, variantJson.value))
          .toList(),
    );
  }

  factory ProductModel.fromSnap(
      QueryDocumentSnapshot<Map<String, dynamic>> json) {
    return ProductModel(
      docId: json.id,
      name: json['name'],
      lowerName: json['lowerName'],
      combinationNames: List<String>.from(json['combinationNames']),
      mainCatDocId: json['mainCatDocId'],
      subCatDocId: json['subCatDocId'],
      vendorDocId: json['vendorDocId'],
      available: json['available'],
      description: json['description'],
      isActive: json['isActive'],
      maxPrice: json['maxPrice'],
      minPrice: json['minPrice'],
      createdAt: json['createdAt'],
      topSelling: json['topSelling'],
      variantTypes: List<String>.from(json['variantTypes']),
      variants: Map.from(json['variants'])
          .entries
          .map((variantJson) =>
              VariantModel.fromJson(variantJson.key, variantJson.value))
          .toList(),
      // variants: (json['variants'] as Map<String, dynamic>)
      //     .map((variant) =>
      //         VariantModel.fromJson(variant, variant as Map<String, dynamic>))
      //     .toList(),
    );
  }
  factory ProductModel.fromDocSnap(
      DocumentSnapshot<Map<String, dynamic>> json) {
    return ProductModel(
      docId: json.id,
      name: json['name'],
      lowerName: json['lowerName'],
      combinationNames: List<String>.from(json['combinationNames']),

      createdAt: json['createdAt'],
      mainCatDocId: json['mainCatDocId'],
      subCatDocId: json['subCatDocId'],
      vendorDocId: json['vendorDocId'],
      available: json['available'],
      description: json['description'],
      isActive: json['isActive'],
      maxPrice: json['maxPrice'],
      minPrice: json['minPrice'],
      topSelling: json['topSelling'],
      // images: List<String>.from(json['images']),
      variantTypes: List<String>.from(json['variantTypes']),
      variants: Map.from(json['variants'])
          .entries
          .map((variantJson) =>
              VariantModel.fromJson(variantJson.key, variantJson.value))
          .toList(),
    );
  }
}
