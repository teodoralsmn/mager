import 'package:flutter/material.dart';
import 'package:mager/shared/theme_style.dart';

enum FontBodyType { body1, body2, body3, body4, body5, body6, body7 }

TextStyle mainFont = const TextStyle();
TextStyle secondaryFont = const TextStyle();

TextStyle mainHeading1 = mainFont.copyWith(
  fontSize: 84,
);
TextStyle mainHeading2 = mainFont.copyWith(
  fontSize: 64,
);
TextStyle mainHeading3 = mainFont.copyWith(
  fontSize: 48,
);
TextStyle mainHeading4 = mainFont.copyWith(
  fontSize: 40,
);
TextStyle mainHeading5 = mainFont.copyWith(
  fontSize: 32,
);
TextStyle mainHeading6 = mainFont.copyWith(
  fontSize: 24,
);

double getBodyFontSize(FontBodyType data) {
  if (data == FontBodyType.body1) {
    return 20;
  } else if (data == FontBodyType.body2) {
    return 18;
  } else if (data == FontBodyType.body3) {
    return 16;
  } else if (data == FontBodyType.body5) {
    return 12;
  } else if (data == FontBodyType.body6) {
    return 10;
  } else if (data == FontBodyType.body7) {
    return 8;
  }

  return 14;
}

TextStyle mainBodyFont(BuildContext context,
    {FontBodyType type = FontBodyType.body4, double textOpacity = 1}) {
  return mainFont.copyWith(
      fontSize: getBodyFontSize(type),
      color:
          Theme.of(context).scaffoldBackgroundColor != basicBackgroundDarkColor
              ? Colors.black87.withOpacity(textOpacity)
              : Colors.white.withOpacity(textOpacity));
}

TextStyle mainBody1 = mainFont.copyWith(fontSize: 20);
TextStyle mainBody2 = mainFont.copyWith(fontSize: 18);
TextStyle mainBody3 = mainFont.copyWith(fontSize: 16);
TextStyle mainBody4 = mainFont.copyWith(fontSize: 14);
TextStyle mainBody5 = mainFont.copyWith(fontSize: 11);
TextStyle mainBody6 = mainFont.copyWith(fontSize: 8);

TextStyle secondaryBody1 = secondaryFont.copyWith(fontSize: 20);
TextStyle secondaryBody2 = secondaryFont.copyWith(fontSize: 18);
TextStyle secondaryBody3 = secondaryFont.copyWith(fontSize: 16);
TextStyle secondaryBody4 = secondaryFont.copyWith(fontSize: 14);
TextStyle secondaryBody5 = secondaryFont.copyWith(fontSize: 12);
TextStyle secondaryButton1 = secondaryFont.copyWith(fontSize: 16);
TextStyle secondaryButton2 = secondaryFont.copyWith(fontSize: 14);
