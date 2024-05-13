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
         child: Image.asset(
          'assets/mager.jpg',
          fit: BoxFit.contain
              
            
          
        ),
      );
    });
  }
}
