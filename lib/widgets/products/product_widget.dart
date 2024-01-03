import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:provider/provider.dart';
import 'package:shop_smart/widgets/subtitle_text.dart';
import 'package:shop_smart/widgets/title_text_.dart';
import '../../provider/product_provider.dart';
import '../../screens/inner_screens/product_details_screen.dart';
import 'heart_button.dart';

class ProductWidget extends StatefulWidget {
  const ProductWidget({super.key,  required this.productId});

final String productId;
  @override
  State<ProductWidget> createState() => _ProductWidgetState();
}

class _ProductWidgetState extends State<ProductWidget> {
  @override
  Widget build(BuildContext context) {
    final productProvider=Provider.of<ProductProvider>(context);
    final getCurrProduct=productProvider.findByProductID(widget.productId);
    Size size = MediaQuery.of(context).size;
    return getCurrProduct == null?const SizedBox.shrink():

      GestureDetector(
      onTap: () async {
        await Navigator.pushNamed(
          context,
          ProductDetails.id,arguments: getCurrProduct.productId,
        );
      },
      child: Column(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(30),
            child: FancyShimmerImage(
              imageUrl: getCurrProduct.productImage,
              width: double.infinity,
              height: size.height * .22,
            ),
          ),
          Row(
            children: [
              Flexible(
                flex: 5,
                child: TitlesTextWidget(
                  label: getCurrProduct.productTitle,
                  fontSize: 20,
                  maxLine: 2,
                ),
              ),
              const Flexible(
                child: HeartButtonWidget(size: 25),
              )
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
               Flexible(
                flex: 5,
                child: SubtitleTextWidget(
                  label: "${ getCurrProduct.productPrice}\$" ,
                  fontSize: 20,
                ),
              ),
              Flexible(
                child: Material(
                  borderRadius: BorderRadius.circular(16.0),
                  color: Colors.black12,
                  child: InkWell(
                    splashColor: Colors.red,
                    onTap: () {},
                    child: const Padding(
                      padding: EdgeInsets.all(5),
                      child: Icon(Ionicons.cart),
                    ),
                  ),
                ),
              ), const SizedBox(
                width:5,

              ),
            ],
          ),

        ],

      ),
    );
  }
}
