import 'package:flutter/cupertino.dart';
import 'package:shop_smart/models/wishlist_model.dart';
import 'package:uuid/uuid.dart';

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
  }
}
