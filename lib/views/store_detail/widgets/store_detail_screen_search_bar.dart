import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:ints/x_res/x_r.dart';
import 'package:ints/x_routes/router_name.dart';

import '../../../x_res/my_config.dart';

class StoreDetailScreenSearchBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 15),
      child: Container(
        decoration: BoxDecoration(
          color: MyColor.white,
          borderRadius: BorderRadius.all(Radius.circular(8)),
        ),
        child: Row(
          children: [
            Expanded(
              flex: 1,
              child: InkWell(
                onTap: () {
                  Get.toNamed(RouterName.search_product);
                },
                child: Container(
                  padding: const EdgeInsets.all(8),
                  child: SvgPicture.asset(XR().svgImage.ic_search),
                  decoration: BoxDecoration(
                    color: MyColor.white,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(8),
                        bottomLeft: Radius.circular(8)),
                  ),
                ),
              ),
            ),
            Expanded(
                child: InkWell(
                    onTap: () {
                      Get.toNamed(RouterName.search_product);
                    },
                    child: Container(
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
                                    topRight: Radius.circular(8),
                                    bottomRight: Radius.circular(8)),
                                borderSide: BorderSide.none),
                            fillColor: Colors.white,
                            hintText: "Tìm kiếm",
                            contentPadding: const EdgeInsets.symmetric(
                                vertical: 0, horizontal: 0),
                            hintStyle: TextStyle(
                                color: Colors.grey,
                                fontWeight: FontWeight.w500,
                                fontSize: 15)),
                      ),
                    )),
                flex: 7),
          ],
        ),
      ),
    );
  }
}
