import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

myTextStyle(
    {double? size,
    Color? clr,
    FontWeight? fw,
    FontStyle? fStyle,
    double? lSpace,
    double? height,
    TextDecoration? decoration}) {
  return GoogleFonts.roboto(
    fontSize: size ?? 14,
    color: clr ?? Colors.black87,
    fontWeight: fw ?? FontWeight.w400,
    letterSpacing: lSpace,
    fontStyle: fStyle,
    height: height,
    decoration: decoration ?? TextDecoration.none,
  );
}
