import 'package:flutter/material.dart';

import '../../x_res/my_config.dart';

class TabBarItem extends StatelessWidget {
  final String tag;
  final VoidCallback onTap;
  final bool isPressed;

  const TabBarItem(
      {Key? key,
      required this.tag,
      required this.onTap,
      required this.isPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
          child: Center(
            child: Text(
              tag,
              style: TextStyle(
                color: isPressed ? MyColor.PRIMARY_COLOR : Colors.grey,
                fontWeight: isPressed ? FontWeight.w600 : FontWeight.w500,
              ),
            ),
          ),
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(
                  color: isPressed ? MyColor.PRIMARY_COLOR : Colors.transparent,
                  width: 2),
            ),
          )),
    );
  }
}
