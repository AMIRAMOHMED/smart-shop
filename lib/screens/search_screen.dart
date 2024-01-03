import 'package:dynamic_height_grid_view/dynamic_height_grid_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_smart/models/product_model.dart';
import 'package:shop_smart/widgets/title_text_.dart';

import '../provider/product_provider.dart';
import '../services/assest_manger.dart';
import '../widgets/products/product_widget.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});
  static const id = "SearchScreen";

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  late TextEditingController searchTextController;
  @override
  void initState() {
    searchTextController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    searchTextController.dispose();
    super.dispose();
  }

  List<ProductModel> productListSearch = [];

  @override
  Widget build(BuildContext context) {
    final productProvider = Provider.of<ProductProvider>(context);
    String? passedCategory =
        ModalRoute.of(context)!.settings.arguments as String?;

    final List<ProductModel> productList = passedCategory == null
        ? productProvider.getProducts
        : productProvider.findByCategory(ctgName: passedCategory);
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        appBar: AppBar(
          title:
              TitlesTextWidget(label: passedCategory ?? "Search", fontSize: 25),
          leading: Image.asset(AssetsManager.shoppingCart),
        ),
        body: Center(
          child: productList.isEmpty
              ? const TitlesTextWidget(label: "NoProductFound", fontSize: 40)
              : Padding(
                  padding: const EdgeInsets.all(25.0),
                  child: Column(
                    children: [
                      TextField(
                        onSubmitted: (value) {
                          setState(() {
                            productListSearch = productProvider.searchQuery(
                                searchText: searchTextController.text);
                          });
                        },
                        onChanged: (value) {
                          setState(() {
                            productListSearch = productProvider.searchQuery(
                                searchText: searchTextController.text);
                          });
                        },
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
                      if(searchTextController.text.isNotEmpty&&productListSearch.isNotEmpty);
                      Expanded(
                        child: DynamicHeightGridView(
                            itemCount: productList.length,
                            crossAxisCount: 2,
                            builder: (context, index) {
                              return ChangeNotifierProvider.value(
                                value: productList[index],
                                child: ProductWidget(
                                  productId: productList[index].productId,
                                ),
                              );
                            }),
                      ),
                    ],
                  ),
                ),
        ),
      ),
    );
  }
}
