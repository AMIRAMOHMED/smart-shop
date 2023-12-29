import 'package:flutter/material.dart';
import 'package:shop_smart/widgets/title_text_.dart';
import 'package:dynamic_height_grid_view/dynamic_height_grid_view.dart';
import '../services/assest_manger.dart';
import '../widgets/products/product_widget.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});
  static TextEditingController searchTextController = TextEditingController();

  @override
  Widget build(BuildContext context) {

    return InkWell(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        appBar: AppBar(
          title: const TitlesTextWidget(label: "Search ", fontSize: 25),
          leading: Image.asset(AssetsManager.shoppingCart),

        ),
        body: Padding(
          padding: const EdgeInsets.all(25.0),
          child: Column(
            children: [
              TextField(
                controller: searchTextController,
                decoration: InputDecoration(
                    filled: true,
                    suffixIcon: InkWell(
                      child: const Icon(Icons.clear),
                      onTap: () {
                        searchTextController.clear();
                        FocusScope.of(context).unfocus();
                      },
                    ),
                    prefixIcon: const Icon(Icons.search)),
              ),
              const SizedBox(
                height: 20,
              ),
              Expanded(
                child: DynamicHeightGridView(
                    itemCount: 120,
                    crossAxisCount: 2,
                    builder: (context, index) {
                      return const ProductWidget();
                    }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
