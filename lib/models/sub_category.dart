import 'package:cloud_firestore/cloud_firestore.dart';

class SubCategory {
  final String docId;
  final String name;
  final String image;
  final String mainCatId;
  final bool isActive;
  final num minPrice;
  final num maxPrice;

  SubCategory({
    required this.docId,
    required this.name,
    required this.image,
    required this.mainCatId,
    required this.isActive,
    required this.minPrice,
    required this.maxPrice,
  });

  factory SubCategory.fromSnap(
      QueryDocumentSnapshot<Map<String, dynamic>> json) {
    return SubCategory(
      docId: json.id,
      name: json['name'] as String,
      image: json['image'] as String,
      mainCatId: json['mainCatId'] as String,
      isActive: json['isActive'] as bool,
      minPrice: json['minPrice'] as num,
      maxPrice: json['maxPrice'] as num,
    );
  }
  factory SubCategory.fromDocSnap(DocumentSnapshot<Map<String, dynamic>> json) {
    return SubCategory(
      docId: json.id,
      name: json['name'] as String,
      image: json['image'] as String,
      mainCatId: json['mainCatId'] as String,
      isActive: json['isActive'] as bool,
      minPrice: json['minPrice'] as num,
      maxPrice: json['maxPrice'] as num,
    );
  }

  factory SubCategory.fromJson(Map<String, dynamic> json) {
    return SubCategory(
      docId: json['docId'] as String,
      name: json['name'] as String,
      image: json['image'] as String,
      mainCatId: json['mainCatId'] as String,
      isActive: json['isActive'] as bool,
      minPrice: json['minPrice'] as num,
      maxPrice: json['maxPrice'] as num,
    );
  }

  Map<String, dynamic> toJson() => {
        'docId': docId,
        'name': name,
        'image': image,
        'mainCatId': mainCatId,
        'isActive': isActive,
        'minPrice': minPrice,
        'maxPrice': maxPrice,
      };
}
