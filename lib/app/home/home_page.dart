import 'package:flutter/material.dart';
import 'package:mager/app/home/home_vm.dart';
import 'package:mager/app/home/widgets/navbar_data_widget.dart';
import 'package:mager/shared/size_helper.dart';
import 'package:mager/shared/theme_style.dart';
import 'package:mager/shared/widgets/status_bar_widget.dart';
import 'package:stacked/stacked.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<HomeVM>.reactive(viewModelBuilder: () {
      return HomeVM();
    }, builder: (context, model, child) {
      return StatusbarWidget(
        customBrightness: model.selectedIndex == 0
            ? isDarkTheme(context)
                ? Brightness.light
                : Brightness.dark
            : Brightness.light,
        child: Scaffold(
          body: Stack(
            children: [
              SizedBox(
                width: double.infinity,
                height: double.infinity,
                child: model.getScreen(),
              ),
              Positioned(
                bottom: MediaQuery.of(context).padding.bottom + margin16,
                left: margin16,
                right: margin16,
                child: Container(
                  width: double.infinity,
                  height: 70,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Theme.of(context).primaryColor),
                  child: Row(
                    children: [
                      NavbarDataWidget(
                        icons: Icons.home,
                        title: 'Home',
                        onChangedIndex: () {
                          model.onChangeIndex(0);
                        },
                        isActive: model.selectedIndex == 0,
                      ),
                      NavbarDataWidget(
                        icons: Icons.account_circle_rounded,
                        title: 'Profile',
                        onChangedIndex: () {
                          model.onChangeIndex(1);
                        },
                        isActive: model.selectedIndex == 1,
                      ),
                      NavbarDataWidget(
                        icons: Icons.settings,
                        title: 'Settings',
                        onChangedIndex: () {
                          model.onChangeIndex(2);
                        },
                        isActive: model.selectedIndex == 2,
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      );
    });
  }
}
