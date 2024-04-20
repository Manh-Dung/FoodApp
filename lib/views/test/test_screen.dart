import 'package:flutter/material.dart';
import 'package:ints/base/base_view_view_model.dart';
import 'package:ints/view_models/member/member_widget.dart';
import 'package:ints/x_res/my_res.dart';

import 'test_binding.dart';



// ignore: must_be_immutable
class TestScreen extends BaseView<TestController> {
  @override
  Widget vBuilder() => Scaffold(
      appBar: AppBar(title: Text("{XR().string.test_screen}")),
      // body: AnimatedSwitcher(
      //   duration: Duration(milliseconds: 500),
      //   child: _body(),
      // ),
      body: _body(),
      floatingActionButton: FloatingActionButton(
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
        onPressed: controller.increment,
      ));

  _body() {
    if (controller.screenStateIsLoading)
      return Center(child: CircularProgressIndicator());

    if (controller.screenStateIsError) return Text('XR().string.error_message');

    if (controller.screenStateIsOK)
      return Center(
        key: UniqueKey(),
        child: ListView(
          children: [
            Text("${controller.count}"),
            controller.member.id == null
                ? Text("${controller.count}")
                : Text("${controller.member.name}"),
            TextButton(
              child: Text(
                "Member",
                style: AppThemes().general().textTheme.bodyText1,
              ),
              onPressed: () {
                controller.entryMember();
              },
            ),
            TextButton(
              child: Text("Show Snackbar"),
              onPressed: () {
                controller.showSuccessSnackBar(
                    title: "Haloo",
                    message: "Pesan dari snackbar test_controller");
              },
            ),
            TextButton(
              child: Text("Show Simple Snackbar"),
              onPressed: () {
                controller.showSimpleSuccessSnackBar(
                    message: "Halo snackbar...");
              },
            ),
            TextButton(
              child: Text("CALL API MEMBER"),
              onPressed: controller.onGetMember,
            ),
            TextButton(
              child: Text("Show Alert"),
              onPressed: controller.showAlertDialog,
            ),
            MemberWidget(),
            Divider(color: Colors.grey),
            TextButton(
              child: Text("{XR().string.change_theme}"),
              onPressed: controller.changeTheme,
            )
          ],
        ),
      );
  }
}
