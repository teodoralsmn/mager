import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:mager/app/home/home_page.dart';
import 'package:mager/app/register_screen/register_page.dart';
import 'package:mager/shared/firestore/firestore_helper.dart';
import 'package:mager/shared/function/show_snackbar.dart';
import 'package:mager/shared/models/user_model.dart';
import 'package:mager/shared/providers/user_provider.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stacked/stacked.dart';
import 'package:string_validator/string_validator.dart';

class LoginVM extends BaseViewModel {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  String? emailValidation;
  String? passwordValidation;

  bool rememberMe = false;
  bool showPassword = false;

  onLoadRemember() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    if (prefs.getString('remember') != null) {
      emailController.text = json.decode(prefs.getString('remember')!)['email'];
      passwordController.text =
          json.decode(prefs.getString('remember')!)['password'];
      notifyListeners();
    }
  }

  onEmailValidation(String value) {
    if (value.isEmpty) {
      emailValidation = 'Please enter your email';
    } else {
      if (isEmail(value)) {
        emailValidation = null;
      } else {
        emailValidation = 'Email not valid';
      }
    }
    notifyListeners();
  }

  onPasswordValidation(String value) {
    if (value.isEmpty) {
      passwordValidation = 'Please enter your email';
    } else {
      passwordValidation = null;
    }
    notifyListeners();
  }

  onChangePassword(bool value) {
    showPassword = value;
    notifyListeners();
  }

  onChangeRememberMe(bool value) {
    rememberMe = value;
    notifyListeners();
  }

  onTapRegister(BuildContext context) {
    Navigator.push(
        context, MaterialPageRoute(builder: (_) => const RegisterPage()));
  }

  onTapLogin(BuildContext context) {
    onEmailValidation(emailController.text);
    onPasswordValidation(passwordController.text);

    if (emailValidation == null && passwordValidation == null) {
      EasyLoading.show();
      FirebaseAuth.instance
          .signInWithEmailAndPassword(
              email: emailController.text, password: passwordController.text)
          .then((value) async {
        EasyLoading.dismiss();
        if (value.user == null) {
          showSnackbar(context,
              message: 'User data not found, please try again later',
              customColor: Colors.orange);
        } else {
          EasyLoading.show();
          DocumentSnapshot<Map<String, dynamic>> result =
              await FirestoreHelper.getCollection(
                      FirestoreHelper.userCollection)
                  .doc(value.user!.uid)
                  .get();

          EasyLoading.dismiss();

          if (result.exists) {
            if (context.mounted) {
              UserModel dataUser =
                  UserModel.fromJson(result.data()!, value.user!.uid);
              Provider.of<UserProvider>(context, listen: false)
                  .onCreateSession(dataUser);

              if (rememberMe) {
                SharedPreferences prefs = await SharedPreferences.getInstance();
                prefs.setString(
                    'remember',
                    json.encode({
                      'email': emailController.text,
                      'password': passwordController.text
                    }));
              } else {
                SharedPreferences prefs = await SharedPreferences.getInstance();
                prefs.remove('remember');
              }

              if (context.mounted) {
                Navigator.push(context,
                    MaterialPageRoute(builder: (_) => const HomePage()));

                showSnackbar(context,
                    message: 'Login Success', customColor: Colors.green);
              }
            }
          } else {
            if (context.mounted) {
              showSnackbar(context,
                  message: 'Password or email wrong, please try again later',
                  customColor: Colors.orange);
            }
          }
        }
      }).onError((error, stackTrace) {
        EasyLoading.dismiss();
        showSnackbar(context,
            message: "Daftar dulu", customColor: Colors.orange);
            
      });
    } else {
      showSnackbar(context,
          message: 'Please check your submission', customColor: Colors.orange);
    }
  }
}
