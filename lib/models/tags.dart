import 'package:cloud_firestore/cloud_firestore.dart';

class TagsModel {
  final String docId;
  final String name;
  final String type;
  final String typeId;
  final List<String> tags;

  TagsModel({
    required this.docId,
    required this.name,
    required this.type,
    required this.typeId,
    required this.tags,
  });

  factory TagsModel.fromSnap(QueryDocumentSnapshot<Map<String, dynamic>> json) {
    return TagsModel(
      docId: json.id,
      name: json['name'] as String,
      type: json['image'] as String,
      typeId: json['mainCatId'] as String,
      tags: List<String>.from(json['tags']),
    );
  }
  factory TagsModel.fromDocSnap(DocumentSnapshot<Map<String, dynamic>> json) {
    return TagsModel(
      docId: json.id,
      name: json['name'] as String,
      type: json['image'] as String,
      typeId: json['mainCatId'] as String,
      tags: List<String>.from(json['tags']),
    );
  }

  factory TagsModel.fromJson(Map<String, dynamic> json) {
    return TagsModel(
      docId: json['docId'] as String,
      name: json['name'] as String,
      type: json['image'] as String,
      typeId: json['mainCatId'] as String,
      tags: List<String>.from(json['tags']),
    );
  }

  Map<String, dynamic> toJson() => {
        'docId': docId,
        'name': name,
        'image': type,
        'mainCatId': typeId,
        'isActive': tags,
      };
}
