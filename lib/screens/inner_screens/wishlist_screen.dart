import 'package:dynamic_height_grid_view/dynamic_height_grid_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_smart/provider/wishlist_provider.dart';
import 'package:shop_smart/services/assest_manger.dart';
import 'package:shop_smart/services/my_app_methods.dart';
import 'package:shop_smart/widgets/empty_bag.dart';
import 'package:shop_smart/widgets/title_text_.dart';

import '../../widgets/products/product_widget.dart';

class WishlistScreen extends StatelessWidget {
  static const id = "WishlistScreen";
  const WishlistScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final wishlistProvider = Provider.of<WishListProvider>(context);
    return wishlistProvider.getWishlistItems.isEmpty
        ? Scaffold(
            body: EmptyBag(
              imagePath: AssetsManager.bagWish,
              title: "Your wishlist is empty",
              subTitle:
                  'Looks like you didn\'t add anything yet to your cart \ngo ahead and start shopping now',
              buttonText: "Shop Now",
            ),
          )
        : Scaffold(
            appBar: AppBar(
              title: TitlesTextWidget(
                  label:
                      "Wishlist (${wishlistProvider.getWishlistItems.length})", fontSize: 20,),
              leading: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Image.asset(AssetsManager.shoppingCart),
              ),
              actions: [
                IconButton(
                  onPressed: () {
                    MyAppMethods.showErrorOrWarningDialog(
                        isError: false,
                        context: context,
                        subTitle: "Remove items",
                        fct: () async {
                          await wishlistProvider.clearWishlistFromFirebase();
                          wishlistProvider.clearLocalWishlist();
                        });
                  },
                  icon: const Icon(
                    Icons.delete_forever_rounded,
                    color: Colors.red,
                  ),
                ),
              ],
            ),
            body: DynamicHeightGridView(
              itemCount: wishlistProvider.getWishlistItems.length,
              builder: ((context, index) {
                return ProductWidget(
                  productId: wishlistProvider.getWishlistItems.values
                      .toList()[index]
                      .productId,
                );
              }),
              crossAxisCount: 2,
            ),
          );
  }
}
