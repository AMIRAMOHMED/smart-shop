import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';
import 'package:provider/provider.dart';
import 'package:shop_smart/widgets/subtitle_text.dart';
import 'package:shop_smart/widgets/title_text_.dart';

import '../models/cart_model.dart';
import '../provider/cart_provider.dart';
import '../provider/product_provider.dart';
import 'bottom_sheet.dart';
import 'products/heart_button.dart';

class CartWidget extends StatelessWidget {
  const CartWidget({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final productProvider = Provider.of<ProductProvider>(context);
    final cartModelProvider = Provider.of<CartModel>(context);
    final getCurrProduct =
        productProvider.findByProductID(cartModelProvider.productId);
    final cartProvider = Provider.of<CartProvider>(context);

    return getCurrProduct == null
        ? const SizedBox.shrink()
        : FittedBox(
            child: IntrinsicWidth(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: FancyShimmerImage(
                        imageUrl: getCurrProduct.productImage,
                        height: size.height * 0.2,
                        width: size.height * 0.2,
                      ),
                    ),
                    const SizedBox(
                      width: 10.0,
                    ),
                    IntrinsicWidth(
                      child: Column(
                        children: [
                          Row(
                            children: [
                              SizedBox(
                                width: size.width * 0.6,
                                child: TitlesTextWidget(
                                  label: getCurrProduct.productTitle,
                                  fontSize: 20,
                                ),
                              ),
                              Column(
                                children: [
                                  InkWell(
                                    onTap: () async{await
                                      cartProvider.removeCartItemFromFirebase(cartID: cartModelProvider.cartId,
                                          productId: cartModelProvider.productId,
                                          qty: cartModelProvider.quantity);
                                      // cartProvider.removeOneItem(
                                      //     productId: getCurrProduct.productId);

                                    },
                                    child: const Icon(
                                      IconlyLight.delete,
                                      color: Colors.red,
                                    ),
                                  ),
                                  HeartButtonWidget(
                                    productId: getCurrProduct.productId,
                                  ),
                                ],
                              ),
                            ],
                          ),
                          Row(
                            // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              SubtitleTextWidget(
                                label: "${getCurrProduct.productPrice}\$",
                                fontSize: 20,
                                color: Colors.blue,
                              ),
                              const Spacer(),
                              OutlinedButton.icon(
                                style: OutlinedButton.styleFrom(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(30)),
                                  side: const BorderSide(
                                    width: 2,
                                    color: Colors.blue,
                                  ),
                                ),
                                onPressed: () async {
                                  await showModalBottomSheet(
                                      shape: const RoundedRectangleBorder(
                                          borderRadius: BorderRadius.only(
                                              topLeft: Radius.circular(30),
                                              topRight: Radius.circular(30))),
                                      backgroundColor: Theme.of(context)
                                          .scaffoldBackgroundColor,
                                      context: context,
                                      builder: ((context) {
                                        return QuantityBottomSheetWidget(
                                          cartModel: cartModelProvider,
                                        );
                                      }));
                                },
                                icon: const Icon(
                                  IconlyLight.arrow_down_2,
                                  color: Colors.blue,
                                ),
                                label: Text(
                                  "${cartModelProvider.quantity}",
                                  style: const TextStyle(color: Colors.blue),
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          );
  }
}
