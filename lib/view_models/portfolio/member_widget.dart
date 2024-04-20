import 'package:flutter/material.dart';
import 'package:ints/base/base_view_view_model.dart';
import 'package:ints/view_models/member/member_controller.dart';

// ignore: must_be_immutable
class MemberWidget extends BaseViewModel<MemberController> {
  @override
  Widget vmBuilder() => Column(
        children: [
          _bodyMember(),
          TextButton(
            child: Text("Change State Member"),
            onPressed: () {
              controller.changeState();
            },
          ),
          Divider(color: Colors.grey),
          Text("${controller.count}"),
          TextButton(
            child: Text("{XR().string.increment}"),
            onPressed: controller.increment,
          ),
          TextButton(
            child: Text("{XR().string.change_lang}"),
            onPressed: controller.changeLanguage,
          ),
        ],
      );

  Widget _bodyMember() {
    if (controller.wiStateIsLoading) return CircularProgressIndicator();

    if (controller.wiStateIsError) return Text("Error...");

    if (controller.wiStateIsOK) return Text("Okee...");

    return Container();
  }
}
