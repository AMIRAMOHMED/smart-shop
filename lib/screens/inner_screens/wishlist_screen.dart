import 'package:dynamic_height_grid_view/dynamic_height_grid_view.dart';
import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';
import 'package:provider/provider.dart';

import '../../provider/wishlist_provider.dart';
import '../../services/assest_manger.dart';

import '../../services/my_app_methods.dart';
import '../../widgets/empty_bag.dart';
import '../../widgets/products/product_widget.dart';
import '../../widgets/title_text_.dart';

class WishListScreen extends StatelessWidget {
  const WishListScreen({super.key});
  static const id = "WishListScreen";

  @override
  Widget build(BuildContext context) {
    final wishListProvider = Provider.of<WishListProvider>(context);

    return wishListProvider.getwishItems.isEmpty
        ? Scaffold(
            body: EmptyBag(
            imagePath: AssetsManager.wishlistSvg,
            title: "Your Cart is empty ",
            subTitle:
                "Looks Like youغيرها بعيد  didnot add anything \n go ahead and start shopping now ",
            buttonText: "Shop Now",
          ))
        : Scaffold(
            appBar: AppBar(
              title:  TitlesTextWidget(label: "WishList(${wishListProvider.getwishItems.length})", fontSize: 20),
              leading: Image.asset(AssetsManager.wishlistSvg),
              actions:  [
                IconButton(

                  color: Colors.red, onPressed: () { MyAppMethods.showErrorOrWarningDialog(
                    subTitle: "ClearCart",
                    context: context,
                    isError: false,
                    fct: () {
                      wishListProvider.clearWhisList();
                    }); }, icon:const Icon(  IconlyLight.delete,) ,
                )
              ],
            ),
            body: DynamicHeightGridView(
                itemCount: wishListProvider.getwishItems.length,
                crossAxisCount: 2,
                builder: (context, index) {
                  return   ProductWidget(productId:wishListProvider.getwishItems.values.toList()[index].productId);
                }),
          );
  }
}
