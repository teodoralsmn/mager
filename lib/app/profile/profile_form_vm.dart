import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mager/app/profile/widgets/photo_source_dialog.dart';
import 'package:mager/shared/firestore/auth_firestore.dart';
import 'package:mager/shared/function/show_snackbar.dart';
import 'package:mager/shared/providers/user_provider.dart';
import 'package:provider/provider.dart';
import 'package:stacked/stacked.dart';

class ProfileFormVM extends BaseViewModel {
  XFile? selectedImage;
  TextEditingController phoneController = TextEditingController();

  onPickImage(BuildContext context) async {
    ImageSource? result = await showDialog(
        context: context,
        builder: (context) {
          return const PhotoPickerSource();
        });

    if (result != null) {
      final ImagePicker picker = ImagePicker();
      final XFile? image = await picker.pickImage(source: result);
      if (image != null) {
        selectedImage = image;
        notifyListeners();
      }
    }
  }

  Future<String?> onUploadFile(BuildContext context) async {
    Reference ref = FirebaseStorage.instance
        .ref()
        .child('user_profile_picture')
        .child(
            '${Provider.of<UserProvider>(context, listen: false).data!.uid}.png');

    try {
      await ref.putFile(File(selectedImage!.path));
      if (context.mounted) {
        return '${Provider.of<UserProvider>(context, listen: false).data!.uid}.png';
      }
    } catch (e) {
      return null;
    }

    return null;
  }

  onSaveData(BuildContext context) async {
    String? finalImage =
        Provider.of<UserProvider>(context, listen: false).data!.profilePicture;

    if (selectedImage != null) {
      EasyLoading.show();
      finalImage = await onUploadFile(context);
      EasyLoading.dismiss();
    }

    if (context.mounted) {
      EasyLoading.show();
      AuthFirestore.changeProfile(
              uid: Provider.of<UserProvider>(context, listen: false).data!.uid,
              phone: phoneController.text,
              profilePicture: finalImage)
          .then((value) {
        EasyLoading.dismiss();

        if (value) {
          Provider.of<UserProvider>(context, listen: false).updateProfile(
              phoneController.text.isEmpty ? null : phoneController.text,
              finalImage);
          Navigator.pop(context, true);
          showSnackbar(context,
              message: 'Success update profile', customColor: Colors.green);
        } else {
          showSnackbar(context,
              message: 'Failed update profile', customColor: Colors.orange);
        }
      });
    }
  }
}
