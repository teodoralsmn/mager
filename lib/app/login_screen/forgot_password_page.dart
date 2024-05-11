import 'package:flutter/material.dart';
import 'package:mager/app/login_screen/forgot_password_vm.dart';
import 'package:mager/shared/font_style.dart';
import 'package:mager/shared/size_helper.dart';
import 'package:mager/shared/widgets/custom_button.dart';
import 'package:mager/shared/widgets/custom_textfield.dart';
import 'package:mager/shared/widgets/status_bar_widget.dart';
import 'package:mager/shared/widgets/validation_widget.dart';
import 'package:stacked/stacked.dart';

class ForgotPasswordPage extends StatelessWidget {
  const ForgotPasswordPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<ForgotPasswordVM>.reactive(
        viewModelBuilder: () {
          return ForgotPasswordVM();
        },
        onViewModelReady: (model) {},
        builder: (context, model, child) {
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
                        bottom:
                            MediaQuery.of(context).padding.bottom + margin16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'FORGOT PASSWORD',
                          style: mainBody1.copyWith(
                              fontWeight: FontWeight.bold,
                              color: Theme.of(context).primaryColor),
                        ),
                        Text(
                          'Enter email to reset your password',
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
                        CustomButton(
                          onTap: () {
                            model.onTapLogin(context);
                          },
                          title: 'LOGIN',
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
