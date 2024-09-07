import 'package:flutter/material.dart';
import 'package:flutter_to_do_app/utils/app_config.dart';
import 'my_text_style.dart';

// ignore: must_be_immutable
class CustomTextField extends StatelessWidget {
  const CustomTextField({
    super.key,
    this.prefixIcon,
    this.inputType,
    this.lebelText,
    this.maxLine,
    this.data,
    this.hintText,
    this.initialText,
    this.suffixIcon,
    this.formatter,
    this.obscureText,
    this.controller,
    this.onChanged,
    this.fillColor,
    this.validatorText,
    this.padding,
    this.radius,
    this.readOnly,
    this.minLines,
    this.textInputAction,
    this.maxLength,
    this.textAlign,
    this.textAlignVertical,
    this.counterText,
    this.onTap,
    this.textStyle,
    this.hintStyle,
    this.textCopyPaste,
    this.floatingLabelBehavior,
    this.textFieldHeight,
    this.validator,
    this.focusNode,
  });

  final TextEditingController? controller;
  final dynamic data;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final String? initialText;
  final String? hintText;
  final int? maxLine;
  final String? lebelText;
  final dynamic formatter;
  final TextInputType? inputType;
  final bool? obscureText;
  final Color? fillColor;
  final void Function(String)? onChanged;
  final String? validatorText;
  final EdgeInsetsGeometry? padding;
  final double? radius;
  final bool? readOnly;
  final int? minLines;
  final TextInputAction? textInputAction;
  final int? maxLength;
  final TextAlign? textAlign;
  final TextAlignVertical? textAlignVertical;
  final String? counterText;
  final VoidCallback? onTap;
  final TextStyle? textStyle;
  final TextStyle? hintStyle;
  final bool? textCopyPaste;
  final FloatingLabelBehavior? floatingLabelBehavior;
  final double? textFieldHeight;
  final String? Function(String?)? validator;
  final FocusNode? focusNode;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      // padding: EdgeInsets.symmetric(vertical: 6.0),
      height: textFieldHeight,
      child: TextFormField(
        // showCursor: true,
        onTap: onTap,
        focusNode: focusNode,
        readOnly: readOnly ?? false,
        minLines: minLines ?? 1,
        maxLines: maxLine ?? 1,
        initialValue: initialText,
        keyboardType: inputType ?? TextInputType.text,
        controller: controller,
        inputFormatters: formatter,
        // autocorrect: true,
        enableInteractiveSelection: textCopyPaste ?? true,

        obscureText: obscureText ?? false,
        obscuringCharacter: '*',
        validator: validator ??
            (value) {
              if ((value == null || value.isEmpty) &&
                  (validatorText != null && validatorText != '')) {
                return '$validatorText';
              }
              return null;
            },
        //onSaved: (String value) => data[keyy] = value,
        // onChanged: (initialText) => {},
        onChanged: onChanged,
        textInputAction: textInputAction ?? TextInputAction.done,
        autofocus: false,
        style: textStyle ??
            myTextStyle(clr: Colors.black87, lSpace: 1.0, size: 16.0),
        maxLength: maxLength,
        textAlign: textAlign ?? TextAlign.start,

        textAlignVertical: textAlignVertical,
        decoration: InputDecoration(
          counterText: counterText,
          fillColor: fillColor ?? Colors.white,
          filled: true,
          floatingLabelBehavior:
              floatingLabelBehavior ?? FloatingLabelBehavior.auto,
          floatingLabelStyle: myTextStyle(
            size: 16.0,
            clr: AppConfig.kPrimaryColor,
            fw: FontWeight.w400,
          ),
          errorStyle: myTextStyle(clr: Colors.red, size: 12.0),
          border: InputBorder.none,
          labelText: lebelText,
          suffixIcon: suffixIcon,
          prefixIcon: prefixIcon,
          labelStyle: const TextStyle(color: Colors.black, fontSize: 16),
          hintText: hintText,
          hintStyle: hintStyle ??
              myTextStyle(
                clr: Colors.black38,
                fw: FontWeight.w400,
                size: 16.0,
              ),
          contentPadding:
              padding ?? const EdgeInsets.fromLTRB(12.0, 10.0, 12.0, 10.0),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.grey.shade400, width: 0.6),
            borderRadius: BorderRadius.all(Radius.circular(radius ?? 50.0)),
          ),
          errorBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: AppConfig.kPrimaryColor, width: 0.6),
            borderRadius: BorderRadius.all(Radius.circular(radius ?? 50.0)),
          ),
          disabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.grey.shade400, width: 0.6),
            borderRadius: BorderRadius.all(Radius.circular(radius ?? 50.0)),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: AppConfig.kPrimaryColor, width: 0.6),
            borderRadius: BorderRadius.all(Radius.circular(radius ?? 50.0)),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: AppConfig.kPrimaryColor, width: 0.6),
            borderRadius: BorderRadius.all(Radius.circular(radius ?? 50.0)),
          ),
        ),
      ),
    );
  }
}
