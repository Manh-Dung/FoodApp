import 'package:flutter/material.dart';
import 'package:ints/base/base_controller.dart';

class NavButton extends StatelessWidget {
  final String name;
  final VoidCallback onPressed;
  final bool isPressed;

  const NavButton(
      {super.key, required this.name, required this.onPressed, required this.isPressed});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 1,
      child: InkWell(
          onTap: () {
            onPressed();
          },
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 8),
            decoration: BoxDecoration(
              color: isPressed ? MyColor.PRIMARY_COLOR : Colors.transparent,
              borderRadius: BorderRadius.circular(30),
            ),
            child: Text(
              name,
              style: TextStyle(
                color: isPressed ? Colors.white : MyColor.TEXT_LABEL_COLOR,
                fontSize: 15,
                fontWeight: FontWeight.w500,
              ),
              textAlign: TextAlign.center,
            ),
          )),
    );
  }
}
