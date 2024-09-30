import 'package:cloud_firestore/cloud_firestore.dart';

class MainCategory {
  final String docId;
  final String name;
  final String image;
  final bool showonHomePage;
  final bool isActive;

  MainCategory({
    required this.docId,
    required this.name,
    required this.image,
    required this.showonHomePage,
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
    );
  }

  factory MainCategory.fromJson(Map<String, dynamic> json) {
    return MainCategory(
      docId: json['docId'] as String,
      name: json['name'] as String,
      image: json['image'] as String,
      showonHomePage: json['showonHomePage'] as bool,
      isActive: json['isActive'] as bool,
    );
  }

  Map<String, dynamic> toJson() => {
        'docId': docId,
        'name': name,
        'image': image,
        'showonHomePage': showonHomePage,
        'isActive': isActive,
      };
}
