import 'package:flutter/material.dart';

import '../utilities/application_colors.dart';

class AppTextField extends StatelessWidget {

  final String hint;
  final TextEditingController controller;
  final bool? obscureText;

  const AppTextField({
    Key? key,
    required this.hint,
    this.obscureText,
    required this.controller
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: obscureText ?? false,
      decoration: InputDecoration(
          focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: colorGreen, width: 1),
          ),
          fillColor: colorWhite,
          filled: true,
          contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: colorWhite, width: 0.0),
          ),
          border: const OutlineInputBorder(),
          labelText: hint
      ),
    );
  }
}
