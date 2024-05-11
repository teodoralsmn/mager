import 'package:flutter/material.dart';
import 'package:mager/shared/theme_style.dart';

showSnackbar(BuildContext context,
    {required String message, Color? customColor}) {
  final snackBar = SnackBar(
    content: Text(
      message,
    ),
    backgroundColor: customColor ?? primaryColor,
  );

  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}
