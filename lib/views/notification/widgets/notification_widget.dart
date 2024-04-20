// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:ints/base/base_controller.dart';

class NotificationWidget extends StatelessWidget {
  NotificationWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
        decoration: (BoxDecoration(
            color: MyColor.SHIMMER_BASE_COLOR,
            border: Border(
              bottom: BorderSide(width: 0.5, color: MyColor.border),
            ))),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Align(
              alignment: Alignment.topLeft,
              child: Row(
                children: [
                  Container(
                    child: Image.asset(XR().assetsImage.img_notification_avt),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Thursday's Feast Awaits!",
                        style: TextStyle(
                          fontSize: 14,
                        ),
                      ),
                      Text(
                        "Your phenomenous winning day!",
                        style: TextStyle(
                          fontSize: 12,
                          color: MyColor.ICON_UNSELECTED_COLOR,
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
            Align(
              alignment: Alignment.topRight,
              child: Text(
                '2 days ago',
                style: TextStyle(
                  fontSize: 12,
                  color: MyColor.ICON_UNSELECTED_COLOR,
                ),
              ),
            )
          ],
        ));
  }
}

class NonNotificationWidget extends StatelessWidget {
  NonNotificationWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SvgPicture.asset(XR().svgImage.ic_chat),
        SizedBox(height: 10),
        Text(
          'Không có thông báo',
          style: TextStyle(
            fontSize: 20,
            color: MyColor.black,
            fontWeight: FontWeight.w700,
          ),
        ),
        SizedBox(height: 5),
        Padding(
          padding: const EdgeInsets.only(left: 25, right: 25),
          child: Text(
            'Chúng tôi sẽ cho bạn biết khi nào có nội dung gì đó cần cập nhật cho bạn.',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 16,
              color: Color.fromRGBO(148, 148, 153, 1),
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
      ],
    );
  }
}
