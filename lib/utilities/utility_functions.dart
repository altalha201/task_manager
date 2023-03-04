import 'dart:typed_data';

showBase64Image(base64String) {
  UriData? data = Uri.parse(base64String).data;
  Uint8List image = data!.contentAsBytes();
  return image;
}