import 'package:dynamic_height_grid_view/dynamic_height_grid_view.dart';
import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';
import 'package:ionicons/ionicons.dart';
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
        body:
            Center(
              child: productList.isEmpty
                  ? const TitlesTextWidget(label: "NoProductFound", fontSize: 40)
                  :
            StreamBuilder<List<ProductModel>>(
                stream: productProvider.fetchProductsStream(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Center(
                      child: TitlesTextWidget(
                        label: snapshot.error.toString(),
                        fontSize: 25,
                      ),
                    );
                  } else if (snapshot.hasData == null) {
                    return const Center(
                      child: TitlesTextWidget(
                        label: "No Product has been added",
                        fontSize: 25,
                      ),
                    );
                  }
                  return Padding(
                    padding: const EdgeInsets.all(25.0),
                    child: Column(
                      children: [
                        TextField(
                          onChanged: (value) {
                            setState(() {
                              productListSearch = productProvider.searchQuery(
                                  searchText: searchTextController.text,
                                  passedList: productList);
                            });
                          },
                          controller: searchTextController,
                          decoration: InputDecoration(
                              filled: true,
                              suffixIcon: InkWell(
                                child: const Icon(   IconlyLight.delete),
                                onTap: () {
                                  searchTextController.clear();
                                  FocusScope.of(context).unfocus();
                                },
                              ),
                              prefixIcon: const Icon(IconlyLight.search)),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        if (searchTextController.text.isNotEmpty &&
                            productListSearch.isEmpty) ...[
                          const Center(
                              child: TitlesTextWidget(
                                  label: "No result found", fontSize: 40))
                        ],
                        Expanded(
                          child: DynamicHeightGridView(
                            itemCount: searchTextController.text.isNotEmpty
                                ? productListSearch.length
                                : productList.length,
                            builder: ((context, index) {
                              return ProductWidget(
                                productId: searchTextController.text.isNotEmpty
                                    ? productListSearch[index].productId
                                    : productList[index].productId,
                              );
                            }),
                            crossAxisCount: 2,
                          ),
                        ),
                      ],
                    ),
                  );
                }),
      ),
    ));
  }
}
