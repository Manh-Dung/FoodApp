import 'package:flutter/material.dart';
import 'package:ints/views/notification/notification_binding.dart';
import 'package:ints/views/notification/widgets/notification_widget.dart';

import '../../base/base_view_view_model.dart';

class NotificationScreen extends BaseView<NotificationController> {
  NotificationScreen({super.key});
  @override
  Widget vBuilder() {
    return Scaffold(
        backgroundColor: Color.fromRGBO(225, 226, 227, 1),
        appBar: _appBar(),
        body: controller.isAvailableNoti
            ? Container(
                margin: EdgeInsets.only(top: 10),
                child: ListView.builder(
                    itemCount: 3,
                    itemBuilder: (context, index) {
                      return IntrinsicHeight(
                        child: NotificationWidget(),
                      );
                    }),
              )
            : Center(
                child: NonNotificationWidget(),
              ));
  }

  AppBar _appBar() {
    return AppBar(
      leading: IconButton(
        icon: Icon(Icons.arrow_back_rounded, color: Colors.black),
        onPressed: () => Get.back(),
      ),
      title: Text('Thông báo',
          style: TextStyle(
            fontSize: 21,
            fontWeight: FontWeight.w500,
            color: Colors.black,
          )),
      centerTitle: true,
      flexibleSpace: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 2,
              blurRadius: 2,
              offset: Offset(0, 1),
            ),
          ],
        ),
      ),
    );
  }
}
