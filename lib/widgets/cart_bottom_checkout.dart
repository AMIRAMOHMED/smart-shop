import 'package:flutter/material.dart';
import 'package:shop_smart/widgets/subtitle_text.dart';
import 'package:shop_smart/widgets/title_text_.dart';

class CartButtomCheckOut extends StatelessWidget {
  const CartButtomCheckOut({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          border: const Border(top: BorderSide(width: 1, color: Colors.grey)),
          color: Theme.of(context).scaffoldBackgroundColor),
      child: SizedBox(
          height: kBottomNavigationBarHeight + 20,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18.0, vertical: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Flexible(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      FittedBox(
                        child: TitlesTextWidget(
                            label: "Total(6 products/6 item )", fontSize: 20),
                      ),
                      SubtitleTextWidget(
                        label: "16.99\$",
                        fontSize: 18,
                        color: Colors.blue,
                      )
                    ],
                  ),
                ),
                ElevatedButton(onPressed: () {}, child: const Text("CheckOut"))
              ],
            ),
          )),
    );
  }
}
