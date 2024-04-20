import 'package:flutter/material.dart';

import '../../../base/base_view_view_model.dart';

class SettingItemWidget extends StatelessWidget {
  final String text;
  final VoidCallback onTap;

  const SettingItemWidget({super.key, required this.text, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        color: MyColor.white,
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "$text",
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w400,
                color: MyColor.black,
              ),
            ),
            Icon(
              Icons.keyboard_arrow_right_rounded,
              color: MyColor.TEXT_COLOR_NEW,
              size: 24,
            )
          ],
        ),
      ),
    );
  }
}
