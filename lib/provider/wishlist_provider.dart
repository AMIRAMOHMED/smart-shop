import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shop_smart/models/wishlist_model.dart';
import 'package:uuid/uuid.dart';

import '../services/my_app_methods.dart';

class WishListProvider with ChangeNotifier {
  final Map<String, WishListModel> _wishItems = {};
  Map<String, WishListModel> get getwishItems {
    return _wishItems;
  }

  bool isProductInWishList({required String productId}) {
    return _wishItems.containsKey(productId);
  }

  void addOrRemoveFromWishList({required String productId}) {
    if (_wishItems.containsKey(productId)) {
      _wishItems.remove(productId);
    } else {
      _wishItems.putIfAbsent(
        productId,
        () => WishListModel(
          id: const Uuid().v4(),
          productId: productId,
        ),
      );
    }

    notifyListeners();
  }

  void clearWhisList() {
    _wishItems.clear();
    notifyListeners();
  } // firebase

  final _auth = FirebaseAuth.instance;
  final usersDB = FirebaseFirestore.instance.collection("users");

  Future<void> addToWishListFirebase(
      {required String productId, required BuildContext context}) async {
    final User? user = _auth.currentUser;
    if (user == null) {
      MyAppMethods.showErrorOrWarningDialog(
          subTitle: "No user Found Please Login", context: context, fct: () {});
      return;
    }
    final uid = user.uid;
    final wishListID = const Uuid().v4();
    try {
      usersDB.doc(uid).update({
        "userWish": FieldValue.arrayUnion([
          {
            "wishList": wishListID,
            "productID": productId,
          }
        ])
      });
      await fetchWishList();
      Fluttertoast.showToast(msg: 'Item has been added to WishList ');
    } catch (e) {
      rethrow;
    }
  }

  Future<void> fetchWishList() async {
    User? user = _auth.currentUser;
    if (user == null) {
      _wishItems.clear();
      return;
    }
    try {
      final userDoc = await usersDB.doc(user.uid).get();
      final data = userDoc.data();
      if (data == null || !data.containsKey("userWish")) {
        return;
      }
      final leng = userDoc.get("userWish").length;
      for (int index = 0; index < leng; index++) {
        _wishItems.putIfAbsent(
          userDoc.get("userWish")[index]['productID'],
          () => WishListModel(
            id  : userDoc.get("userWish")[index]['wishListID'],
              productId: userDoc.get("userWish")[index]['productID'],
           ),
        );
      }
    } catch (e) {
      rethrow;
    }
    notifyListeners();
  }

  Future<void> clearWishFromFirebase() async {
    User? user = _auth.currentUser;
    try {
      await usersDB.doc(user!.uid).update({"userWish": []});
      _wishItems.clear();
    } catch (e) {
      rethrow;
    }
    notifyListeners();
  }

  Future<void> removeWishtemFromFirebase(
      {required String wishListID,
      required String productId,
    }) async {
    User? user = _auth.currentUser;
    try {
      await usersDB.doc(user!.uid).update({
        "userWish": FieldValue.arrayRemove([
          {
            "wishListID": wishListID,
            "productID": productId,

          }
        ])
      });
      _wishItems.remove(productId);
      await fetchWishList();
    } catch (e) {
      rethrow;
    }
    notifyListeners();
  }
}
