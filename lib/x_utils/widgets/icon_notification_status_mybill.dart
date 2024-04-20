import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class StatusMyBill extends StatelessWidget {
  String svgPath;
  String quality;
  String status;

  StatusMyBill(
      {super.key,
      required this.svgPath,
      required this.quality,
      required this.status});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 30,
          height: 30,
          child: SvgPicture.asset(
            svgPath,
            fit: BoxFit.fill,
            color: Colors.grey,
          ),
        ),
        SizedBox(height: 4),
        Text(
          quality,
          style: TextStyle(
              color: Colors.red, fontWeight: FontWeight.bold, fontSize: 10),
        ),
        SizedBox(height: 4),
        Text(
          status,
          style: TextStyle(fontSize: 10),
        ),
      ],
    );
  }
}
