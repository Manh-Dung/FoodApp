import 'package:flutter/material.dart';

import '../../../x_res/my_config.dart';
import '../../../x_utils/utilities.dart';

class CartBottomBar extends StatelessWidget {
  final Function onCheckBoxChanged;
  final bool checkBoxValue;
  final num totalPrice;
  final VoidCallback onPressed;
  const CartBottomBar({
    super.key,
    required this.onCheckBoxChanged,
    required this.checkBoxValue,
    required this.totalPrice,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey,
            spreadRadius: 1,
            blurRadius: 3,
            offset: Offset(0, -1),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Checkbox(
                  value: checkBoxValue,
                  materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  visualDensity: VisualDensity(horizontal: -4, vertical: -4),
                  activeColor: MyColor.white,
                  checkColor: MyColor.PRIMARY_COLOR,
                  side: MaterialStateBorderSide.resolveWith(
                    (Set<MaterialState> states) {
                      if (states.contains(MaterialState.selected)) {
                        return BorderSide(
                            color: MyColor.CHECKBOX_COLOR, width: 1.0);
                      }
                      return BorderSide(color: Colors.grey, width: 1.0);
                    },
                  ),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(4)),
                  focusColor: Colors.grey,
                  hoverColor: Colors.grey,
                  onChanged: (value) {
                    onCheckBoxChanged(value);
                  }),
              const SizedBox(width: 4),
              Text("Tất cả",
                  style: TextStyle(fontSize: 12, fontWeight: FontWeight.w400)),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    "Tổng thanh toán",
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                      color: MyColor.PRIMARY_COLOR,
                    ),
                  ),
                  Text(
                    Utilities().moneyFormater(totalPrice.toString()),
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: MyColor.PRIMARY_COLOR,
                    ),
                  )
                ],
              ),
              const SizedBox(width: 10),
              ElevatedButton(
                onPressed: () {
                  onPressed();
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: MyColor.PRIMARY_COLOR,
                  padding:
                      const EdgeInsets.symmetric(vertical: 14, horizontal: 40),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  minimumSize: Size(0, 0),
                ),
                child: Text(
                  "Mua ngay",
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.white),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
