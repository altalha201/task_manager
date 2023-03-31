import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'application_colors.dart';

buildGetXDialog(
  {required String title,
    String? message,
    required String positiveButtonText,
    required String negativeButtonText,
    required VoidCallback positiveTap,
    required VoidCallback negativeTap}) {
  Get.defaultDialog(
    title: title,
    middleText: message ?? "",

    textConfirm: positiveButtonText,
    textCancel: negativeButtonText,
    buttonColor: colorWhite,

    confirmTextColor: colorGreen,
    cancelTextColor: colorRed,

    onConfirm: positiveTap,
    onCancel: negativeTap
  );
}