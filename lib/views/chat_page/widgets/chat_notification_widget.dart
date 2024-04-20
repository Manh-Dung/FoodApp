// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:ints/base/base_controller.dart';

class ChatNotificationWidget extends StatelessWidget {
  final String label;
  final String suggestText;
  final String day;

  ChatNotificationWidget(
      {Key? key,
      required this.label,
      required this.suggestText,
      required this.day})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 25.w),
        decoration: (BoxDecoration(
            color: MyColor.white,
            border: Border(
              bottom: BorderSide(width: 1.w, color: MyColor.border),
            ))),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              flex: 1,
              child: Align(
                  alignment: Alignment.topCenter,
                  child: Image.asset(XR().assetsImage.img_notification_avt)),
            ),
            SizedBox(
              width: 12.w,
            ),
            Expanded(
              flex: 8,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    label,
                    style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: Color.fromRGBO(23, 23, 23, 1)),
                  ),
                  Text(
                    suggestText,
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                      color: Color.fromRGBO(78, 79, 84, 1),
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
            SizedBox(
              width: 12.w,
            ),
            Expanded(
              flex: 2,
              child: Align(
                alignment: Alignment.topCenter,
                child: Text(
                  day,
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                    color: Color.fromRGBO(160, 160, 160, 1),
                  ),
                  overflow: TextOverflow.ellipsis,
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
