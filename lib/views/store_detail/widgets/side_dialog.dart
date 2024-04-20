import 'package:flutter/material.dart';

import '../../../x_res/my_config.dart';

class SideDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Align(
      child: Material(
        child: Container(
            width: 170,
            height: 60,
            color: MyColor.white,
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Icon(
                  Icons.favorite_border,
                  color: MyColor.PRIMARY_COLOR,
                  size: 14,
                ),
                const SizedBox(width: 5),
                Text(
                  "Yêu thích",
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 12,
                  ),
                ),
              ],
            )),
      ),
      alignment: FractionalOffset(1, 0.09),
    );
  }
}
