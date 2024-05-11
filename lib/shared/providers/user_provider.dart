import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:mager/shared/models/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserProvider extends ChangeNotifier {
  UserModel? data;

  logout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove('login');
  }

  updatePin(String pin) {
    data!.pin = pin;
    notifyListeners();

    onCreateSession(data!);
  }

  updateProfile(String? phone, String? profilePicture) {
    data!.phone = phone;
    data!.profilePicture = profilePicture;
    notifyListeners();

    onCreateSession(data!);
  }

  onCreateSession(UserModel data) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('login', json.encode(data.toJson()));
    onSetUserData(data);
  }

  onLoadSession({required Function(UserModel) ondataReady}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    Map<String, dynamic> rawData = json.decode(prefs.getString('login')!);

    onSetUserData(UserModel.fromJson(rawData, rawData['uid']));
    ondataReady(UserModel.fromJson(rawData, rawData['uid']));
  }

  onSetUserData(UserModel dataParam) {
    data = dataParam;
    notifyListeners();
  }
}
