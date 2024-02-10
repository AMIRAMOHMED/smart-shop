import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_smart/provider/orders_provider.dart';
import 'package:shop_smart/screens/inner_screens/order_screen/order_widget_free.dart';
import 'package:shop_smart/services/assest_manger.dart';
import 'package:shop_smart/widgets/title_text_.dart';
import '../../../../widgets/empty_bag.dart';
import '../../../models/order.dart';

class OrdersScreenFree extends StatefulWidget {
  static const id = "OrdersScreenFree";

  const OrdersScreenFree({super.key});

  @override
  State<OrdersScreenFree> createState() => _OrdersScreenFreeState();
}

class _OrdersScreenFreeState extends State<OrdersScreenFree> {
  bool isEmptyOrders = false;
  @override
  Widget build(BuildContext context) {
    final ordersProvider = Provider.of<OrderProvider>(context);
    return Scaffold(
        appBar: AppBar(
          title: const TitlesTextWidget(
            label: 'Placed orders', fontSize: 20,
          ),
        ),
        body: FutureBuilder<List<OrdersModelAdvanced>>(
          future: ordersProvider.fetechOrder(),
          builder: ((context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (snapshot.hasError) {
              return Center(
                child: SelectableText(
                    "An error has been occured ${snapshot.error}"),
              );
            } else if (!snapshot.hasData || ordersProvider.getOrders.isEmpty) {
              return EmptyBag(
                  imagePath: AssetsManager.orderBag,
                  title: "No orders has been placed yet",
                  subTitle: "",
                  buttonText: "Shop now");
            }
            return ListView.separated(
              itemCount: snapshot.data!.length,
              itemBuilder: (ctx, index) {
                return Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 2, vertical: 6),
                  child: OrdersWidgetFree(
                      ordersModelAdvanced: ordersProvider.getOrders[index]),
                );
              },
              separatorBuilder: (BuildContext context, int index) {
                return const Divider();
              },
            );
          }),
        ));
  }
}
