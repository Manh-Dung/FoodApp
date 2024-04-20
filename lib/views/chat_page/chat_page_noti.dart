import 'package:flutter/material.dart';
import 'package:ints/views/chat_page/chat_page_binding.dart';
import 'package:ints/views/chat_page/widgets/chat_notification_widget.dart';

import '../../base/base_view_view_model.dart';

class ChatPageNotification extends BaseView<ChatPageController> {
  ChatPageNotification({super.key});

  @override
  Widget vBuilder() {
    return Scaffold(
        backgroundColor: Color.fromRGBO(225, 226, 227, 1),
        appBar: _appBar(),
        body: Container(
          child: ListView.builder(
              itemCount: 4,
              itemBuilder: (context, index) {
                return IntrinsicHeight(
                  child: ChatNotificationWidget(
                    label: 'Thursday\'s Feast Awaits!',
                    suggestText: 'Your Exotic Veggie Platter is on the menu. Get excited!',
                    day: '2 days ago',
                  ),
                );
              }),
        ));
  }

  AppBar _appBar() {
    return AppBar(
      leading: IconButton(
        icon: Icon(Icons.arrow_back_rounded, color: Colors.black),
        onPressed: () => Get.back(),
      ),
      title: Text('Chat',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w700,
            color: Color.fromRGBO(78, 79, 84, 1),
          )),
      centerTitle: true,
      flexibleSpace: Container(
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
}
