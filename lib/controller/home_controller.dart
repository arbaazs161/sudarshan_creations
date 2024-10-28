import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sudarshan_creations/models/product_model.dart';
import 'package:sudarshan_creations/models/user.dart';
import 'package:sudarshan_creations/shared/firebase.dart';

import '../models/main_category.dart';

class HomeCtrl extends GetxController {
  bool loggedIn = false;
  UserModel? profileData;
  StreamSubscription<DocumentSnapshot<Map<String, dynamic>>>? userDataStr;
  List<MainCategory> homeCategories = [];
  StreamSubscription<QuerySnapshot<Map<String, dynamic>>>? homecategorystream;
  List<ProductModel> topSellingProducts = [];
  StreamSubscription<QuerySnapshot<Map<String, dynamic>>>?
      topSellingProductsSream;
  @override
  void onInit() {
    super.onInit();
    userStream();
    getMainCategories();
    getTopSellingProducts();
  }

  userStream() async {
    FirebaseAuth.instance.authStateChanges().listen((event) {
      loggedIn = event != null;
      debugPrint(event?.uid);
      if (loggedIn) {
        userDataStream();
      } else {
        // cartItems.clear();
      }
    });
  }

  userDataStream() async {
    try {
      userDataStr?.cancel();
      userDataStr = FBFireStore.users
          .doc(FBAuth.auth.currentUser?.uid)
          .snapshots()
          .listen((event) {
        if (event.exists) {
          profileData = UserModel.fromSnap(event);
          if (profileData != null) {
            // syncCartItems();
          }
          update();
        }
      });
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  // syncCartItems() async {
  //   try {
  //     cartLoaded = false;
  //     update();
  //     cartItems.clear();
  //     final cartData = profileData?.cartData ?? [];
  //     List<CartItem> newCart = <CartItem>[];
  //     for (var itm in cartData) {
  //       final product = products.firstWhereOrNull((element) =>
  //           element.variants
  //               .firstWhereOrNull((element) => element.vId == itm.variantId) !=
  //           null);
  //       newCart.addIf(
  //           product != null,
  //           CartItem(
  //               productDocId: product!.docId,
  //               vId: itm.variantId,
  //               qty: itm.qty));
  //     }
  //     cartItems.addAll(newCart);
  //     // cartItems = newCart;
  //     // for (var newCartItem in newCart) {
  //     //   cartItems.addIf(
  //     //       cartItems.firstWhereOrNull((element) =>
  //     //               element.productDocId == newCartItem.productDocId &&
  //     //               element.vId == newCartItem.vId) !=
  //     //           null,
  //     //       newCartItem);
  //     // }
  //     cartLoaded = true;
  //     update();
  //   } catch (e) {
  //     debugPrint(e.toString());
  //   }
  // }

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
