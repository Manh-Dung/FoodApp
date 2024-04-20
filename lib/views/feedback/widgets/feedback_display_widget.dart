import 'package:flutter/material.dart';
import 'package:ints/views/app/app_controller.dart';

import '../../../base/base_view_view_model.dart';

class FeedbackDisplayWidget extends StatelessWidget {
  const FeedbackDisplayWidget({super.key});

  @override
  Widget build(BuildContext context) {
    AppController appController = Get.find();
    return Container(
        padding: const EdgeInsets.all(16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Hiển thị tên đăng nhập trên đánh giá này",
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                      color: Colors.black,
                    )),
                const SizedBox(height: 8),
                Text(
                    "Tên tài khoản của bạn là " +
                        (appController.rxUser.value?.fullName ?? "Họ và tên"),
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                      color: MyColor.BORDER_COLOR,
                    )),
              ],
            ),
            Switch(
              value: true,
              onChanged: (value) {
                value = !value;
              },
            )
          ],
        ));
  }
}
