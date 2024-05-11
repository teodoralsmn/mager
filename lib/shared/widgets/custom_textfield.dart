import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mager/shared/font_style.dart';
import 'package:mager/shared/size_helper.dart';

class CustomTextfield extends StatelessWidget {
  final String? hintText;
  final Widget? suffixIcon;
  final TextEditingController? controller;
  final Function(String)? onChanged;
  final int? maxLines;
  final List<TextInputFormatter>? inputFormatters;
  final bool obscureText;
  final TextStyle? customHintStyle;
  final TextStyle? customStyle;
  final TextInputType? keyboardType;
  const CustomTextfield(
      {super.key,
      this.controller,
      this.inputFormatters,
      this.hintText,
      this.maxLines,
      this.suffixIcon,
      this.customHintStyle,
      this.customStyle,
      this.keyboardType,
      this.onChanged,
      this.obscureText = false});

  @override
  Widget build(BuildContext context) {
    return TextField(
      obscureText: obscureText,
      inputFormatters: inputFormatters,
      keyboardType: keyboardType,
      controller: controller,
      style: customStyle ?? mainBodyFont(context),
      maxLines: maxLines,
      onChanged: onChanged,
      decoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(vertical: margin8),
          isDense: true,
          hintText: hintText,
          suffixIcon: suffixIcon,
          hintStyle:
              customHintStyle ?? mainBodyFont(context, textOpacity: 0.38)),
    );
  }
}
