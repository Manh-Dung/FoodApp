import 'package:flutter/material.dart';

import '../../../base/base_view_view_model.dart';

class OrderDetailChatBtn extends StatelessWidget {
  final Function onTapChat;
  const OrderDetailChatBtn({super.key, required this.onTapChat});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      width: double.infinity,
      color: Colors.white,
      child: InkWell(
        onTap: () {
          onTapChat();
        },
        child: Container(
          decoration: BoxDecoration(
            border: Border.all(color: MyColor.PRIMARY_COLOR),
            borderRadius: BorderRadius.circular(8),
          ),
          padding: const EdgeInsets.symmetric(vertical: 14),
          child: Center(
            child:
                Text("Liên hệ Shop", style: TextStyle(color: MyColor.PRIMARY_COLOR, fontSize: 12)),
          ),
        ),
      ),
    );
  }
}
