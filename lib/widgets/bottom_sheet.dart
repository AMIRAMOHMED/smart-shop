import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shop_smart/widgets/subtitle_text.dart';

class QuantityBottomSheetWidget extends StatelessWidget {
  const QuantityBottomSheetWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(
          height: 20,
        ),
        Container(
          height: 6,
          width: 50,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30),
              color: CupertinoColors.inactiveGray),
        ),
        const SizedBox(
          height: 20,
        ),
        Expanded(
          child: ListView.builder(
            itemCount: 30,
            itemBuilder: (context, index) {
              return InkWell(
                onTap: (){
                  log("index $index");
                },
                child: Center(
                    child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SubtitleTextWidget(label: "${index + 1}", fontSize: 20),
                )),
              );
            },
          ),
        ),
      ],
    );
  }
}
