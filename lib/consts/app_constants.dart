import 'package:shop_smart/services/assest_manger.dart';

import '../models/categories_model.dart';

class AppConstants {
  static const String productImageUrl =
      'https://i.ibb.co/8r1Ny2n/20-Nike-Air-Force-1-07.png';
  static List<String> banersImages = [
    AssetsManager.banner1,
    AssetsManager.banner2
  ];

  static List<CategroyModel> categroyList = [
    CategroyModel(id: "Phones", image: AssetsManager.mobiles, name: "Phones"),
    CategroyModel(
        id: "electronics",
        image: AssetsManager.electronics,
        name: "electronics"),
    CategroyModel(
        id: "cosmetics", image: AssetsManager.cosmetics, name: "cosmetics"),
    CategroyModel(id: "shoes", image: AssetsManager.shoes, name: "shoes"),
    CategroyModel(id: "Watches", image: AssetsManager.watch, name: "Watches"),
    CategroyModel(id: "Books", image: AssetsManager.book, name: "Books"),
    CategroyModel(id: "Clothes", image: AssetsManager.fashion, name: "Clothes"),
    CategroyModel(
      id: "Laptops",
      image: AssetsManager.pc,
      name: "Laptops",
    ),
  ];
}
