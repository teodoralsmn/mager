import 'package:flutter/material.dart';
import 'package:mager/app/splash_screen/splash_screen_vm.dart';
import 'package:mager/shared/font_style.dart';
import 'package:mager/shared/widgets/status_bar_widget.dart';
import 'package:stacked/stacked.dart';

class SplashScreenPage extends StatelessWidget {
  const SplashScreenPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<SplashScreenVM>.reactive(viewModelBuilder: () {
      return SplashScreenVM();
    }, onViewModelReady: (model) {
      model.onInit(context);
    }, builder: (context, model, child) {
      return StatusbarWidget(
        customBrightness: Brightness.light,
        child: Scaffold(
          body: Container(
            width: double.infinity,
            height: double.infinity,
            decoration: BoxDecoration(color: Theme.of(context).primaryColor),
            alignment: Alignment.center,
            child: Container(
              width: 200,
              height: 200,
              color: Colors.white,
              alignment: Alignment.center,
              child: Text(
                'Logo',
                style: mainBody3.copyWith(fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ),
      );
    });
  }
}
