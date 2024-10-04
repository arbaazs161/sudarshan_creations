import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sudarshan_creations/shared/firebase.dart';
import '../models/main_category.dart';

class HomeCtrl extends GetxController {
  List<MainCategory> categories = [];
  StreamSubscription<QuerySnapshot<Map<String, dynamic>>>? categorystream;
  @override
  void onInit() {
    super.onInit();
    getMainCategories();
  }

  getMainCategories() async {
    try {
      categorystream?.cancel();
      categorystream = FBFireStore.categories.snapshots().listen((event) {
        categories = event.docs.map((e) => MainCategory.fromSnap(e)).toList();
        update();
      });
    } catch (e) {
      debugPrint(e.toString());
    }
  }
}
