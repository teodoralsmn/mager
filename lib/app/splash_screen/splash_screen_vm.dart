import 'package:flutter/material.dart';
import 'package:mager/app/home/home_page.dart';
import 'package:mager/app/login_screen/login_page.dart';
import 'package:mager/app/settings/pin_page.dart';
import 'package:mager/shared/providers/user_provider.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stacked/stacked.dart';

class SplashScreenVM extends BaseViewModel {
  onInit(BuildContext context) {
    Future.delayed(const Duration(seconds: 3), () async {
      SharedPreferences prefs = await SharedPreferences.getInstance();

      String? dataLogin = prefs.getString('login');

      if (context.mounted) {
        if (dataLogin == null) {
          Navigator.push(
              context, MaterialPageRoute(builder: (_) => const LoginPage()));
        } else {
          Provider.of<UserProvider>(context, listen: false).onLoadSession(
              ondataReady: (data) {
            if (data.pin == null) {
              Navigator.push(
                  context, MaterialPageRoute(builder: (_) => const HomePage()));
            } else {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (_) => PinPage(
                            currentPin: data.pin,
                            isFromLogin: true,
                          )));
            }
          });
        }
      }
    });
  }
}
