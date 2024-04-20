import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../base/base_controller.dart';

class NotificationWidget extends StatelessWidget {
  const NotificationWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      child: Stack(
        children: [
          SvgPicture.asset(XR().svgImage.ic_notification),
          Positioned(
            right: 0,
            top: -3,
            child: Container(
              padding: const EdgeInsets.all(3),
              decoration: BoxDecoration(
                color: Colors.red,
                shape: BoxShape.circle,
                border: Border.all(color: MyColor.white, width: 1),
              ),
              child: Text(
                "2",
                style: TextStyle(
                  color: MyColor.white,
                  fontSize: 7,
                ),
              ),
            ),
          )
        ],
      ),
    );  }
}
