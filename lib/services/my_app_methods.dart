import 'package:flutter/material.dart';
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
}
