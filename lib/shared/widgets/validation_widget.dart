import 'package:flutter/material.dart';
import 'package:mager/shared/font_style.dart';
import 'package:mager/shared/size_helper.dart';

class ValidationWidget extends StatelessWidget {
  final String? validation;
  final Widget child;
  const ValidationWidget({super.key, this.validation, required this.child});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        child,
        validation == null
            ? Container()
            : Container(
                margin: EdgeInsets.only(top: margin4),
                child: Text(
                  validation!,
                  style: mainBody5.copyWith(color: Colors.red),
                ),
              )
      ],
    );
  }
}
