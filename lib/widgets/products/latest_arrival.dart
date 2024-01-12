import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:provider/provider.dart';
import 'package:shop_smart/models/product_model.dart';
import 'package:shop_smart/widgets/subtitle_text.dart';



import '../../provider/cart_provider.dart';
import '../../provider/viewed_provider.dart';
import '../../screens/inner_screens/product_details_screen.dart';
import '../../services/my_app_methods.dart';
import 'heart_button.dart';

class LatestArrivelProductsWidget extends StatelessWidget {
  const LatestArrivelProductsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final productsModel=Provider.of<ProductModel>(context);
    final viewedProvider=Provider.of<ViewedProductProvider>(context);
    final cartProvider = Provider.of<CartProvider>(context);

    Size size = MediaQuery.of(context).size;

    return GestureDetector(
      onTap: () async {
        viewedProvider.addViewedProduct(productId: productsModel.productId);
        await Navigator.pushNamed(
          context,
          ProductDetails.id,
          arguments: productsModel.productId,
        );

      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SizedBox(
          width: size.width * .45,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Flexible(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: FancyShimmerImage(
                    imageUrl: productsModel.productImage,
                    width: size.width * .28,
                    height: size.height * .12,
                  ),
                ),
              ),
              const SizedBox(
                width: 7,
              ),
              Flexible(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      productsModel.productTitle,
                      overflow: TextOverflow.ellipsis,
                    ),
                    FittedBox(
                      child: Row(
                        children: [
                           HeartButtonWidget(
                            size: 18, productId: productsModel.productId

                          ),
                          IconButton(
                            onPressed: ()async {
                              if (cartProvider.isProductInCart(
                                  productId: productsModel.productId)) {
                                return;
                              }
                              // cartProvider.addProductToCart(
                              //     productId: getCurrProduct.productId);

                              try {
                                await cartProvider.addToCartFirebase(
                                    productId: productsModel.productId,
                                    qty: 1,
                                    context: context);
                              } catch (error) {
                                MyAppMethods.showErrorOrWarningDialog(
                                    subTitle: error.toString(),
                                    context: context,
                                    fct: () {});
                              }
                            }, icon: const Icon(
                              Ionicons.cart_sharp,
                              size: 18,
                            ),
                          ),
                        ],
                      ),
                    ),
                     FittedBox(
                      child: SubtitleTextWidget(
                        label: "${productsModel.productPrice}\$",
                        fontSize: 20,
                        color: Colors.blue,
                      ),
                    ),
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
