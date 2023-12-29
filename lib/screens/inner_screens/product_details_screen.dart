import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';
import 'package:shop_smart/widgets/subtitle_text.dart';
import 'package:shop_smart/widgets/title_text_.dart';

import '../../consts/app_constants.dart';
import '../../widgets/app_name_text.dart';
import '../../widgets/products/heart_button.dart';



class ProductDetails extends StatelessWidget {
  static const id = "ProductDetails";

  const ProductDetails({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    // var image =ModalRoute.of(context)!.settings.arguments;
    return Scaffold(
      appBar: AppBar(
        title: const AppNameTextWidget(),
        centerTitle: true,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          FancyShimmerImage(
            imageUrl: AppConstants.productImageUrl,
            width: double.infinity,
            height: size.height * .45,
            boxFit: BoxFit.contain,
          ),
          const SizedBox(
            height: 20,
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                  child: TitlesTextWidget(
                    label: "Apple  love my iphone so much 14 pro(128)-Black",
                    fontSize: 20,
                    maxLine: 2,
                  ),
                ),
                SubtitleTextWidget(
                  label: "\$165",
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
                ),
                Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16.0),
                      color: Colors.lightBlueAccent),
                  child: const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 60, vertical: 15),
                    child: Text("item added to cart"),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TitlesTextWidget(label: "About this item", fontSize: 20),
                SubtitleTextWidget(label: "inphones", fontSize: 20)
              ],
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          SubtitleTextWidget(
            label: "descration" * 20,
            fontSize: 18,
          )
        ],
      ),
    );
  }
}
