import 'package:flutter/material.dart';

class HomeSearchBar extends StatelessWidget {
  const HomeSearchBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: Colors.transparent),
      child: TextField(
        decoration: InputDecoration(
            constraints: BoxConstraints(
              maxHeight: 40,
            ),
            filled: true,
            enabled: false,
            border: OutlineInputBorder(
                borderRadius: BorderRadius.only(
                    topRight: Radius.circular(8), bottomRight: Radius.circular(8)),
                borderSide: BorderSide.none),
            fillColor: Colors.white,
            hintText: "Tìm kiếm",
            contentPadding: const EdgeInsets.symmetric(vertical: 0, horizontal: 0),
            hintStyle: TextStyle(color: Colors.grey, fontWeight: FontWeight.w500, fontSize: 15)),
      ),
    );
  }
}
