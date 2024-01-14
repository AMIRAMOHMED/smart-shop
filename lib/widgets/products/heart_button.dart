import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';
import 'package:provider/provider.dart';
import 'package:shop_smart/provider/wishlist_provider.dart';
import 'package:shop_smart/services/my_app_methods.dart';

class HeartButtonWidget extends StatefulWidget {
  const HeartButtonWidget(
      {super.key,
      this.size = 22,
      this.color = Colors.transparent,
      required this.productId});

  final double size;
  final Color color;
  final String productId;

  @override
  State<HeartButtonWidget> createState() => _HeartButtonWidgetState();
}

bool isLoading = false;

class _HeartButtonWidgetState extends State<HeartButtonWidget> {
  @override
  Widget build(BuildContext context) {
    final wishListProvider = Provider.of<WishListProvider>(context);
    return Container(
      decoration: BoxDecoration(color: widget.color, shape: BoxShape.circle),
      child: InkWell(
        onTap: () async {
          // wishListProvider.addOrRemoveFromWishList(productId: productId);
          // await wishListProvider.fetchWishList();}
          setState(() {
            isLoading = true;
          });
          try {
            if (wishListProvider.getwishItems.containsKey(widget.productId)) {
              wishListProvider.removeWishtemFromFirebase(
                  wishListID:
                      wishListProvider.getwishItems[widget.productId]!.id,
                  productId: widget.productId);
            } else {
              wishListProvider.addToWishListFirebase(
                  productId: widget.productId, context: context);
            }
            await wishListProvider.fetchWishList();
          } catch (e) {
            MyAppMethods.showErrorOrWarningDialog(
                subTitle: e.toString(), context: context, fct: (f) {});
          } finally {
            setState(() {
              isLoading = false;
            });
          }
        },
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Icon(
            wishListProvider.isProductInWishList(productId: widget.productId)
                ? IconlyBold.heart
                : IconlyLight.heart,
            size: widget.size,
            color: wishListProvider.isProductInWishList(
                    productId: widget.productId)
                ? Colors.red
                : Colors.grey,
          ),
        ),
      ),
    );
  }
}
