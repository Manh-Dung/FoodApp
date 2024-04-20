import 'package:flutter/material.dart';

import '../../x_res/my_config.dart';

class AuthenticationButton extends StatelessWidget {
  final String message;
  final VoidCallback onPressed;

  const AuthenticationButton(
      {Key? key, required this.message, required this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        onPressed: onPressed,
        child: Text(message, style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
        style: ElevatedButton.styleFrom(
          backgroundColor: MyColor.PRIMARY_COLOR,
          foregroundColor: MyColor.TEXT_BUTTON_COLOR,
          minimumSize: Size(double.infinity,0),
          padding: EdgeInsets.symmetric(vertical: 15,horizontal: 100),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ));
  }
}
