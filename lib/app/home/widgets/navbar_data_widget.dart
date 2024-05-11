import 'package:flutter/material.dart';
import 'package:mager/shared/font_style.dart';

class NavbarDataWidget extends StatelessWidget {
  final IconData icons;
  final String title;
  final bool isActive;
  final Function() onChangedIndex;
  const NavbarDataWidget(
      {super.key,
      required this.onChangedIndex,
      required this.icons,
      required this.title,
      this.isActive = false});

  @override
  Widget build(BuildContext context) {
    return Flexible(
      flex: 1,
      child: GestureDetector(
        onTap: () {
          onChangedIndex();
        },
        child: SizedBox(
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                icons,
                color: isActive ? Colors.white : Colors.white54,
                size: 28,
              ),
              Center(
                child: Text(
                  title,
                  style: mainBody5.copyWith(
                      color: isActive ? Colors.white : Colors.white54),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
