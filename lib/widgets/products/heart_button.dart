import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';

class HeartButtonWidget extends StatelessWidget {
  const HeartButtonWidget({super.key,this.size = 22,
    this.color = Colors.transparent});
  final double size;
  final Color color;
  @override
  Widget build(BuildContext context) {
    return Container(decoration: BoxDecoration(color:color ,shape: BoxShape.circle),

      child: InkWell(
        onTap: () {},
        child:  Padding(
          padding:const  EdgeInsets.all(8.0),
          child: Icon(IconlyLight.heart,size: size,),
        ),
      ),
    );
  }
}
