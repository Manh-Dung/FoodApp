import 'package:carousel_slider/carousel_controller.dart';
import 'package:flutter/material.dart';
import 'package:ints/base/base_controller.dart';

class DotsIndicator extends StatelessWidget {
  final int dotsCount;
  final double position;
  final ValueChanged<int> onChanged;

  DotsIndicator({
    required this.dotsCount,
    required this.position,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(dotsCount, (index) {
        return InkWell(
          onTap: () {
            onChanged(index);
          },
          child: Container(
              width: 8,
              height: 8,
              margin: EdgeInsets.symmetric(horizontal: 4.0),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white,
              ),
              child: Center(
                child: Container(
                  width: 6,
                  height: 6,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: position == index ? MyColor.PRIMARY_COLOR : Colors.white,
                  ),
                ),
              )),
        );
      }),
    );
  }
}
