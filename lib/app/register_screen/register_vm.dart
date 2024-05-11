import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:mager/shared/firestore/auth_firestore.dart';
import 'package:mager/shared/function/show_snackbar.dart';
import 'package:stacked/stacked.dart';
import 'package:string_validator/string_validator.dart';

class RegisterVM extends BaseViewModel {
  TextEditingController emailController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmController = TextEditingController();

  String? emailValidation;
  String? nameValidation;
  String? passwordValidation;
  String? confirmValidation;

  bool isShowPassword = false;

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

  onNameValidation(String value) {
    if (value.isEmpty) {
      nameValidation = 'Please enter your name';
    } else {
      if (isAlpha(value.replaceAll(' ', ''))) {
        nameValidation = null;
      } else {
        nameValidation = 'Name not valid, please enter alphabet character only';
      }
    }
    notifyListeners();
  }

  onPasswordValidation(String value) {
    if (value.isEmpty) {
      passwordValidation = 'Please enter your email';
    } else {
      if (value.length < 6) {
        passwordValidation = 'Minimum character is 6';
      } else {
        passwordValidation = null;
      }
    }
    notifyListeners();
  }

  onConfirmValidation(String value) {
    if (value.isEmpty) {
      confirmValidation = 'Please confirm your password';
    } else {
      if (value == passwordController.text) {
        confirmValidation = null;
      } else {
        confirmValidation = 'Password not match';
      }
    }
    notifyListeners();
  }

  onChangeShowPassword(bool value) {
    isShowPassword = value;
    notifyListeners();
  }

  onSubmitRegister(BuildContext context) {
    onEmailValidation(emailController.text);
    onNameValidation(nameController.text);
    onPasswordValidation(passwordController.text);
    onConfirmValidation(confirmController.text);

    if (emailValidation == null &&
        nameValidation == null &&
        passwordValidation == null &&
        confirmValidation == null) {
      EasyLoading.show();

      FirebaseAuth.instance
          .createUserWithEmailAndPassword(
              email: emailController.text, password: passwordController.text)
          .then((value) {
        if (value.user != null) {
          AuthFirestore.addUser(
            idAuth: value.user!.uid,
            email: emailController.text,
            name: nameController.text,
          ).then((value) {
            EasyLoading.dismiss();
            if (value) {
              Navigator.pop(context);
              showSnackbar(context,
                  message: 'Register success, please login',
                  customColor: Colors.green);
            } else {
              showSnackbar(context,
                  message: 'Failed to add data, please try again later',
                  customColor: Colors.orange);
            }
          });
        } else {
          EasyLoading.dismiss();
          showSnackbar(context,
              message: 'Something wrong, please try again later',
              customColor: Colors.orange);
        }
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
