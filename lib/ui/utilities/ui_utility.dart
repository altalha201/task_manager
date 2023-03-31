import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';

import 'application_colors.dart';

class UIUtility {

  static String verificationString = "A 6-digit verification cod will send to your email address";
  static String logoName = "assets/images/logo.svg";
  static String subtitlePass = "Minimum length password 8 character with Letter and Number Combination";

  static Icon proceedIcon = const Icon(
    Icons.arrow_circle_right_outlined,
    size: 30,
  );

  static Widget processing = const Center(
    child: CircularProgressIndicator(
      color: colorWhite,
    ),
  );

  static Widget processingGreen = const Center(
      child: CircularProgressIndicator(
        color: colorGreen,
      ),
    );

  static showBase64Image(base64String) {
    UriData? data = Uri.parse(base64String).data;
    Uint8List image;
    if(data != null) {
      image = data.contentAsBytes();
    } else {
      image = base64Decode(base64String);
    }
    return image;
  }
}
