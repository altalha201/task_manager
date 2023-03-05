import 'dart:typed_data';

import 'package:flutter/material.dart';

import 'application_colors.dart';

class Utility {
  static Icon proceedIcon = const Icon(
    Icons.arrow_circle_right_outlined,
    size: 30,
  );
  static Widget processing = const Center(
    child: CircularProgressIndicator(
      color: colorGreen,
    ),
  );

  showBase64Image(base64String) {
    UriData? data = Uri.parse(base64String).data;
    Uint8List image = data!.contentAsBytes();
    return image;
  }
}
