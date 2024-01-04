import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';
import 'package:provider/provider.dart';
import 'package:shop_smart/provider/cart_provider.dart';
import 'package:shop_smart/screens/cart_screen.dart';
import 'package:shop_smart/screens/home_screen.dart';
import 'package:shop_smart/screens/profile_screen.dart';
import 'package:shop_smart/screens/search_screen.dart';

class RootScreen extends StatefulWidget {
  const RootScreen({super.key});

  @override
  State<RootScreen> createState() => _RootScreenState();
}

class _RootScreenState extends State<RootScreen> {
  late PageController? controller;

  dynamic currentScreen = 0;
  List<Widget> screens = [
    const HomeScreen(),
    const SearchScreen(),
    const CartScreen(),
    const ProfileScreen()
  ];

  @override
  void initState() {
    super.initState();
    controller = PageController(
      initialPage: currentScreen,
    );
  }

  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartProvider>(context);

    return Scaffold(
      body: PageView(
        physics: const NeverScrollableScrollPhysics(),
        controller: controller,
        children: screens,
      ),
      bottomNavigationBar: NavigationBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        height: kBottomNavigationBarHeight,
        selectedIndex: currentScreen,
        onDestinationSelected: (index) {
          setState(() {
            currentScreen = index;
          });
          controller!.jumpToPage(currentScreen);
        },
        destinations: [
          const NavigationDestination(
              selectedIcon: Icon(IconlyBold.home),
              icon: Icon(IconlyBold.home),
              label: "home"),
          const NavigationDestination(
              selectedIcon: Icon(IconlyBold.search),
              icon: Icon(IconlyBold.search),
              label: "search"),
          NavigationDestination(
              selectedIcon: const Icon(IconlyBold.bag_2),
              icon: Badge(
                  backgroundColor: Colors.blue,
                  label: Text('${cartProvider.getCartItems.length}'),
                  child: const Icon(
                    IconlyBold.bag_2,
                  )),
              label: "cart"),
          const NavigationDestination(
              selectedIcon: Icon(IconlyBold.profile),
              icon: Icon(IconlyBold.profile),
              label: "profile")
        ],
      ),
    );
  }
}
