import 'package:flutter/material.dart';

import '../../x_res/my_config.dart';

class RichTextButton extends StatelessWidget {
  final String unTapableMessage;
  final String tapableMessage;
  final VoidCallback onPressed;

  const RichTextButton(
      {super.key,
      required this.unTapableMessage,
      required this.tapableMessage,
      required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          unTapableMessage,
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w400,
            color: MyColor.black,
          ),
        ),
        InkWell(
          onTap: () {
            onPressed();
          },
          child: Text(
            tapableMessage,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w500,
              color: MyColor.PRIMARY_COLOR,
              decoration: TextDecoration.underline,
              decorationColor: MyColor.PRIMARY_COLOR,
            ),
          ),
        ),
      ],
      mainAxisAlignment: MainAxisAlignment.center,
    );
  }
}
