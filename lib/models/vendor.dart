import 'package:cloud_firestore/cloud_firestore.dart';

class VendorModel {
  final String docId;
  final String name;
  final String number;
  final String address;
  final String email;
  final List<String> subCatIds;

  VendorModel({
    required this.docId,
    required this.name,
    required this.number,
    required this.address,
    required this.email,
    required this.subCatIds,
  });

  factory VendorModel.fromSnap(
      QueryDocumentSnapshot<Map<String, dynamic>> json) {
    return VendorModel(
      docId: json.id,
      name: json['name'] as String,
      number: json['number'] as String,
      address: json['address'] as String,
      email: json['email'] as String,
      subCatIds: List<String>.from(json['subCatIds']),
    );
  }
  factory VendorModel.fromDocSnap(DocumentSnapshot<Map<String, dynamic>> json) {
    return VendorModel(
      docId: json.id,
      name: json['name'] as String,
      number: json['number'] as String,
      address: json['address'] as String,
      email: json['email'] as String,
      subCatIds: List<String>.from(json['subCatIds']),
    );
  }

  factory VendorModel.fromJson(Map<String, dynamic> json) {
    return VendorModel(
      docId: json['docId'] as String,
      name: json['name'] as String,
      number: json['number'] as String,
      address: json['address'] as String,
      email: json['email'] as String,
      subCatIds: List<String>.from(json['subCatIds']),
    );
  }

  Map<String, dynamic> toJson() => {
        'docId': docId,
        'name': name,
        'number': number,
        'address': address,
        'email': email,
        'subCatIds': subCatIds,
      };
}
