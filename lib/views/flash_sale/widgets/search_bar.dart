import 'package:flutter/material.dart';

class SearchBarWidget extends StatelessWidget {
  ValueChanged<String> myValueChanged = (value) {};

  SearchBarWidget({Key? key, required this.myValueChanged}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: Colors.transparent),
      child: TextField(
        decoration: InputDecoration(
            constraints: BoxConstraints(
              maxHeight: 80,
            ),
            contentPadding: const EdgeInsets.symmetric(
              vertical: 10,
            ),
            filled: true,
            prefixIcon: Icon(Icons.search_outlined, color: Colors.grey),
            border: OutlineInputBorder(
                borderSide: const BorderSide(width: 1, color: Colors.black),
                borderRadius: BorderRadius.circular(30)),
            fillColor: Colors.white,
            hintText: "Từ khóa sản phẩm...",
            hintStyle: TextStyle(
                color: Colors.grey, fontWeight: FontWeight.w500, fontSize: 15)),
        onChanged: myValueChanged,
      ),
    );
  }
}
