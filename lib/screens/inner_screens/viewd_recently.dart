import 'package:dynamic_height_grid_view/dynamic_height_grid_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../provider/viewed_provider.dart';
import '../../services/assest_manger.dart';

import '../../widgets/empty_bag.dart';
import '../../widgets/products/product_widget.dart';
import '../../widgets/title_text_.dart';

class ViewedRecentlyPage extends StatelessWidget {
  const ViewedRecentlyPage({super.key});
  static const id = "ViewedRecentlyPage";

  @override
  Widget build(BuildContext context) {
    final viewedProvider = Provider.of<ViewedProductProvider>(context);

    return viewedProvider.getviewedProdItems.isEmpty
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
              title:  TitlesTextWidget(
                  label: "Viewed Recentt(${viewedProvider.getviewedProdItems.length})", fontSize: 20),
              leading: Image.asset(AssetsManager.recent),
              actions: const [
                Icon(
                  Icons.delete,
                )
              ],
            ),
            body: DynamicHeightGridView(
                itemCount: viewedProvider.getviewedProdItems.length,
                crossAxisCount: 2,
                builder: (context, index) {
                  return   ProductWidget(productId: viewedProvider.getviewedProdItems.values.toList()[index].productId);
                }),
          );
  }
}
