import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class OrderSearchWidget extends StatelessWidget {
  final TextEditingController orderSearchController;
  ValueChanged<String> onChanged = (value) {};

  OrderSearchWidget(
      {super.key,
      required this.orderSearchController,
      required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 6,
      child: TextField(
        controller: orderSearchController,
        decoration: InputDecoration(
          hintText: "Tên shop, mã đơn hàng hoặc tên sản phẩm",
          contentPadding:
              const EdgeInsets.symmetric(vertical: 0, horizontal: 10),
          hintStyle: TextStyle(
              color: Colors.grey,
              overflow: TextOverflow.ellipsis,
              fontSize: 14,
              fontWeight: FontWeight.w500),
          hintMaxLines: 1,
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide.none,
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(
              color: Colors.blue,
            ),
          ),
        ),
        onChanged: onChanged,
      ),
    );
  }
}
