import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_smart/provider/them_provider.dart';
import 'package:shop_smart/root.dart';
import 'package:shop_smart/screens/auth/forgot_password_screen.dart';
import 'package:shop_smart/screens/auth/login_screen.dart';
import 'package:shop_smart/screens/auth/register_screen.dart';
import 'package:shop_smart/screens/inner_screens/order_screen/order_screen.dart';
import 'package:shop_smart/screens/inner_screens/product_details_screen.dart';
import 'package:shop_smart/screens/inner_screens/viewd_recently.dart';
import 'package:shop_smart/screens/inner_screens/wishlist_screen.dart';

import 'consts/them_data.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) {
          return ThemeProvider();
        })
      ],
      child: Consumer<ThemeProvider>(builder: (context, themeProvider, child) {
        return MaterialApp(
          theme: Styles.themeData(
              isDarkTheme: themeProvider.getIsDarkTheme, context: context),
          debugShowCheckedModeBanner: false,
          title: "ShopSmart",
          // home: const RootScreen(),
          home: const RootScreen(),
          routes: {
            ProductDetails.id: (context) => const ProductDetails(),
            WishListScreen.id: (context) => const WishListScreen(),
            ViewedRecentlyPage.id: (context) => const ViewedRecentlyPage(),
            LoginScreen.id: (context) => const LoginScreen(),
            RegisterScreen.id: (context) => const RegisterScreen(),
            ForgetPassswordScreen.id: (context) =>
                const ForgetPassswordScreen(),
            OrderScreen.id: (context) => const OrderScreen()
          },
        );
      }),
    );
  }
}
