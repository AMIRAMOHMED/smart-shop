import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';
import 'package:provider/provider.dart';
import 'package:shop_smart/provider/wishlist_provider.dart';

class HeartButtonWidget extends StatelessWidget {
  const HeartButtonWidget(
      {super.key,
      this.size = 22,
      this.color = Colors.transparent,
      required this.productId});
  final double size;
  final Color color;
  final String productId;
  @override
  Widget build(BuildContext context) {
    final wishListProvider = Provider.of<WishListProvider>(context);
    return Container(
      decoration: BoxDecoration(color: color, shape: BoxShape.circle),
      child: InkWell(
        onTap: () {
          wishListProvider.addOrRemoveFromWishList(productId: productId);
        },
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Icon(
            wishListProvider.isProductInWishList(productId: productId)
                ? IconlyBold.heart
                : IconlyLight.heart,
            size: size,
            color: wishListProvider.isProductInWishList(productId: productId)
                ? Colors.red
                : Colors.grey,
          ),
        ),
      ),
    );
  }
}
