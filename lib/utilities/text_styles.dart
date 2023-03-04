import 'package:flutter/material.dart';
import 'package:task_manager/utilities/application_colors.dart';

TextStyle authHeadline(textColor) => TextStyle(
  color: textColor,
  fontSize: 28,
  fontFamily: 'poppins',
  fontWeight: FontWeight.w700,
);

TextStyle authSubtitle(textColor) => TextStyle(
  color: textColor,
  fontSize: 14,
  fontFamily: 'poppins',
  fontWeight: FontWeight.w200,
);

TextStyle authTextButton(textColor) => TextStyle(
  color: textColor,
  fontSize: 13,
  fontFamily: 'poppins',
  fontWeight: FontWeight.w200,
);

TextStyle authButton(textColor) => TextStyle(
  color: textColor,
  fontSize: 16,
  fontFamily: "poppins",
  fontWeight: FontWeight.w500
);

TextStyle appBarTitle(textColor) => TextStyle(
    color: textColor,
    fontSize: 16,
    fontFamily: "poppins",
    fontWeight: FontWeight.w900,
    letterSpacing: 1.0
);

TextStyle appBarSubtitle(textColor) => TextStyle(
    color: textColor,
    fontSize: 10,
    fontFamily: "poppins",
    fontWeight: FontWeight.w700,
    letterSpacing: 1.0
);

TextStyle taskTitle() => const TextStyle(
    color: colorDarkBlue,
    fontSize: 16,
    fontFamily: "poppins",
    fontWeight: FontWeight.w600
);

TextStyle statusStyle(textColor) => TextStyle(
    color: textColor,
    fontSize: 12,
    fontFamily: "poppins",
    fontWeight: FontWeight.bold
);

TextStyle taskNumber() => const TextStyle(
    fontSize: 24,
    fontFamily: "poppins",
    fontWeight: FontWeight.bold,
    letterSpacing: 1.0
);

