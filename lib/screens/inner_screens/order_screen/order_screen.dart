import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../services/assest_manger.dart';
import '../../../widgets/empty_bag.dart';
import '../../../widgets/title_text_.dart';
import 'order_widget_free.dart';

class OrderScreen extends StatefulWidget {
  const OrderScreen({super.key});
  static const id = "OrderScreen";
  @override
  State<OrderScreen> createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  bool isEmptyOrders = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const TitlesTextWidget(
            fontSize: 20,
            label: 'Placed orders',
          ),
        ),
        body: isEmptyOrders
            ? EmptyBag(
                imagePath: AssetsManager.orderBag,
                title: "No orders has been placed yet",
                buttonText: "Shop now",
                subTitle: '',
              )
            : ListView.separated(
                itemCount: 15,
                itemBuilder: (ctx, index) {
                  return const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 2, vertical: 6),
                    child: OrdersWidgetFree(),
                  );
                },
                separatorBuilder: (BuildContext context, int index) {
                  return const Divider();
                },
              ));
  }
}
