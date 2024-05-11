import 'package:flutter/material.dart';
import 'package:mager/app/settings/category_page.dart';
import 'package:mager/app/settings/pin_page.dart';
import 'package:mager/shared/providers/user_provider.dart';
import 'package:mager/shared/theme_preferences/theme_provider.dart';
import 'package:mager/shared/theme_style.dart';
import 'package:provider/provider.dart';
import 'package:stacked/stacked.dart';

class SettingVM extends BaseViewModel {
  onChangeTheme(BuildContext context) {
    final themeChanged = Provider.of<ThemeProvider>(context, listen: false);
    themeChanged.theme = isDarkTheme(context) ? 'light' : 'dark';
  }

  onTapCategory(BuildContext context) {
    Navigator.push(
        context, MaterialPageRoute(builder: (_) => const CategoryPage()));
  }

  onTapPin(BuildContext context) async {
    bool? result = await Navigator.push(
        context,
        MaterialPageRoute(
            builder: (_) => PinPage(
                currentPin: Provider.of<UserProvider>(context, listen: false)
                    .data!
                    .pin)));

    if (result != null) {
      notifyListeners();
    }
  }
}
