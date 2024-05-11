import 'package:flutter/material.dart';
import 'package:mager/app/settings/viewmodel/pin_vm.dart';
import 'package:mager/shared/font_style.dart';
import 'package:mager/shared/size_helper.dart';
import 'package:mager/shared/widgets/status_bar_widget.dart';
import 'package:stacked/stacked.dart';

class PinPage extends StatelessWidget {
  final String? currentPin;
  final bool isFromLogin;

  const PinPage({super.key, this.currentPin, this.isFromLogin = false});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<PINVM>.reactive(viewModelBuilder: () {
      return PINVM();
    }, onViewModelReady: (model) {
      model.onInitData(currentPin, isFromLogin);
    }, builder: (context, model, child) {
      return StatusbarWidget(
          customBrightness: Brightness.light,
          child: Scaffold(
            backgroundColor: Theme.of(context).primaryColor,
            body: Column(
              children: [
                Container(
                  padding: EdgeInsets.only(
                      top: MediaQuery.of(context).padding.top + margin16,
                      bottom: margin16,
                      right: margin16,
                      left: margin16),
                  child: Row(
                    children: [
                      GestureDetector(
                        onTap: () {
                          model.onTapBackbutton(context);
                        },
                        child: const Icon(
                          Icons.arrow_back,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(
                        width: margin16,
                      ),
                      Expanded(
                          child: Text(
                        'Enter PIN',
                        style: mainBody3.copyWith(
                            color: Colors.white, fontWeight: FontWeight.bold),
                      ))
                    ],
                  ),
                ),
                Expanded(
                    child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      model.getLabelDescription(),
                      style: mainBody2.copyWith(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: margin16,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(4, (index) {
                        return Container(
                          width: 24,
                          height: 24,
                          margin:
                              EdgeInsets.only(left: index == 0 ? 0 : margin16),
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: model.isOldConfirm
                                  ? model.currentInputPin.length > index
                                      ? Colors.green
                                      : Colors.white
                                  : model.isConfirm
                                      ? model.confirmationPIN.length > index
                                          ? Colors.green
                                          : Colors.white
                                      : model.enterredPin.length > index
                                          ? Colors.green
                                          : Colors.white),
                        );
                      }),
                    ),
                  ],
                )),
                Container(
                  width: double.infinity,
                  margin: EdgeInsets.only(bottom: margin16),
                  alignment: Alignment.center,
                  child: Wrap(
                    children: List.generate(12, (index) {
                      return FractionallySizedBox(
                        widthFactor: 0.33,
                        child: GestureDetector(
                          onTap: () {
                            model.onTapKey(context, index,
                                currentPin: currentPin);
                          },
                          child: Container(
                              width: double.infinity,
                              padding: EdgeInsets.symmetric(vertical: margin24),
                              color: Colors.transparent,
                              alignment: Alignment.center,
                              child: model.getLabelKey(index)),
                        ),
                      );
                    }),
                  ),
                )
              ],
            ),
          ));
    });
  }
}
