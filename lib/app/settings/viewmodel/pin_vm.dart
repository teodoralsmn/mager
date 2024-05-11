import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:mager/app/home/home_page.dart';
import 'package:mager/shared/firestore/auth_firestore.dart';
import 'package:mager/shared/font_style.dart';
import 'package:mager/shared/function/show_snackbar.dart';
import 'package:mager/shared/providers/user_provider.dart';
import 'package:provider/provider.dart';
import 'package:stacked/stacked.dart';

class PINVM extends BaseViewModel {
  String currentInputPin = '';
  String enterredPin = '';
  String confirmationPIN = '';

  bool isConfirm = false;
  bool isOldConfirm = false;

  bool isLoginValidation = false;

  onInitData(String? data, bool isFromLogin) {
    if (data != null) {
      isOldConfirm = true;
      isLoginValidation = isFromLogin;
      notifyListeners();
    }
  }

  String getLabelDescription() {
    if (isOldConfirm) {
      if (isLoginValidation) {
        return 'Enter your PIN to Continue';
      } else {
        return 'Enter your old PIN';
      }
    } else {
      if (isConfirm) {
        return 'Confirm your PIN';
      } else {
        return 'Enter your PIN';
      }
    }
  }

  onTapBackbutton(BuildContext context) {
    if (isOldConfirm) {
      if (isLoginValidation) {
        exit(0);
      } else {
        Navigator.pop(context);
      }
    } else {
      if (isConfirm) {
        isConfirm = false;
        enterredPin = '';
        notifyListeners();
      } else {
        Navigator.pop(context);
      }
    }
  }

  onTapKey(BuildContext context, int index, {String? currentPin}) {
    if (index == 11) {
      if (isOldConfirm) {
        if (currentInputPin.isNotEmpty) {
          currentInputPin =
              currentInputPin.substring(0, currentInputPin.length - 1);
          notifyListeners();
        }
      } else {
        if (isConfirm) {
          if (confirmationPIN.isNotEmpty) {
            confirmationPIN =
                confirmationPIN.substring(0, confirmationPIN.length - 1);
            notifyListeners();
          }
        } else {
          if (enterredPin.isNotEmpty) {
            enterredPin = enterredPin.substring(0, enterredPin.length - 1);
            notifyListeners();
          }
        }
      }
    } else if (index == 9) {
    } else {
      String finalText = index == 10 ? '0' : (index + 1).toString();

      if (isOldConfirm) {
        if (currentInputPin.length < 4) {
          currentInputPin = currentInputPin + finalText;
        }
      } else {
        if (isConfirm) {
          if (confirmationPIN.length < 4) {
            confirmationPIN = confirmationPIN + finalText;
          }
        } else {
          if (enterredPin.length < 4) {
            enterredPin = enterredPin + finalText;
          }
        }
      }

      notifyListeners();
    }

    if (isOldConfirm) {
      if (currentInputPin.length == 4) {
        if (currentPin != null) {
          if (currentInputPin == currentPin) {
            if (isLoginValidation) {
              Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (_) => const HomePage()),
                  (route) => false);
            } else {
              isOldConfirm = false;
              notifyListeners();
            }
          } else {
            showSnackbar(context,
                message: 'Wrong PIN', customColor: Colors.orange);
            currentInputPin = '';
            notifyListeners();
          }
        }
      }
    } else {
      if (isConfirm) {
        if (confirmationPIN.length == 4) {
          if (confirmationPIN == enterredPin) {
            EasyLoading.show();
            AuthFirestore.changePIN(
                    uid: Provider.of<UserProvider>(context, listen: false)
                        .data!
                        .uid,
                    pin: enterredPin)
                .then((value) {
              EasyLoading.dismiss();
              if (value) {
                Navigator.pop(context, true);
                Provider.of<UserProvider>(context, listen: false)
                    .updatePin(enterredPin);
                showSnackbar(context,
                    message: 'Success Update PIN', customColor: Colors.green);
              } else {
                showSnackbar(context,
                    message: 'Failed to update PIN, please try again later',
                    customColor: Colors.orange);
              }
            });
          } else {
            confirmationPIN = '';
            notifyListeners();
            showSnackbar(context,
                message: 'PIN is not match', customColor: Colors.orange);
          }
        }
      } else {
        if (enterredPin.length == 4) {
          isConfirm = true;
          notifyListeners();
        }
      }
    }
  }

  Widget getLabelKey(int index) {
    if (index == 9) {
      return Container();
    } else if (index == 11) {
      return const Icon(
        Icons.backspace_outlined,
        color: Colors.white,
      );
    } else {
      return Text(
        index == 10 ? '0' : (index + 1).toString(),
        style: mainBody1.copyWith(
            fontWeight: FontWeight.bold, color: Colors.white),
      );
    }
  }
}
