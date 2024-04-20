import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get_storage/get_storage.dart';
import 'package:numberpicker/numberpicker.dart';

import '../../../x_res/my_config.dart';

class OrderBottomDialog extends StatelessWidget {
  final Function(String) onApply;
  var day = 1;
  var month = 1;
  var year = 2024;

  OrderBottomDialog({super.key, required this.onApply});

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.all(10),
        width: double.infinity,
        child: Stack(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Chọn ngày",
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                const SizedBox(height: 20),
                Container(
                  height: 100,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      buildCupertinoPicker(
                        minValue: 1,
                        maxValue: 31,
                        value: 1,
                        onChanged: (value) {
                          day = value + 1;
                        },
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(8), bottomLeft: Radius.circular(8)),
                      ),
                      buildCupertinoPicker(
                        minValue: 1,
                        maxValue: 12,
                        value: 1,
                        onChanged: (value) {
                          month = value + 1;
                        },
                        textMapper: (value) => "tháng " + value.toString(),
                        borderRadius: BorderRadius.zero,
                      ),
                      buildCupertinoPicker(
                          minValue: 2000,
                          maxValue: 2025,
                          value: 2024,
                          onChanged: (value) {
                            year = value + 2000;
                          },
                          borderRadius: BorderRadius.only(
                              topRight: Radius.circular(8), bottomRight: Radius.circular(8))),
                    ],
                  ),
                )
              ],
            ),
            Align(
                alignment: Alignment.bottomCenter,
                child: InkWell(
                  onTap: () {
                    onApply("$year" + "-" + convertDate(month) + "-" + convertDate(day));
                  },
                  child: Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: MyColor.PRIMARY_COLOR,
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 2,
                          blurRadius: 5,
                          offset: Offset(0, 1),
                        ),
                      ],
                    ),
                    child: Icon(Icons.check, color: Colors.white, size: 25),
                  ),
                )),
          ],
        ));
  }

  Widget buildCupertinoPicker({
    required int minValue,
    required int maxValue,
    required int value,
    required ValueChanged<int> onChanged,
    Function(int)? textMapper,
    required BorderRadius borderRadius,
  }) {
    return Expanded(
      child: CupertinoPicker(
        itemExtent: 40,
        onSelectedItemChanged: (value) {
          onChanged(value);
        },
        selectionOverlay: Container(
          decoration:
              BoxDecoration(color: Colors.grey.withOpacity(0.2), borderRadius: borderRadius),
        ),
        looping: true,
        children: List.generate(
          maxValue - minValue + 1,
          (index) {
            final currentValue = index + minValue;

            // Thêm số 0 vào ngày hoặc tháng nhỏ hơn 10
            final formattedValue = currentValue < 10 ? '0$currentValue' : '$currentValue';

            final displayValue = textMapper != null ? textMapper(currentValue) : formattedValue;
            return Center(
              child: Text(
                "$displayValue",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  String convertDate(int value) {
    if (value < 10) {
      return "0$value";
    }
    return value.toString();
  }
}
