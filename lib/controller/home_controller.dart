import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sudarshan_creations/models/product_model.dart';
import 'package:sudarshan_creations/shared/firebase.dart';

import '../models/main_category.dart';

class HomeCtrl extends GetxController {
  List<MainCategory> homeCategories = [];
  StreamSubscription<QuerySnapshot<Map<String, dynamic>>>? homecategorystream;
  List<ProductModel> topSellingProducts = [];
  StreamSubscription<QuerySnapshot<Map<String, dynamic>>>?
      topSellingProductsSream;
  @override
  void onInit() {
    super.onInit();
    getMainCategories();
    getTopSellingProducts();
  }

  getMainCategories() async {
    try {
      homecategorystream?.cancel();
      homecategorystream = FBFireStore.categories
          .where('showonHomePage', isEqualTo: true)
          .where('isActive', isEqualTo: true)
          .limit(6)
          .snapshots()
          .listen((event) {
        homeCategories =
            event.docs.map((e) => MainCategory.fromSnap(e)).toList();
        // print(categories.length);
        update();
      });
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  getTopSellingProducts() {
    try {
      topSellingProductsSream?.cancel();
      topSellingProductsSream = FBFireStore.products
          .where('topSelling', isEqualTo: true)
          .where('available', isEqualTo: true)
          .where('isActive', isEqualTo: true)
          .limit(4)
          .snapshots()
          .listen((event) {
        topSellingProducts =
            event.docs.map((e) => ProductModel.fromSnap(e)).toList();
        update();
      });
    } catch (e) {
      debugPrint(e.toString());
    }
  }
}
