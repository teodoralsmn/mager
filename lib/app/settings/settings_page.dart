import 'package:flutter/material.dart';
import 'package:mager/app/login_screen/login_page.dart';
import 'package:mager/app/settings/viewmodel/setting_vm.dart';
import 'package:mager/shared/font_style.dart';
import 'package:mager/shared/function/yes_or_no_dialog.dart';
import 'package:mager/shared/providers/user_provider.dart';
import 'package:mager/shared/size_helper.dart';
import 'package:mager/shared/theme_style.dart';
import 'package:mager/shared/widgets/custom_button.dart';
import 'package:provider/provider.dart';
import 'package:stacked/stacked.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<SettingVM>.reactive(
        viewModelBuilder: () {
          return SettingVM();
        },
        onViewModelReady: (model) {},
        builder: (context, model, child) {
          return Column(
            children: [
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
                child: Text(
                  'Settings',
                  style: mainBody1.copyWith(
                      color: Colors.white, fontWeight: FontWeight.bold),
                ),
              ),
              Expanded(
                  child: ListView(
                padding: EdgeInsets.zero,
                children: [
                  SizedBox(
                    height: margin8,
                  ),
                  Container(
                    padding: EdgeInsets.only(
                        left: margin16,
                        right: margin16,
                        bottom: margin8,
                        top: margin16),
                    decoration: BoxDecoration(
                        border: Border(
                            bottom: BorderSide(
                                color: isDarkTheme(context)
                                    ? Colors.white24
                                    : Colors.black26))),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Dark Theme',
                          style: mainBodyFont(context)
                              .copyWith(fontWeight: FontWeight.bold),
                        ),
                        Row(
                          children: [
                            Text(
                              'Off',
                              style: mainBodyFont(context,
                                  type: FontBodyType.body5),
                            ),
                            Container(
                              margin: EdgeInsets.symmetric(horizontal: margin4),
                              child: Switch(
                                  onChanged: (value) {
                                    model.onChangeTheme(context);
                                  },
                                  value: isDarkTheme(context)),
                            ),
                            Text(
                              'On',
                              style: mainBodyFont(context,
                                  type: FontBodyType.body5),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                  GestureDetector(
                    onTap: () async {
                      model.onTapCategory(context);
                    },
                    child: Container(
                      padding: EdgeInsets.all(margin16),
                      decoration: BoxDecoration(
                          border: Border(
                              bottom: BorderSide(
                                  color: isDarkTheme(context)
                                      ? Colors.white24
                                      : Colors.black26))),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Category',
                            style: mainBodyFont(context)
                                .copyWith(fontWeight: FontWeight.bold),
                          ),
                          Icon(
                            Icons.arrow_forward_ios_rounded,
                            color: isDarkTheme(context)
                                ? Colors.white54
                                : Colors.black54,
                          )
                        ],
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () async {
                      model.onTapPin(context);
                    },
                    child: Container(
                      padding: EdgeInsets.all(margin16),
                      decoration: BoxDecoration(
                          border: Border(
                              bottom: BorderSide(
                                  color: isDarkTheme(context)
                                      ? Colors.white24
                                      : Colors.black26))),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'PIN',
                            style: mainBodyFont(context)
                                .copyWith(fontWeight: FontWeight.bold),
                          ),
                          Text(
                            Provider.of<UserProvider>(context, listen: false)
                                        .data!
                                        .pin ==
                                    null
                                ? 'PIN not Set'
                                : '****',
                            style: mainBodyFont(context,
                                    textOpacity: Provider.of<UserProvider>(
                                                    context,
                                                    listen: false)
                                                .data!
                                                .pin ==
                                            null
                                        ? 0.5
                                        : 1)
                                .copyWith(
                                    fontStyle: Provider.of<UserProvider>(context,
                                                    listen: false)
                                                .data!
                                                .pin ==
                                            null
                                        ? FontStyle.italic
                                        : FontStyle.normal,
                                    fontWeight: Provider.of<UserProvider>(context,
                                                    listen: false)
                                                .data!
                                                .pin ==
                                            null
                                        ? FontWeight.normal
                                        : FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(
                        horizontal: margin16, vertical: margin32),
                    child: CustomButton(
                      onTap: () {
                        yesOrNoDialog(context,
                                title: 'Logout',
                                desc: 'Are you sure to logout?')
                            .then((value) {
                          if (value) {
                            Provider.of<UserProvider>(context, listen: false)
                                .logout();
                            Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(
                                    builder: (_) => const LoginPage()),
                                (route) => false);
                          }
                        });
                      },
                      title: 'Logout',
                      customColor: Colors.red,
                    ),
                  ),
                ],
              ))
            ],
          );
        });
  }
}
