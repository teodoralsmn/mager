import 'package:flutter/material.dart';

Color primaryColor = const Color(0xff0f195f);
Color disablePrimaryColor = const Color(0xff9aa5ad);
Color basicBackgroundColor = const Color(0xffe8eef0);
Color basicBackgroundDarkColor = const Color(0xff171818);

ThemeData lightTheme = ThemeData(
    cardColor: Colors.white,
    dividerColor: Colors.transparent,
    primaryColor: primaryColor,
    scaffoldBackgroundColor: Colors.white);

ThemeData darkTheme = ThemeData(
    primaryColor: const Color(0xff436edb),
    dividerColor: Colors.transparent,
    cardColor: const Color(0xff2e3030),
    scaffoldBackgroundColor: basicBackgroundDarkColor);

bool isDarkTheme(BuildContext context) {
  return Theme.of(context).scaffoldBackgroundColor == basicBackgroundDarkColor;
}
