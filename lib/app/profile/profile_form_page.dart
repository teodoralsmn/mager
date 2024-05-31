import 'dart:io';

import 'package:flutter/material.dart';
import 'package:mager/app/profile/profile_form_vm.dart';
import 'package:mager/shared/font_style.dart';
import 'package:mager/shared/providers/user_provider.dart';
import 'package:mager/shared/size_helper.dart';
import 'package:mager/shared/theme_style.dart';
import 'package:mager/shared/widgets/custom_button.dart';
import 'package:mager/shared/widgets/custom_textfield.dart';
import 'package:mager/shared/widgets/status_bar_widget.dart';
import 'package:provider/provider.dart';
import 'package:stacked/stacked.dart';

class ProfileFormPage extends StatelessWidget {
  const ProfileFormPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<ProfileFormVM>.reactive(viewModelBuilder: () {
      return ProfileFormVM();
    }, builder: (context, model, child) {
      return StatusbarWidget(
          customBrightness: Brightness.light,
          child: Scaffold(
              body: Column(children: [
            Container(
              padding: EdgeInsets.only(
                top: MediaQuery.of(context).padding.top + margin16,
                bottom: margin16,
              ),
              decoration: const BoxDecoration(
                  color: Color(0xff436edb),
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(50),
                      bottomRight: Radius.circular(50))),
              alignment: Alignment.center,
              child: Stack(
                children: [
                  Center(
                    child: Text(
                      'Profile',
                      style: mainBody1.copyWith(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                  ),
                  Positioned(
                    left: margin32,
                    child: GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: const Icon(
                        Icons.arrow_back,
                        color: Colors.white,
                      ),
                    ),
                  )
                ],
              ),
            ),
            Expanded(
                child: ListView(
              padding: EdgeInsets.symmetric(horizontal: margin16),
              children: [
                SizedBox(
                  height: margin16,
                ),
                Center(
                  child: GestureDetector(
                    onTap: () {
                      model.onPickImage(context);
                    },
                    child: Stack(
                      children: [
                        model.selectedImage != null
                            ? Container(
                                width: 100,
                                height: 100,
                                decoration: BoxDecoration(
                                    image: DecorationImage(
                                        fit: BoxFit.cover,
                                        image: FileImage(
                                            File(model.selectedImage!.path))),
                                    shape: BoxShape.circle,
                                    color: Colors.black12),
                              )
                            : Provider.of<UserProvider>(context, listen: false)
                                        .data!
                                        .profilePicture ==
                                    null
                                ? Icon(
                                    Icons.account_circle,
                                    color: isDarkTheme(context)
                                        ? Colors.white
                                        : Colors.black87,
                                    size: 100,
                                  )
                                : Container(
                                    width: 100,
                                    height: 100,
                                    decoration: BoxDecoration(
                                        image: DecorationImage(
                                            fit: BoxFit.cover,
                                            image: NetworkImage(
                                                Provider.of<UserProvider>(
                                                        context,
                                                        listen: false)
                                                    .data!
                                                    .profilePicture!)),
                                        shape: BoxShape.circle,
                                        color: Colors.black12),
                                  ),
                        Positioned(
                          bottom: 0,
                          right: 0,
                          child: Container(
                            width: 30,
                            height: 30,
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.blue,
                                border: Border.all(color: Colors.white)),
                            alignment: Alignment.center,
                            child: const Icon(
                              Icons.camera_alt,
                              size: 18,
                              color: Colors.white,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: margin16,
                ),
                Text(
                  'Phone',
                  style: mainBodyFont(context),
                ),
                CustomTextfield(
                  hintText: 'Fill Phone Number..',
                  controller: model.phoneController,
                  keyboardType: TextInputType.number,
                ),
                SizedBox(
                  height: margin32,
                ),
                SizedBox(
                  height: margin32,
                ),
                Text(
                  'Email',
                  style: mainBodyFont(context),
                ),
                CustomTextfield(
                  hintText: 'Update Email..',
                  controller: model.emailController,
                  keyboardType: TextInputType.name,
                ),
                SizedBox(
                  height: margin32,
                ),
                CustomButton(
                  title: 'Save',
                  onTap: () {
                    model.onSaveData(context);
                  },
                ),
                SizedBox(
                  height: margin32,
                )
              ],
            ))
          ])));
    });
  }
}
