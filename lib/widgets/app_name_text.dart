import 'package:shimmer/shimmer.dart';
import 'package:flutter/material.dart';
import 'package:shop_smart/widgets/title_text_.dart';

class AppNameTextWidget extends StatelessWidget {
    const AppNameTextWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      period: const Duration(seconds: 50),
      baseColor: Colors.purple,
      highlightColor: Colors.red,
      child: const  TitlesTextWidget(label:"Shop Smart",fontSize: 25,),

    );
  }
}
