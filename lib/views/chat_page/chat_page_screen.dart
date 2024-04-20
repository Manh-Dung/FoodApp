import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:ints/base/base_view_view_model.dart';
import 'package:ints/views/chat_page/widgets/received_message_widget.dart';
import 'package:ints/views/chat_page/widgets/send_message_widget.dart';

import 'chat_page_binding.dart';

class ChatPage extends BaseView<ChatPageController> {
  String text =
      'aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa';

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar: _appBar(),
        body: Container(
          color: MyColor.white,
          child: Column(
            children: [
              Expanded(
                child: Container(
                  width: double.infinity,
                  color: Colors.grey[300],
                  child: SingleChildScrollView(
                      child: Column(
                    children: [
                      Container(
                        padding: EdgeInsets.only(top: 16.r),
                        child: Text(
                          "24/12/2001",
                          style: TextStyle(
                              fontSize: 12,
                              color: Color.fromRGBO(148, 148, 153, 1),
                              decoration: TextDecoration.none),
                        ),
                      ),
                      SentMessageWidget(
                        key: GlobalKey(),
                        message: text,
                        time: '12:30',
                      ),
                      ReceivedMessageWidget(
                        key: GlobalKey(),
                        message: text,
                        time: '12:30',
                      ),
                      ReceivedMessageWidget(
                        key: GlobalKey(),
                        message: text,
                        time: '12:30',
                      ),
                      SentMessageWidget(
                        key: GlobalKey(),
                        message: text,
                        time: '12:30',
                      ),
                      SentMessageWidget(
                        key: GlobalKey(),
                        message: text,
                        time: '12:30',
                      ),
                      ReceivedMessageWidget(
                        key: GlobalKey(),
                        message: text,
                        time: '12:30',
                      ),
                      ReceivedMessageWidget(
                        key: GlobalKey(),
                        message: text,
                        time: '12:30',
                      ),
                      SizedBox(
                        height: 50.h,
                      )
                    ],
                  )),
                ),
              ),
              Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Color.fromRGBO(0, 0, 0, 0.25),
                        spreadRadius: 1,
                        blurRadius: 1,
                        offset: Offset(0, -1),
                      ),
                    ],
                  ),
                  height: 130.h,
                  width: double.infinity,
                  child: Column(
                    children: [
                      SizedBox(
                        height: 16.h,
                      ),
                      Container(
                        padding: EdgeInsets.only(left: 16.r),
                        height: 30.h,
                        child: ListView.separated(
                          scrollDirection: Axis.horizontal,
                          itemCount: controller.chatList.length,
                          separatorBuilder: (BuildContext context, int index) {
                            return SizedBox(width: 8);
                          },
                          itemBuilder: (context, index) {
                            return _buildText(controller.chatList[index]);
                          },
                        ),
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                      Row(
                        children: [
                          Expanded(
                            flex: 1,
                            child: InkWell(
                              onTap: () {},
                              child: SvgPicture.asset(
                                XR().svgImage.ic_emotion,
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 6,
                            child: Container(
                              child: TextField(
                                decoration: InputDecoration(
                                    constraints:
                                        BoxConstraints(maxHeight: 40.h),
                                    contentPadding: const EdgeInsets.symmetric(
                                        vertical: 10, horizontal: 16),
                                    filled: true,
                                    focusedBorder: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(8.r),
                                        borderSide: BorderSide(
                                            color: Color.fromRGBO(
                                                225, 226, 227, 1),
                                            width: 1.r)),
                                    enabledBorder: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(8.r),
                                        borderSide: BorderSide(
                                            color: Color.fromRGBO(
                                                225, 226, 227, 1),
                                            width: 1.h)),
                                    fillColor: Colors.transparent,
                                    hintText: "Tin nhắn",
                                    hintStyle: TextStyle(
                                        color: Color.fromRGBO(50, 57, 65, 1),
                                        fontWeight: FontWeight.w400,
                                        fontSize: 16)),
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: InkWell(
                              onTap: () {},
                              child: SvgPicture.asset(
                                XR().svgImage.ic_plus_chat,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ))
            ],
          ),
        ),
      ),
    );
  }

   _appBar() {
    return PreferredSize(
      preferredSize: Size.fromHeight(80.h),
      child: Container(
        padding: EdgeInsets.only(bottom: 15.h),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                IconButton(
                    onPressed: () {
                      Get.back();
                    },
                    iconSize: 24.r,
                    icon: Icon(
                      Icons.arrow_back_rounded,
                      color: Colors.black,
                    )),
                CircleAvatar(
                  child: Image.asset(
                    XR().assetsImage.img_avatar_shop,
                    fit: BoxFit.cover,
                  ),
                  radius: 20.r,
                ),
                SizedBox(
                  width: 14.w,
                ),
                Text(
                  "Công ty cổ phần ABC",
                  style: TextStyle(
                    fontSize: 16,
                    color: Color.fromRGBO(78, 79, 84, 1),
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ],
        ),
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Color.fromRGBO(0, 0, 0, 0.25),
              spreadRadius: 6,
              blurRadius: 6,
              offset: Offset(0, -5),
            ),
          ],
        ),
      ),
    );
  }

  _buildBottom() {
    return Container(
        height: 130.h,
        width: double.infinity,
        child: Column(
          children: [
            SizedBox(
              height: 16.h,
            ),
            Container(
              padding: EdgeInsets.only(left: 16.r),
              height: 26.h,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemCount: controller.chatList.length,
                separatorBuilder: (BuildContext context, int index) {
                  return SizedBox(width: 8);
                },
                itemBuilder: (context, index) {
                  return _buildText(controller.chatList[index]);
                },
              ),
            ),
            SizedBox(
              height: 8.h,
            ),
            Row(
              children: [
                Expanded(
                  flex: 1,
                  child: InkWell(
                    onTap: () {},
                    child: SvgPicture.asset(
                      XR().svgImage.ic_emotion,
                    ),
                  ),
                ),
                Expanded(
                  flex: 6,
                  child: Container(
                    child: TextField(
                      decoration: InputDecoration(
                          constraints: BoxConstraints(maxHeight: 40.h),
                          contentPadding: const EdgeInsets.symmetric(
                              vertical: 10, horizontal: 16),
                          filled: true,
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8.r),
                              borderSide: BorderSide(
                                  color: Color.fromRGBO(225, 226, 227, 1),
                                  width: 1.r)),
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8.r),
                              borderSide: BorderSide(
                                  color: Color.fromRGBO(225, 226, 227, 1),
                                  width: 1.h)),
                          fillColor: Colors.transparent,
                          hintText: "Tin nhắn",
                          hintStyle: TextStyle(
                              color: Color.fromRGBO(50, 57, 65, 1),
                              fontWeight: FontWeight.w500,
                              fontSize: 16)),
                    ),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: InkWell(
                    onTap: () {},
                    child: SvgPicture.asset(
                      XR().svgImage.ic_plus_chat,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ));
  }

  _buildText(String text) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.r, vertical: 5.r),
      decoration: BoxDecoration(
          border:
              Border.all(color: Color.fromRGBO(148, 148, 153, 1), width: 1.r),
          borderRadius: BorderRadius.circular(16.r)),
      child: Text(
        text,
        style: TextStyle(
            fontSize: 12,
            color: Color.fromRGBO(148, 148, 153, 1),
            fontWeight: FontWeight.w400,
          ),
      ),
    );
  }

  @override
  Widget vBuilder() {
    // TODO: implement vBuilder
    throw UnimplementedError();
  }
}
