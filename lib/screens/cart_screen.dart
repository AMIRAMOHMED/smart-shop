import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';
import 'package:provider/provider.dart';
import 'package:shop_smart/provider/product_provider.dart';
import 'package:shop_smart/provider/user_provider.dart';
import 'package:shop_smart/screens/inner_screens/loading_manger.dart';
import 'package:shop_smart/services/my_app_methods.dart';
import 'package:shop_smart/widgets/title_text_.dart';
import 'package:uuid/uuid.dart';

import '../provider/cart_provider.dart';
import '../services/assest_manger.dart';
import '../widgets/cart_bottom_checkout.dart';
import '../widgets/cart_widget.dart';
import '../widgets/empty_bag.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartProvider>(context);
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    final productProvider =
        Provider.of<ProductProvider>(context, listen: false);

    return cartProvider.getCartItems.isEmpty
        ? Scaffold(
            body: EmptyBag(
              imagePath: AssetsManager.shoppingBasket,
              title: "Your cart is empty",
              subTitle:
                  'Looks like you didn\'t add anything yet to your cart \ngo ahead and start shopping now',
              buttonText: "Shop Now",
            ),
          )
        : Scaffold(
            bottomSheet: CartButtomCheckOut(
              function: () async {
                await placeOrder(
                    cartProvider: cartProvider,
                    productProvider: productProvider,
                    userProvider: userProvider);
              },
            ),
            appBar: AppBar(
              title: TitlesTextWidget(
                label: "Cart (${cartProvider.getCartItems.length})",
                fontSize: 20,
              ),
              leading: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Image.asset(AssetsManager.shoppingCart),
              ),
              actions: [
                IconButton(
                  onPressed: () {
                    MyAppMethods.showErrorOrWarningDialog(
                        subTitle: "ClearCart",
                        context: context,
                        isError: false,
                        fct: () async {
                          await cartProvider.clearCartFromFirebase();
                          // cartProvider.clearLocalCart();
                        });
                  },
                  icon: const Icon(
                    IconlyLight.delete,
                    color: Colors.red,
                  ),
                ),
              ],
            ),
            body: LoadingManger(
              isLoading: isLoading,
              child: Column(
                children: [
                  Expanded(
                      child: ListView.builder(
                    itemCount: cartProvider.getCartItems.length,
                    itemBuilder: (context, index) {
                      return ChangeNotifierProvider.value(
                        value: cartProvider.getCartItems.values
                            .toList()
                            .reversed
                            .toList()[index],
                        child: const CartWidget(),
                      );
                    },
                  )),
                  const SizedBox(
                    height: kBottomNavigationBarHeight + 10,
                  )
                ],
              ),
            ),
          );
  }

  Future<void> placeOrder(
      {required CartProvider cartProvider,
      required ProductProvider productProvider,
      required UserProvider userProvider}) async {
    final auth = FirebaseAuth.instance;
    User? user = auth.currentUser;
    if (user == null) {
      return;
    }
    final uid = user.uid;
    try {
      setState(() {
        isLoading = true;
      });

      cartProvider.getCartItems.forEach((key, value) async {
        final getCurrProduct = productProvider.findByProductID(value.productId);
        final orderId = const Uuid().v4();
        await FirebaseFirestore.instance
            .collection("orderAdvanced")
            .doc(orderId)
            .set({
          "orderId": orderId,
          "userId": uid,
          "productId": value.productId,
          "productTitle": getCurrProduct!.productTitle,
          "userName": userProvider.getUserModel!.userName,
          "price": double.parse(getCurrProduct.productPrice) * value.quantity,
          "imageUrl": getCurrProduct.productImage,
          "quantity": value.quantity,
          "orderDate": Timestamp.now()
        });
      });

      await cartProvider.clearCartFromFirebase();
      cartProvider.clearLocalCart();
    } catch (error) {
      MyAppMethods.showErrorOrWarningDialog(
          subTitle: error.toString(), context: context, fct: () {});
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }
}
