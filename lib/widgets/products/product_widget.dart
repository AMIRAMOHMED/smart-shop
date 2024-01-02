import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:shop_smart/widgets/subtitle_text.dart';
import 'package:shop_smart/widgets/title_text_.dart';
import '../../consts/app_constants.dart';
import '../../screens/inner_screens/product_details_screen.dart';
import 'heart_button.dart';

class ProductWidget extends StatefulWidget {
  const ProductWidget({super.key});

  @override
  State<ProductWidget> createState() => _ProductWidgetState();
}

class _ProductWidgetState extends State<ProductWidget> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: () async {
        await Navigator.pushNamed(
          context,
          ProductDetails.id,
        );
      },
      child: Column(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(30),
            child: FancyShimmerImage(
              imageUrl: AppConstants.productImageUrl,
              width: double.infinity,
              height: size.height * .22,
            ),
          ),
          Row(
            children: [
              Flexible(
                flex: 5,
                child: TitlesTextWidget(
                  label: "Title" * 10,
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
              const Flexible(
                flex: 5,
                child: SubtitleTextWidget(
                  label: "jdbs\$",
                  fontSize: 20,
                ),
              ),
              Flexible(
                child: Material(
                  borderRadius: BorderRadius.circular(16.0),
                  color: Colors.lightBlue,
                  child: InkWell(
                    splashColor: Colors.red,
                    onTap: () {},
                    child: const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Icon(Ionicons.cart_sharp),
                    ),
                  ),
                ),
              )
            ],
          ),
          const SizedBox(
            height: 10,
          ),
        ],
      ),
    );
  }
}
