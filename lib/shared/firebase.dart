import 'package:cloud_functions/cloud_functions.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

class FBAuth {
  static final auth = FirebaseAuth.instance;
}

class FBFireStore {
  static final fb = FirebaseFirestore.instance;
  // static final sets = fb.collection('sets').doc('sets');
  static final vendors = fb.collection('vendors');
  static final users = fb.collection('users');
  static final categories = fb.collection('categories');
  static final subCategories = fb.collection('sub-categories');
  static final tags = fb.collection('tags');
  static final amenitiesMore = fb.collection('amenities&more');
  static final cities = fb.collection('cities');
  static final areas = fb.collection('areas');
  static final settings = fb.collection('settings');
}

class FBStorage {
  static final fbstore = FirebaseStorage.instance;
  static final banners = fbstore.ref().child('banner');
  static final category = fbstore.ref().child('category');
  static final amenity = fbstore.ref().child('amenity');
  static final food = fbstore.ref().child('food');
  // static final otherCertis = fb.ref().child('otherCertis');
}

class FBFunctions {
  static final ff = FirebaseFunctions.instance;
}
