import 'package:flutter/material.dart';
import 'package:mager/app/home/home_main_page.dart';
import 'package:mager/app/profile/profile_page.dart';
import 'package:mager/app/settings/settings_page.dart';
import 'package:stacked/stacked.dart';

class HomeVM extends BaseViewModel {
  int selectedIndex = 0;

  onChangeIndex(int value) {
    selectedIndex = value;
    notifyListeners();
  }

  Widget getScreen() {
    if (selectedIndex == 2) {
      return const SettingsPage();
    } else if (selectedIndex == 1) {
      return const ProfilePage();
    } else if (selectedIndex == 0) {
      return const HomeMainPage();
    }

    return Container();
  }
}
