import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sudarshan_creations/models/cartitems_model.dart';
import 'package:sudarshan_creations/models/product_model.dart';
import 'package:sudarshan_creations/models/user.dart';
import 'package:sudarshan_creations/shared/firebase.dart';

import '../models/main_category.dart';
import '../shared/methods.dart';

class HomeCtrl extends GetxController {
  bool loggedIn = false;
  UserModel? currentUserdata;
  StreamSubscription<DocumentSnapshot<Map<String, dynamic>>>? userDataStr;
  List<MainCategory> homeCategories = [];
  StreamSubscription<QuerySnapshot<Map<String, dynamic>>>? homecategorystream;
  List<ProductModel> topSellingProducts = [];
  StreamSubscription<QuerySnapshot<Map<String, dynamic>>>?
      topSellingProductsSream;
  bool cartLoaded = false;

  List<CartModel> cartItems = <CartModel>[];
  List<String> userFavourites = <String>[];
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
        cartItems.clear();
        userFavourites.clear();
        currentUserdata = null;
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
          currentUserdata = UserModel.fromSnap(event);
          if (currentUserdata != null) {
            syncCartItems();
            userFavourites = currentUserdata?.favourites ?? [];
          }
          update();
        }
      });
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  syncCartItems() async {
    try {
      cartLoaded = false;
      update();
      // cartItems.clear();
      final cartData = currentUserdata?.cartItems ?? [];
      List<CartModel> newCart = <CartModel>[];
      List<ProductModel> products = [];

      List<String> cartproductIds = <String>[];
      cartproductIds.clear();
      cartproductIds.addAll(cartData.map((e) => e.productId).toList());
      int starting = 0;
      int ending = cartproductIds.length >= 25 ? 25 : cartproductIds.length;
      int noofLoops = (cartproductIds.length % 25).ceil();
      products.clear();
      for (var loop = 0; loop < noofLoops; loop++) {
        for (var j = starting; j < ending; j++) {
          final productSnap = await FBFireStore.products
              .where(FieldPath.documentId, isEqualTo: cartproductIds[j])
              .get();
          // final productsSnap = await FBFireStore.products
          //     .where(FieldPath.documentId,
          //         arrayContainsAny: cartproductIds.sublist(starting, ending))
          //     .get();
          final productsget =
              productSnap.docs.map((e) => ProductModel.fromDocSnap(e)).toList();
          products.addAll(productsget);
        }
        if ((ending + 25) <= cartproductIds.length) {
          starting = ending;
          ending = ending + 25;
        } else {
          starting = ending;
          ending = cartproductIds.length;
        }
      }
      // final producgtSnap
      for (var itm in cartData) {
        final product = products.firstWhereOrNull((element) =>
            element.variants
                .firstWhereOrNull((element) => element.id == itm.vId) !=
            null);
        newCart.addIf(
            product != null,
            CartModel(
                id: itm.id,
                productId: product!.docId,
                vId: itm.vId,
                qty: itm.qty));
      }
      cartItems = newCart;
      // cartItems = newCart;
      // for (var newCartItem in newCart) {
      //   cartItems.addIf(
      //       cartItems.firstWhereOrNull((element) =>
      //               element.productDocId == newCartItem.productDocId &&
      //               element.vId == newCartItem.vId) !=
      //           null,
      //       newCartItem);
      // }
      cartLoaded = true;
      update();
    } catch (e) {
      debugPrint(e.toString());
    }
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

  addToCart(CartModel item) {
    if (cartItems.firstWhereOrNull((element) =>
            element.productId == item.productId && element.vId == item.vId) !=
        null) return;
    cartItems.add(item);
    if (isLoggedIn()) updateDBCart();
    update();
  }

  updateQty(String productdocId, String vId, bool increment) {
    final item = cartItems.firstWhereOrNull(
        (element) => element.productId == productdocId && element.vId == vId);
    // final product =
    //     products.firstWhereOrNull((element) => element.docId == productDocId);
    // final variant =
    //     product.variants.firstWhereOrNull((element) => element.id == vId);
    if (item != null) {
      if (increment) {
        item.qty++;
      } else {
        if (item.qty > 1) item.qty--;
      }
      updateDBCart();
      // update();
    }
  }

  removeFromCart(String productDocId, String vId) {
    cartItems.removeWhere(
        (element) => element.productId == productDocId && element.vId == vId);
    if (isLoggedIn()) updateDBCart();
    update();
  }

  bool isInCart(String productDocId, String vId) {
    final item = cartItems.firstWhereOrNull(
        (element) => element.productId == productDocId && element.vId == vId);
    if (item == null) {
      return false;
    } else {
      return true;
    }
  }

  bool isFavourite(String productDocId, String vId) {
    final item = userFavourites.firstWhereOrNull((element) {
      List<String> checkList = element.split("/");
      return checkList.contains(productDocId) && checkList.contains(vId);
    });
    if (item == null) {
      return false;
    } else {
      return true;
    }
  }

  updateDBCart() async {
    try {
      final cartData = {};
      for (var cartitem in cartItems) {
        cartData.addIf(true, cartitem.id, {
          'productId': cartitem.productId,
          'qty': cartitem.qty,
          'vId': cartitem.vId,
        });
      }
      FBFireStore.users
          .doc(FBAuth.auth.currentUser?.uid)
          .update({'cartItems': cartData});
    } catch (e) {
      debugPrint(e.toString());
    }
  }

/*   addToDBCart(CartModel item) async {
    try {
      final cartData = {};
      for (var cartitem in cartItems) {
        cartData.addIf(true, cartitem.id, {
          'productId': cartitem.productId,
          'qty': cartitem.qty,
          'vId': cartitem.vId,
        });
      }
      await FBFireStore.users
          .doc(FBAuth.auth.currentUser?.uid)
          .update({'cartItems': cartData});
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  removeFromDBCart(String vId) async {
    try {
      final cartData = {};
      for (var cartitem in cartItems) {
        cartData.addIf(true, cartitem.id, {
          'productId': cartitem.productId,
          'qty': cartitem.qty,
          'vId': cartitem.vId,
        });
      }
      await FBFireStore.users
          .doc(FBAuth.auth.currentUser?.uid)
          .update({'cartItems': cartData});
    } catch (e) {
      debugPrint(e.toString());
    }
  } */
}
