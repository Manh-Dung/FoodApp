import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../x_res/my_config.dart';

class DialogErrorWidget extends StatelessWidget {
  final String message;
  final VoidCallback? onPressed;

  const DialogErrorWidget({Key? key, required this.message, this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              "Notification",
            ),
            SizedBox(height: 16),
            Text(message),
            SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}
