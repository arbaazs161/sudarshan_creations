import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sudarshan_creations/shared/firebase.dart';

import '../models/main_category.dart';

class HomeCtrl extends GetxController {
  List<MainCategory> homeCategories = [];
  StreamSubscription<QuerySnapshot<Map<String, dynamic>>>? homecategorystream;
  @override
  void onInit() {
    super.onInit();
    getMainCategories();
  }

  getMainCategories() async {
    try {
      homecategorystream?.cancel();
      homecategorystream = FBFireStore.categories
          .where('showonHomePage', isEqualTo: true)
          .where('isActive', isEqualTo: true)
          .snapshots()
          .listen((event) {
        homeCategories = event.docs
            .getRange(0, 6)
            .map((e) => MainCategory.fromSnap(e))
            .toList();
        // print(categories.length);
        update();
      });
    } catch (e) {
      debugPrint(e.toString());
    }
  }
}
