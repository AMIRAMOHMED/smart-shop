import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_smart/widgets/subtitle_text.dart';
import 'package:shop_smart/widgets/title_text_.dart';

import '../../provider/cart_provider.dart';
import '../../provider/product_provider.dart';
import '../../widgets/app_name_text.dart';
import '../../widgets/products/heart_button.dart';

class ProductDetails extends StatelessWidget {
  static const id = "ProductDetails";

  const ProductDetails({super.key});

  @override
  Widget build(BuildContext context) {
    final productProvider = Provider.of<ProductProvider>(context);

    final productId = ModalRoute.of(context)!.settings.arguments as String;
    final getCurrProduct = productProvider.findByProductID(productId);

    final cartProvider = Provider.of<CartProvider>(context);
    Size size = MediaQuery.of(context).size;
    return getCurrProduct == null
        ? const SizedBox.shrink()
        : Scaffold(
            appBar: AppBar(
              title: const AppNameTextWidget(),
              centerTitle: true,
            ),
            body: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  FancyShimmerImage(
                    imageUrl: getCurrProduct.productImage,
                    width: double.infinity,
                    height: size.height * .45,
                    boxFit: BoxFit.contain,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Flexible(
                          child: TitlesTextWidget(
                            label: getCurrProduct.productTitle,
                            fontSize: 20,
                            maxLine: 2,
                          ),
                        ),
                        SubtitleTextWidget(
                          label: "\$${getCurrProduct.productPrice}",
                          fontSize: 20,
                          color: Colors.blue,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 50),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        HeartButtonWidget(
                          color: Colors.blue.shade100,
                          productId: getCurrProduct.productId,
                        ),
                        Expanded(
                          child: SizedBox(
                            height: kBottomNavigationBarHeight - 10,
                            child: ElevatedButton.icon(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.lightBlue,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(
                                    30,
                                  ),
                                ),
                              ),
                              onPressed: () {
                                if (cartProvider.isProductInCart(
                                    productId: getCurrProduct.productId)) {
                                  return;
                                }
                                cartProvider.addProductToCart(
                                    productId: getCurrProduct.productId);
                              },
                              icon: Icon(
                                cartProvider.isProductInCart(
                                        productId: getCurrProduct.productId)
                                    ? Icons.check
                                    : Icons.add_shopping_cart_rounded,
                              ),
                              label: Text(
                                cartProvider.isProductInCart(
                                        productId: getCurrProduct.productId)
                                    ? "In cart"
                                    : "Add to cart",
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const TitlesTextWidget(
                            label: "About this item", fontSize: 20),
                        SubtitleTextWidget(
                            label: "In ${getCurrProduct.productCategory}",
                            fontSize: 20)
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SubtitleTextWidget(
                      label: getCurrProduct.productDescription,
                      fontSize: 18,
                    ),
                  )
                ],
              ),
            ),
          );
  }
}
