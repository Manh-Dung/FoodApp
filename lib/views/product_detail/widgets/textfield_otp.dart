import 'package:flutter/material.dart';

import '../../../x_res/my_config.dart';

class OtpTextField extends StatefulWidget {
  final TextEditingController controller;

  const OtpTextField({
    Key? key,
    required this.controller,
  }) : super(key: key);

  @override
  State<OtpTextField> createState() => _OtpTextFieldState();
}

class _OtpTextFieldState extends State<OtpTextField> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 70,
      height: 60,
      child: TextFormField(
        controller: widget.controller,
        decoration: InputDecoration(
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: MyColor.INPUT_TEXTFIELD_COLOR,
                width: 1,
              ),
              borderRadius: BorderRadius.circular(8),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: Colors.blueAccent,
                width: 1,
              ),
              borderRadius: BorderRadius.circular(8),
            ),
            errorBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: Colors.red,
                width: 1,
              ),
              borderRadius: BorderRadius.circular(8),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: Colors.red,
                width: 1,
              ),
              borderRadius: BorderRadius.circular(8),
            ),
            disabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: MyColor.INPUT_FORM_COLOR,
                width: 1,
              ),
              borderRadius: BorderRadius.circular(8),
            ),
            filled: true,
            fillColor: MyColor.INPUT_FORM_COLOR,
            contentPadding: EdgeInsets.symmetric(vertical: 16, horizontal: 30)),
      ),
    );
  }
}
