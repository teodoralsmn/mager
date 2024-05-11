import 'package:flutter/material.dart';
import 'package:mager/shared/font_style.dart';
import 'package:mager/shared/size_helper.dart';

class CustomButton extends StatelessWidget {
  final Function? onTap;
  final String title;
  final Color? customColor;
  const CustomButton(
      {super.key, this.onTap, this.title = '', this.customColor});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        if (onTap != null) {
          onTap!();
        }
      },
      style: ButtonStyle(backgroundColor: MaterialStateProperty.resolveWith(
        (states) {
          return customColor ?? Theme.of(context).primaryColor;
        },
      )),
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(vertical: margin24 / 2),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              title,
              style: mainBody4.copyWith(
                  color: Colors.white, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
