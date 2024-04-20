import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../base/base_controller.dart';

class FloatBtn extends StatelessWidget {
  final double? top;
  final double? bottom;
  final double? left;
  final double? right;
  final String svgPicture;
  final VoidCallback onTap;
  final int? cartLength;

  const FloatBtn(
      {super.key,
      this.top,
      this.bottom,
      this.left,
      this.right,
      required this.svgPicture,
      required this.onTap,
      this.cartLength});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: top,
      left: left,
      right: right,
      bottom: bottom,
      child: InkWell(
        onTap: onTap,
        child: Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.all(4),
            decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.2),
              shape: BoxShape.circle,
            ),
            child: Stack(
              children: [
                SvgPicture.asset(
                  svgPicture,
                  height: 24,
                  width: 24,
                  colorFilter: ColorFilter.mode(Colors.white, BlendMode.srcIn),
                ),
                if (cartLength != 0 && cartLength != null)
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
                        "${cartLength}",
                        style: TextStyle(
                          color: MyColor.white,
                          fontSize: 7,
                        ),
                      ),
                    ),
                  )
              ],
            )),
      ),
    );
  }
}
