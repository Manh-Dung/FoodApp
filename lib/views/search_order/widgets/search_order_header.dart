import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../base/base_view_view_model.dart';

class SearchOrderHeader extends StatelessWidget {
  final ValueChanged<String> onChanged;

  SearchOrderHeader({super.key, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: MyColor.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 1,
            blurRadius: 1,
            offset: Offset(0, 1), // changes position of shadow
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            flex: 1,
            child: Container(
              padding: const EdgeInsets.all(8),
              child: SvgPicture.asset(XR().svgImage.ic_search),
              decoration: BoxDecoration(
                color: MyColor.INPUT_FORM_COLOR,
                borderRadius:
                    BorderRadius.only(topLeft: Radius.circular(8), bottomLeft: Radius.circular(8)),
              ),
            ),
          ),
          Expanded(flex: 9, child: _searchBar()),
        ],
      ),
    );
  }

  Widget _searchBar() {
    return Container(
      decoration: BoxDecoration(color: Colors.transparent),
      child: TextField(
        onChanged: (value) {
          onChanged(value);
        },
        decoration: InputDecoration(
            constraints: BoxConstraints(
              maxHeight: 40,
            ),
            filled: true,
            border: OutlineInputBorder(
                borderRadius: BorderRadius.only(
                    topRight: Radius.circular(8), bottomRight: Radius.circular(8)),
                borderSide: BorderSide.none),
            fillColor: MyColor.INPUT_FORM_COLOR,
            hintText: "Tìm kiếm theo tên shop, sản phẩm, mã đơn hàng",
            contentPadding: const EdgeInsets.symmetric(vertical: 0, horizontal: 0),
            hintStyle: TextStyle(color: Colors.grey, fontWeight: FontWeight.w400, fontSize: 12)),
      ),
    );
  }
}
