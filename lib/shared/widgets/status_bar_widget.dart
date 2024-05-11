import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mager/shared/theme_style.dart';

enum StatusBarType { transparent, light }

class StatusbarWidget extends StatelessWidget {
  final Widget child;
  final Brightness? customBrightness;
  const StatusbarWidget(
      {super.key, required this.child, this.customBrightness});

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle(
            systemNavigationBarColor: Colors.black,
            statusBarColor: Colors.transparent,
            statusBarIconBrightness: customBrightness ??
                (isDarkTheme(context) ? Brightness.light : Brightness.dark)),
        child: child);
  }
}
