import 'package:dynamic_height_grid_view/dynamic_height_grid_view.dart';
import 'package:flutter/material.dart';

import '../../services/assest_manger.dart';

import '../../widgets/empty_bag.dart';
import '../../widgets/products/product_widget.dart';
import '../../widgets/title_text_.dart';

class WishListScreen extends StatelessWidget {
  const WishListScreen({super.key});
  static const id = "WishListScreen";
  final bool isEmpty = false;
  @override
  Widget build(BuildContext context) {
    return isEmpty
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
              title: const TitlesTextWidget(label: "WishList(5)", fontSize: 20),
              leading: Image.asset(AssetsManager.wishlistSvg),
              actions: const [
                Icon(
                  Icons.delete,
                )
              ],
            ),
            body: DynamicHeightGridView(
                itemCount: 120,
                crossAxisCount: 2,
                builder: (context, index) {
                  return const ProductWidget();
                }),
          );
  }
}
