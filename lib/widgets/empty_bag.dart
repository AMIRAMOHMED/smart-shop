import 'package:flutter/material.dart';
import 'package:shop_smart/widgets/subtitle_text.dart';
import 'package:shop_smart/widgets/title_text_.dart';

class EmptyBag extends StatelessWidget {
  const EmptyBag({super.key,required this.imagePath,required this.title,required this.buttonText,required this.subTitle});
final String imagePath,title,subTitle,buttonText;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return  Padding(
      padding: const EdgeInsets.only(top: 50.0),
      child: SingleChildScrollView(
        child: Column(
          children: [
            Image.asset(imagePath,

              width: double.infinity,
              height: size.height * .35,
            ),
            const TitlesTextWidget(
              label: "Whoops",
              fontSize: 40,
              color: Colors.red,
            ),
            const SizedBox(
              height: 20,
            ),
             SubtitleTextWidget(
              label: title
              ,
              fontSize: 25,
              fontWeight: FontWeight.w500,
            ),
            const SizedBox(
              height: 20,
            ),
             SubtitleTextWidget(
              label:subTitle,

              fontSize: 20,
              fontWeight: FontWeight.w400,
            ),
            const SizedBox(
              height: 20,
            ),
            ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.all(20),
                ),
                child:  Text(
                buttonText,
                  style:const  TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ))
          ],
        ),
      ),
    );
  }
}
