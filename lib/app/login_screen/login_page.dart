import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:mager/app/login_screen/forgot_password_page.dart';
import 'package:mager/app/login_screen/login_vm.dart';
import 'package:mager/shared/font_style.dart';
import 'package:mager/shared/size_helper.dart';
import 'package:mager/shared/widgets/custom_button.dart';
import 'package:mager/shared/widgets/custom_textfield.dart';
import 'package:mager/shared/widgets/status_bar_widget.dart';
import 'package:mager/shared/widgets/validation_widget.dart';
import 'package:stacked/stacked.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<LoginVM>.reactive(viewModelBuilder: () {
      return LoginVM();
    }, onViewModelReady: (model) {
      model.onLoadRemember();
    }, builder: (context, model, child) {
      return StatusbarWidget(
          child: Scaffold(
        body: Stack(
          children: [
            SizedBox(
              width: double.infinity,
              height: double.infinity,
              child: Image.asset(
                'assets/background_login.jpg',
                fit: BoxFit.cover,
              ),
            ),
            Container(
              width: 100,
              height: 100,
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
                      'LOGIN ACCOUNT',
                      style: mainBody1.copyWith(
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).primaryColor),
                    ),
                    Text(
                      'Login Using Email',
                      style: mainBodyFont(context, textOpacity: 0.5),
                    ),
                    SizedBox(
                      height: margin16,
                    ),
                    Text(
                      'Email',
                      style: mainBody4,
                    ),
                    ValidationWidget(
                      validation: model.emailValidation,
                      child: CustomTextfield(
                        controller: model.emailController,
                        hintText: 'Fill Email..',
                        onChanged: (value) {
                          model.onEmailValidation(value);
                        },
                      ),
                    ),
                    SizedBox(
                      height: margin16,
                    ),

                    
                    Text(
                      'Password',
                      style: mainBody4,
                    ),
                    ValidationWidget(
                      validation: model.passwordValidation,
                      child: CustomTextfield(
                        controller: model.passwordController,
                        hintText: 'Fill Password..',
                        onChanged: (value) {
                          model.onPasswordValidation(value);
                        },
                        maxLines: 1,
                        obscureText: !model.showPassword,
                        suffixIcon: GestureDetector(
                            onTap: () {
                              model.onChangePassword(!model.showPassword);
                            },
                            child: Icon(
                              model.showPassword
                                  ? Icons.visibility_off
                                  : Icons.visibility,
                              color: model.showPassword
                                  ? Theme.of(context).primaryColor
                                  : Colors.grey,
                            )),
                      ),
                    ),
                    SizedBox(
                      height: margin4,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            SizedBox(
                              width: 30,
                              child: Checkbox(
                                activeColor: Theme.of(context).primaryColor,
                                onChanged: (value) {
                                  model.onChangeRememberMe(value!);
                                },
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(4)),
                                value: model.rememberMe,
                              ),
                            ),
                            SizedBox(
                              width: margin4,
                            ),
                            Text(
                              'Remember Me',
                              style: mainBodyFont(context,
                                  type: FontBodyType.body5),
                            )
                          ],
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (_) =>
                                        const ForgotPasswordPage()));
                          },
                          child: Text(
                            'Forgot Password?',
                            style: mainBody5.copyWith(
                                color: Theme.of(context).primaryColor,
                                fontWeight: FontWeight.bold),
                          ),
                        )
                      ],
                    ),
                    SizedBox(
                      height: margin16,
                    ),
                    CustomButton(
                      onTap: () {
                        model.onTapLogin(context);
                      },
                      title: 'LOGIN',
                      
                    ),
                    SizedBox(
                      height: margin16,
                    ),
                    SizedBox(
                      width: double.infinity,
                      child: RichText(
                          textAlign: TextAlign.center,
                          text: TextSpan(children: [
                            TextSpan(
                                text: "Doesn't have account yet? ",
                                style: mainBodyFont(
                                  context,
                                )),
                            TextSpan(
                                text: "Register Here",
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {
                                    model.onTapRegister(context);
                                  },
                                style: mainBody4.copyWith(
                                    color: Theme.of(context).primaryColor,
                                    fontWeight: FontWeight.bold))
                          ])),
                    ),
                    SizedBox(
                      height: margin16,
                    )
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
