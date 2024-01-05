import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_smart/widgets/subtitle_text.dart';
import 'package:shop_smart/widgets/title_text_.dart';

import '../provider/cart_provider.dart';
import '../provider/product_provider.dart';

class CartButtomCheckOut extends StatelessWidget {
  const CartButtomCheckOut({super.key});

  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartProvider>(context);
    final productProvider = Provider.of<ProductProvider>(context);

    return Container(
      decoration: BoxDecoration(
          border: const Border(top: BorderSide(width: 1, color: Colors.grey)),
          color: Theme.of(context).scaffoldBackgroundColor),
      child: SizedBox(
          height: kBottomNavigationBarHeight + 20,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18.0, vertical: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      FittedBox(
                        child: TitlesTextWidget(
                            label:
                                "Total(${cartProvider.getCartItems.length}products/${cartProvider.getQty()}item )",
                            fontSize: 20),
                      ),
                      SubtitleTextWidget(
                        label:
                            "${cartProvider.getTotal(productProvider: productProvider)}\$",
                        fontSize: 18,
                        color: Colors.blue,
                      )
                    ],
                  ),
                ),
                ElevatedButton(onPressed: () {}, child: const Text("CheckOut"))
              ],
            ),
          )),
    );
  }
}
