import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../x_res/my_config.dart';

class Section extends StatelessWidget {
  final String path;
  final String title;

  const Section({super.key, required this.path, required this.title});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8.0),
              color: MyColor.white,
              border: Border.all(color: MyColor.BORDER_COLOR, width: 1),
            ),
            child: SvgPicture.asset(
              path,
            )),
        const SizedBox(height: 10),
        Text(
          title,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w400,
          ),
        ),
      ],
    );
  }
}
