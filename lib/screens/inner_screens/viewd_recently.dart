import 'package:dynamic_height_grid_view/dynamic_height_grid_view.dart';
import 'package:flutter/material.dart';

import '../../services/assest_manger.dart';

import '../../widgets/empty_bag.dart';
import '../../widgets/products/product_widget.dart';
import '../../widgets/title_text_.dart';

class ViewedRecentlyPage extends StatelessWidget {
  const ViewedRecentlyPage({super.key});
  static const id = "ViewedRecentlyPage";
  final bool isEmpty = true;
  @override
  Widget build(BuildContext context) {
    return isEmpty
        ? Scaffold(
            body: EmptyBag(
            imagePath: AssetsManager.recent,
            title: "Your Cart isهنغيرها   empty ",
            subTitle:
                "Looks Like youغيرها بعيد  didnot add anything \n go ahead and start shopping now ",
            buttonText: "Shop Now",
          ))
        : Scaffold(
            appBar: AppBar(
              title: const TitlesTextWidget(
                  label: "Viewed Recentt(5)", fontSize: 20),
              leading: Image.asset(AssetsManager.recent),
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
                  return  const ProductWidget(productId: '',);
                }),
          );
  }
}
