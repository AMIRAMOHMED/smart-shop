import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';
import 'package:shop_smart/widgets/title_text_.dart';

import '../widgets/subtitle_text.dart';
import 'assest_manger.dart';

class MyAppMethods {
  static Future<void> showErrorOrWarningDialog(
      {required String subTitle,
      required BuildContext context,
      bool isError = true,
      required Function fct}) async {
    await showDialog(
        builder: (context) {
          return AlertDialog(
            actionsAlignment: MainAxisAlignment.center,
            actions: [
              Visibility(
                visible: !isError,
                child: TextButton(
                  child: const SubtitleTextWidget(
                    label: "canel",
                    fontSize: 20,
                    color: Colors.green,
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ),
              TextButton(
                  child: const SubtitleTextWidget(
                    label: "ok",
                    fontSize: 20,
                    color: Colors.red,
                  ),
                  onPressed: () {
                    fct();
                    Navigator.pop(context);
                  }),
            ],
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Image.asset(
                  AssetsManager.warning,
                  height: 60,
                  width: 60,
                ),
                const SizedBox(
                  height: 60,
                ),
                SubtitleTextWidget(
                  label: subTitle,
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                )
              ],
            ),
          );
        },
        context: context);
  }

  static Future<void> imagePickerDialog({
    required BuildContext context,
    required Function galleryFct,
    required Function removeFct,
    required Function cameraFct,
  }) async {
    await showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Center(
              child: TitlesTextWidget(
                label: "Choose Option",
                fontSize: 20,
              ),
            ),
            content: SingleChildScrollView(
              child: ListBody(
                children: [
                  TextButton.icon(
                      onPressed: () {
                        cameraFct();
                        if (Navigator.canPop(context)) {
                          Navigator.pop(context);
                        }
                      },
                      icon: const Icon(IconlyLight.camera),
                      label: const Text("Camera")),
                  TextButton.icon(
                      onPressed: () {
                        galleryFct();
                        if (Navigator.canPop(context)) {
                          Navigator.pop(context);
                        }
                      },
                      icon: const Icon(IconlyLight.image),
                      label: const Text("Gallery")),
                  TextButton.icon(
                      onPressed: () {
                        removeFct();
                        if (Navigator.canPop(context)) {
                          Navigator.pop(context);
                        }
                      },
                      icon: const Icon(IconlyLight.delete),
                      label: const Text("Remove"))
                ],
              ),
            ),
          );
        });
  }
}
