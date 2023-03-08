import 'package:flutter/material.dart';
import 'package:task_manager/utilities/text_styles.dart';

import 'application_colors.dart';

buildShowDialog(BuildContext context,
    {required String title,
      String? message,
      required String positiveButtonText,
      required String negativeButtonText,
      required VoidCallback positiveTap,
      required VoidCallback negativeTap}) async {
  showDialog(
      context: context,
      builder: (context) {
        return Expanded(
          child: AlertDialog(
            title: Text(title),
            content: Text(message ?? ""),
            actions: [
              TextButton(
                  onPressed: negativeTap,
                  child: Text(
                    negativeButtonText,
                    style: authTextButton(colorRed),
                  )),
              TextButton(
                  onPressed: positiveTap,
                  child: Text(
                    positiveButtonText,
                    style: authTextButton(colorGreen),
                  ))
            ],
          ),
        );
      });
}