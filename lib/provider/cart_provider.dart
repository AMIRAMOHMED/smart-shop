import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shop_smart/models/product_model.dart';
import 'package:shop_smart/provider/product_provider.dart';
import 'package:shop_smart/services/my_app_methods.dart';
import 'package:uuid/uuid.dart';

import '../models/cart_model.dart';

class CartProvider with ChangeNotifier {
  final Map<String, CartModel> _cartItems = {};

  Map<String, CartModel> get getCartItems {
    return _cartItems;
  }

  bool isProductInCart({required String productId}) {
    return _cartItems.containsKey(productId);
  }

  // Firebas
  final _auth = FirebaseAuth.instance;
  final usersDB = FirebaseFirestore.instance.collection("users");

  Future<void> addToCartFirebase(
      {required String productId,
      required int qty,
      required BuildContext context}) async {
    final User? user = _auth.currentUser;
    if (user == null) {
      MyAppMethods.showErrorOrWarningDialog(
          subTitle: "No user Found Please Login", context: context, fct: () {});
      return;
    }
    final uid = user.uid;
    final cartID = const Uuid().v4();
    try {
      usersDB.doc(uid).update({
        "userCart": FieldValue.arrayUnion([
          {
            "cartId": cartID,
            "productID": productId,
            "quantity": qty,
          }
        ])
      });
      await fetchCart();
      Fluttertoast.showToast(msg: 'Item has been added to cart ');
    } catch (e) {
      rethrow;
    }
  }

  Future<void> fetchCart() async {
    User? user = _auth.currentUser;
    if (user == null) {
      _cartItems.clear();
      return;
    }
    try {
      final userDoc = await usersDB.doc(user.uid).get();
      final data = userDoc.data();
      if (data == null || !data.containsKey("userCart")) {
        return;
      }
      final leng = userDoc.get("userCart").length;
      for (int index = 0; index < leng; index++) {
        _cartItems.putIfAbsent(
          userDoc.get("userCart")[index]['productID'],
          () => CartModel(
              cartId: userDoc.get("userCart")[index]['cartId'],
              productId: userDoc.get("userCart")[index]['productID'],
              quantity: userDoc.get("userCart")[index]['quantity']),
        );
      }
    } catch (e) {
      rethrow;
    }
    notifyListeners();
  }

  Future<void> clearCartFromFirebase() async {
    User? user = _auth.currentUser;
    try {
      await usersDB.doc(user!.uid).update({"userCart": []});
      _cartItems.clear();
    } catch (e) {
      rethrow;
    }
    notifyListeners();
  }

  Future<void> removeCartItemFromFirebase(
      {required String cartID,
      required String productId,
      required int qty}) async {
    User? user = _auth.currentUser;
    try {
      await usersDB.doc(user!.uid).update({
        "userCart": FieldValue.arrayRemove([
          {
            "cartId": cartID,
            "productID": productId,
            "quantity": qty,
          }
        ])
      });
      _cartItems.remove(productId);
      await fetchCart();
    } catch (e) {
      rethrow;
    }
    notifyListeners();
  }

//Local
  void addProductToCart({required String productId}) {
    _cartItems.putIfAbsent(
        productId,
        () => CartModel(
            cartId: const Uuid().v4(), productId: productId, quantity: 1));
    notifyListeners();
  }

  void updateQuantity({required String productId, required int quantity}) {
    _cartItems.update(
      productId,
      (item) => CartModel(
          cartId: item.cartId, productId: productId, quantity: quantity),
    );
    notifyListeners();
  }

  double getTotal({required ProductProvider productProvider}) {
    double total = 0.0;

    _cartItems.forEach((key, value) {
      final ProductModel? getCurrentProduct =
          productProvider.findByProductID(value.productId);
      if (getCurrentProduct == null) {
        total += 0.0;
      } else {
        total += double.parse(getCurrentProduct.productPrice) * value.quantity;
      }
    });
    return total;
  }

  int getQty() {
    int total = 0;
    _cartItems.forEach((key, value) {
      total += value.quantity;
    });
    return total;
  }

  void removeOneItem({required String productId}) {
    _cartItems.remove(productId);
    notifyListeners();
  }

  void clearLocalCart() {
    _cartItems.clear();
    notifyListeners();
  }
}
