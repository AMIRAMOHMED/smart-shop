
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


}
