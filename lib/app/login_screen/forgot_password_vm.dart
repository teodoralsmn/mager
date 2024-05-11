import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:mager/shared/function/show_snackbar.dart';
import 'package:stacked/stacked.dart';
import 'package:string_validator/string_validator.dart';

class ForgotPasswordVM extends BaseViewModel {
  TextEditingController emailController = TextEditingController();
  String? emailValidation;

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

  onTapLogin(BuildContext context) {
    onEmailValidation(emailController.text);

    if (emailValidation == null) {
      EasyLoading.show();
      FirebaseAuth.instance
          .sendPasswordResetEmail(
        email: emailController.text,
      )
          .then((value) async {
        EasyLoading.dismiss();
        Navigator.pop(context);

        showSnackbar(context,
            message: 'Please check your email', customColor: Colors.green);
      }).onError((error, stackTrace) {
        EasyLoading.dismiss();
        showSnackbar(context,
            message: error.toString(), customColor: Colors.orange);
      });
    } else {
      showSnackbar(context,
          message: 'Please check your submission', customColor: Colors.orange);
    }
  }
}
