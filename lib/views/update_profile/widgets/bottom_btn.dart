import 'package:flutter/material.dart';

import '../../../x_res/my_config.dart';

class BottomBtn extends StatelessWidget {
  final Function() onPressed;

  const BottomBtn({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Positioned(
        bottom: 0,
        right: 0,
        left: 0,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: ElevatedButton(
            onPressed: onPressed,
            child: Text(
              "Lưu",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w500,
              ),
            ),
            style: ElevatedButton.styleFrom(
              foregroundColor: MyColor.white,
              backgroundColor: MyColor.PRIMARY_COLOR,
              padding: const EdgeInsets.symmetric(vertical: 15),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
        ));
  }
}
