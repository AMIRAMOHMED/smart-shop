import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../consts/app_constants.dart';
import '../provider/product_provider.dart';
import '../services/assest_manger.dart';

import '../widgets/products/ctg_rounded_widget.dart';
import '../widgets/products/latest_arrival.dart';
import '../widgets/title_text_.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final productProvider = Provider.of<ProductProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const TitlesTextWidget(label: "Search ", fontSize: 25),
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Image.asset(AssetsManager.shoppingCart),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: size.height * .25,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(30),
              child: Swiper(
                itemBuilder: (BuildContext context, int index) {
                  return Image.asset(
                    AppConstants.banersImages[index],
                    fit: BoxFit.fill,
                  );
                },
                itemCount: AppConstants.banersImages.length,
                viewportFraction: .8,
                scale: .9,
                autoplay: true,
                pagination: const SwiperPagination(
                    alignment: Alignment.bottomCenter,
                    builder: DotSwiperPaginationBuilder(
                        color: Colors.white, activeColor: Colors.black54)),
              ),
            ),
          ),
          const SizedBox(height: 18),
          const TitlesTextWidget(label: "Lastes arrival", fontSize: 20),
          const SizedBox(height: 18),
          SizedBox(
            height: size.height * .2,
            child: ListView.builder(
                itemCount: 10,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  return ChangeNotifierProvider.value(
                    value: productProvider.getProducts[index],
                    child: const LatestArrivelProductsWidget(),
                  );
                }),
          ),
          const SizedBox(height: 18),
          const TitlesTextWidget(label: "Categories", fontSize: 20),
          const SizedBox(height: 18),
          Expanded(
            child: GridView.count(
                crossAxisCount: 4,
                children:
                    List.generate(AppConstants.categroyList.length, (index) {
                  return CategroyRoundedWeidget(
                    image: AppConstants.categroyList[index].image,
                    name: AppConstants.categroyList[index].name,
                  );
                })),
          )
        ],
      ),
    );
  }
}
