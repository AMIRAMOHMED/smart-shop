
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

class ProductModel with ChangeNotifier {
  final String productTitle,
      productPrice,
      productId,
      productCategory,
      productDescription,
      productImage,
      productQuantity;

  ProductModel(
      {required this.productTitle,
      required this.productPrice,
      required this.productId,
      required this.productCategory,
      required this.productDescription,
      required this.productImage,
      required this.productQuantity});

  factory ProductModel.fromFirestore(DocumentSnapshot doc) {
    Map data = doc.data() as Map<String, dynamic>;
    return ProductModel(
        productTitle: data["productTitle"],
        productPrice: data["productPrice"],
        productId: data["productId"],
        productCategory: data["productCategory"],
        productDescription: data["productDescription"],
        productImage: data["productImage"],
        productQuantity: data["productQuantity"]);
  }
}
