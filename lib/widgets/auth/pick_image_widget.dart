import 'dart:io';

import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';
import 'package:image_picker/image_picker.dart';

import '../title_text_.dart';

class PickImageWidget extends StatelessWidget {
  const PickImageWidget({super.key, this.pickImage, required this.function});

  final XFile? pickImage;
  final Function function;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Padding(
          padding: const EdgeInsets.all(8),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: pickImage == null
                ? Container(
                    decoration: BoxDecoration(
                      border: Border.all(),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Center(
                        child: TitlesTextWidget(
                      label: "Add Your image",
                      fontSize: 20,
                    )),
                  )
                : Image.file(
                    File(pickImage!.path),
                    fit: BoxFit.fill,
                  ),
          ),
        ),
        Positioned(
            top: -5,
            right: -5,
            child: Material(
              borderRadius: BorderRadius.circular(16.0),
              color: Colors.lightBlue,
              child: InkWell(
                splashColor: Colors.red,
                onTap: () {
                  function();
                },
                child: const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Icon(
                      IconlyLight.plus,
                      color: Colors.white,
                    )),
              ),
            ))
      ],
    );
  }
}
