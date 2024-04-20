import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../base/base_view_view_model.dart';

class SearchOrderEmptyPage extends StatelessWidget {
  const SearchOrderEmptyPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: Get.height - 300,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(XR().svgImage.img_search_page, width: 100, height: 100),
            const SizedBox(height: 14),
            Text(
              "Bạn có thể tìm kiếm theo tên shop\nsản phẩm hoặc mã đơn hàng",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w400,
                color: MyColor.TEXT_COLOR_NEW,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
