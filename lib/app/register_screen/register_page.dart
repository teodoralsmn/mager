import 'package:flutter/material.dart';
import 'package:mager/app/register_screen/register_vm.dart';
import 'package:mager/shared/font_style.dart';
import 'package:mager/shared/size_helper.dart';
import 'package:mager/shared/widgets/custom_button.dart';
import 'package:mager/shared/widgets/custom_textfield.dart';
import 'package:mager/shared/widgets/status_bar_widget.dart';
import 'package:mager/shared/widgets/validation_widget.dart';
import 'package:stacked/stacked.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<RegisterVM>.reactive(viewModelBuilder: () {
      return RegisterVM();
    }, builder: (context, model, child) {
      return StatusbarWidget(
          child: Scaffold(
        body: Stack(
          children: [
            SizedBox(
              width: double.infinity,
              height: double.infinity,
              child: Image.asset(
                'assets/accounting_background.jpg',
                fit: BoxFit.cover,
              ),
            ),
            Container(
              width: double.infinity,
              height: double.infinity,
              color: Theme.of(context).primaryColor.withOpacity(0.4),
            ),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                    borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20)),
                    color: Theme.of(context).scaffoldBackgroundColor),
                padding: EdgeInsets.only(
                    left: margin32,
                    right: margin32,
                    top: margin16,
                    bottom: MediaQuery.of(context).padding.bottom + margin16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'REGISTER ACCOUNT',
                      style: mainBody1.copyWith(
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).primaryColor),
                    ),
                    Text(
                      'Register using Email',
                      style: mainBodyFont(context, textOpacity: 0.5),
                    ),
                    SizedBox(
                      height: margin16,
                    ),
                    Text(
                      'Email',
                      style: mainBodyFont(context),
                    ),
                    ValidationWidget(
                      validation: model.emailValidation,
                      child: CustomTextfield(
                        hintText: 'Fill Email..',
                        controller: model.emailController,
                        onChanged: (value) {
                          model.onEmailValidation(value);
                        },
                      ),
                    ),
                    SizedBox(
                      height: margin16,
                    ),
                    Text(
                      'Name',
                      style: mainBodyFont(context),
                    ),
                    ValidationWidget(
                      validation: model.nameValidation,
                      child: CustomTextfield(
                        hintText: 'Fill Name..',
                        controller: model.nameController,
                        onChanged: (value) {
                          model.onNameValidation(value);
                        },
                      ),
                    ),
                    SizedBox(
                      height: margin16,
                    ),
                    Text(
                      'Password',
                      style: mainBodyFont(context),
                    ),
                    ValidationWidget(
                      validation: model.passwordValidation,
                      child: CustomTextfield(
                        controller: model.passwordController,
                        hintText: 'Fill Password..',
                        onChanged: (value) {
                          model.onPasswordValidation(value);
                        },
                        obscureText: !model.isShowPassword,
                        maxLines: 1,
                        suffixIcon: GestureDetector(
                            onTap: () {
                              model.onChangeShowPassword(!model.isShowPassword);
                            },
                            child: Icon(
                              model.isShowPassword
                                  ? Icons.visibility_off
                                  : Icons.visibility,
                              color: model.isShowPassword
                                  ? Theme.of(context).primaryColor
                                  : Colors.grey,
                            )),
                      ),
                    ),
                    SizedBox(
                      height: margin16,
                    ),
                    Text(
                      'Confirm Password',
                      style: mainBodyFont(context),
                    ),
                    ValidationWidget(
                      validation: model.confirmValidation,
                      child: CustomTextfield(
                        controller: model.confirmController,
                        onChanged: (value) {
                          model.onConfirmValidation(value);
                        },
                        hintText: 'Fill Confirm Password..',
                        obscureText: !model.isShowPassword,
                        maxLines: 1,
                        suffixIcon: GestureDetector(
                            onTap: () {
                              model.onChangeShowPassword(!model.isShowPassword);
                            },
                            child: Icon(
                              model.isShowPassword
                                  ? Icons.visibility_off
                                  : Icons.visibility,
                              color: model.isShowPassword
                                  ? Theme.of(context).primaryColor
                                  : Colors.grey,
                            )),
                      ),
                    ),
                    SizedBox(
                      height: margin32,
                    ),
                    CustomButton(
                      onTap: () {
                        model.onSubmitRegister(context);
                      },
                      title: 'REGISTER',
                    ),
                    SizedBox(
                      height: margin16,
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ));
    });
  }
}
