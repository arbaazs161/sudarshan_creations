import 'package:cloud_firestore/cloud_firestore.dart';

class TagModel {
  final String docId;
  final String name;
  final String type;
  final String typeId;
  final List<String> tags;

  TagModel({
    required this.docId,
    required this.name,
    required this.type,
    required this.typeId,
    required this.tags,
  });

  factory TagModel.fromSnap(QueryDocumentSnapshot<Map<String, dynamic>> json) {
    return TagModel(
      docId: json.id,
      name: json['name'] as String,
      type: json['type'] as String,
      typeId: json['typeId'] as String,
      tags: List<String>.from(json['tags']),
    );
  }
  factory TagModel.fromDocSnap(DocumentSnapshot<Map<String, dynamic>> json) {
    return TagModel(
      docId: json.id,
      name: json['name'] as String,
      type: json['type'] as String,
      typeId: json['typeId'] as String,
      tags: List<String>.from(json['tags']),
    );
  }

  factory TagModel.fromJson(Map<String, dynamic> json) {
    return TagModel(
      docId: json['docId'] as String,
      name: json['name'] as String,
      type: json['type'] as String,
      typeId: json['typeId'] as String,
      tags: List<String>.from(json['tags']),
    );
  }

  Map<String, dynamic> toJson() => {
        'docId': docId,
        'name': name,
        'type': type,
        'typeId': typeId,
        'tags': tags,
      };
}

class TypeModel {
  static const category = "cat";
  static const subcat = "subcat";
  static const product = "product";
}
