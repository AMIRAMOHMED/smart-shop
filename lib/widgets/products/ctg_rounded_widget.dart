import 'package:flutter/cupertino.dart';
import 'package:shop_smart/screens/search_screen.dart';
import 'package:shop_smart/widgets/subtitle_text.dart';

class CategroyRoundedWeidget extends StatelessWidget {
  const CategroyRoundedWeidget(
      {required this.image, required this.name, super.key});
  final String name, image;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () async {
      await Navigator.pushNamed(
        context,
       SearchScreen.id,arguments:name,
      );
    },
      child: Column(
        children: [
          Image.asset(
            image,
            height: 50,
            width: 50,
          ),
          const SizedBox(
            height: 15,
          ),
          SubtitleTextWidget(
            label: name,
            fontSize: 14,
            fontWeight: FontWeight.bold,
          )
        ],
      ),
    );
  }
}
