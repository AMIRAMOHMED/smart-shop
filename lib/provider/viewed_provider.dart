import 'package:flutter/cupertino.dart';
import 'package:shop_smart/models/viewed_product_model.dart';

import 'package:uuid/uuid.dart';

class ViewedProductProvider with ChangeNotifier {
  final Map<String, ViewedProductsModel> _viewedProdItems = {};

  Map<String, ViewedProductsModel> get getviewedProdItems {
    return _viewedProdItems;
  }


  void addViewedProduct({required String productId}) {
    _viewedProdItems.putIfAbsent(
      productId,
      () => ViewedProductsModel(
        id: const Uuid().v4(),
        productId: productId,
      ),
    );

    notifyListeners();
  }

  void clearViewedProduct() {
    _viewedProdItems.clear();
    notifyListeners();
  }
}
