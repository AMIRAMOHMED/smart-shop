import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';
import 'package:shop_smart/firebase_options.dart';
import 'package:shop_smart/provider/cart_provider.dart';
import 'package:shop_smart/provider/orders_provider.dart';
import 'package:shop_smart/provider/product_provider.dart';
import 'package:shop_smart/provider/them_provider.dart';
import 'package:shop_smart/provider/user_provider.dart';
import 'package:shop_smart/provider/viewed_provider.dart';
import 'package:shop_smart/provider/wishlist_provider.dart';
import 'package:shop_smart/root.dart';
import 'package:shop_smart/screens/auth/forgot_password_screen.dart';
import 'package:shop_smart/screens/auth/login_screen.dart';
import 'package:shop_smart/screens/auth/register_screen.dart';
import 'package:shop_smart/screens/inner_screens/order_screen/order_screen.dart';
import 'package:shop_smart/screens/inner_screens/product_details_screen.dart';
import 'package:shop_smart/screens/inner_screens/viewd_recently.dart';
import 'package:shop_smart/screens/inner_screens/wishlist_screen.dart';
import 'package:shop_smart/screens/search_screen.dart';

import 'consts/them_data.dart';

void main() {
  debugProfilePaintsEnabled = false;
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Firebase.initializeApp(
          options: DefaultFirebaseOptions.currentPlatform),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const MaterialApp(
            home: Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            ),
          );
        } else if (snapshot.hasError) {
          return MaterialApp(
            home: Scaffold(
              body: Center(
                child:
                    SelectableText("An error has occurred ${snapshot.error}"),
              ),
            ),
          );
        }

        return MultiProvider(
          providers: [
            ChangeNotifierProvider(
              create: (_) => ThemeProvider(),
            ),
            ChangeNotifierProvider(
              create: (_) => ProductProvider(),
            ),
            ChangeNotifierProvider(
              create: (_) => CartProvider(),
            ),
            ChangeNotifierProvider(
              create: (_) => WishListProvider(),
            ),
            ChangeNotifierProvider(
              create: (_) => ViewedProductProvider(),
            ),
            ChangeNotifierProvider(
              create: (_) => UserProvider(),
            ),
            ChangeNotifierProvider(
              create: (_) => OrderProvider(),
            ),
          ],
          child: Consumer<ThemeProvider>(
            builder: (context, themeProvider, child) {
              return MaterialApp(
                title: 'Shop Smart AR',
                theme: Styles.themeData(
                  isDarkTheme: themeProvider.getIsDarkTheme,
                  context: context,
                ),
                debugShowCheckedModeBanner: false,
                home: const RootScreen(),
                routes: {
                  ProductDetails.id: (context) => const ProductDetails(),
                  WishlistScreen.id: (context) => const WishlistScreen(),
                  ViewedRecentlyPage.id: (context) =>
                      const ViewedRecentlyPage(),
                  LoginScreen.id: (context) => const LoginScreen(),
                  RegisterScreen.id: (context) => const RegisterScreen(),
                  ForgetPassswordScreen.id: (context) =>
                      const ForgetPassswordScreen(),
                  OrdersScreenFree.id: (context) => const OrdersScreenFree(),
                  SearchScreen.id: (context) => const SearchScreen(),
                  RootScreen.id: (context) => const RootScreen(),
                },
              );
            },
          ),
        );
      },
    );
  }
}
