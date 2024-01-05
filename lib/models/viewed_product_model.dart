import 'package:flutter/cupertino.dart';

class ViewedProductsModel with ChangeNotifier{
  final String id,productId;

  ViewedProductsModel({required this.id, required this.productId});

}