import 'package:flutter/material.dart';
import 'package:ints/x_res/my_res.dart';
import 'package:timeline_tile/timeline_tile.dart';

class ProgressWidget extends StatelessWidget {
  final bool isFirst;
  final bool isLast;
  final bool isPast;
  final String locationLevel;
  final VoidCallback selectLocationLevel;
  final VoidCallback? resetSelection;

  ProgressWidget({
    super.key,
    required this.isFirst,
    required this.isLast,
    required this.isPast,
    required this.locationLevel,
    required this.selectLocationLevel,
    this.resetSelection,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: selectLocationLevel,
      child: SizedBox(
        height: 50,
        child: TimelineTile(
          isFirst: isFirst,
          isLast: isLast,
          beforeLineStyle: LineStyle(color: MyColor.CHECKBOX_COLOR, thickness: 2),
          indicatorStyle: IndicatorStyle(
              width: 8,
              color: MyColor.CHECKBOX_COLOR,
              iconStyle: IconStyle(
                iconData: Icons.circle,
                color: isPast ? MyColor.PRIMARY_COLOR : MyColor.CHECKBOX_COLOR,
                fontSize: 4,
              )),
          endChild: Padding(
            padding: const EdgeInsets.only(
              left: 3,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding: const EdgeInsets.only(left: 3, top: 8, bottom: 8),
                  decoration: BoxDecoration(
                      border: Border.all(
                          width: isPast ? 1 : 0,
                          color:
                              isPast ? MyColor.CHECKBOX_COLOR : Colors.white)),
                  child: Text(
                    locationLevel,
                    style: TextStyle(
                      fontSize: 12,
                      color: isPast
                          ? MyColor.PRIMARY_COLOR
                          : MyColor.TEXT_COLOR_NEW,
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: resetSelection,
                  child: Text(
                    isFirst ? 'Thiết lập lại' : '',
                    style: TextStyle(
                        fontSize: 10, color: Color.fromRGBO(216, 32, 29, 1)),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
