import 'package:flutter/material.dart';

import '../utils/app_config.dart';
import 'my_text_style.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    super.key,
    this.title,
    this.btnColor,
    this.clr,
    this.elevation,
    this.fontSize,
    this.minWidth,
    this.padding,
    this.radius,
    required this.onTap,
  });
  final String? title;
  final double? fontSize;
  final EdgeInsetsGeometry? padding;
  final double? minWidth;
  final double? elevation;
  final Color? btnColor;
  final Color? clr;
  final VoidCallback onTap;
  final double? radius;

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: onTap,
      color: btnColor ?? AppConfig.kPrimaryColor,
      minWidth: minWidth ?? 0,
      height: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(radius ?? 50.0),
      ),
      padding: padding ?? const EdgeInsets.symmetric(horizontal: 50, vertical: 10.0),
      elevation: elevation ?? 4.0,
      child: Text(
        title ?? '',
        style: myTextStyle(
            size: fontSize ?? 18.0, clr:clr ?? Colors.white, fw: FontWeight.w600),
      ),
    );
  }
}
