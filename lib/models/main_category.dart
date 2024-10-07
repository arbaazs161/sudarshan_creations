import 'package:cloud_firestore/cloud_firestore.dart';

class MainCategory {
  final String docId;
  final String name;
  final String image;
  final List<String> combinationNames;
  final bool showonHomePage;
  final bool isActive;

  MainCategory({
    required this.docId,
    required this.name,
    required this.image,
    required this.showonHomePage,
    required this.combinationNames,
    required this.isActive,
  });

  factory MainCategory.fromSnap(
      QueryDocumentSnapshot<Map<String, dynamic>> json) {
    return MainCategory(
      docId: json.id,
      name: json['name'] as String,
      image: json['image'] as String,
      showonHomePage: json['showonHomePage'] as bool,
      isActive: json['isActive'] as bool,
      combinationNames: List<String>.from(json['combinationNames']),
    );
  }
  factory MainCategory.fromDocSnap(
      DocumentSnapshot<Map<String, dynamic>> json) {
    return MainCategory(
      docId: json.id,
      name: json['name'] as String,
      image: json['image'] as String,
      showonHomePage: json['showonHomePage'] as bool,
      isActive: json['isActive'] as bool,
      combinationNames: List<String>.from(json['combinationNames']),
    );
  }

  factory MainCategory.fromJson(Map<String, dynamic> json) {
    return MainCategory(
      docId: json['docId'] as String,
      name: json['name'] as String,
      image: json['image'] as String,
      showonHomePage: json['showonHomePage'] as bool,
      isActive: json['isActive'] as bool,
      combinationNames: List<String>.from(json['combinationNames']),
    );
  }

  Map<String, dynamic> toJson() => {
        'docId': docId,
        'name': name,
        'image': image,
        'showonHomePage': showonHomePage,
        'isActive': isActive,
        'combinationNames': combinationNames,
      };
}
