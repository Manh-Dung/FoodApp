import 'package:flutter/material.dart';

import '../../../base/base_view_view_model.dart';

class WaitEmptyListWidget extends StatelessWidget {
  const WaitEmptyListWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const SizedBox(height: 36),
        Image.asset(
          XR().assetsImage.img_empty_cart,
          width: 132,
          height: 132,
        ),
        const SizedBox(height: 28),
        Text(
          'Không có gì trong giỏ hàng',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w400,
            color: MyColor.TEXT_COLOR_NEW,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          'Hãy quay lại trang chủ để lựa hàng bạn nhé!',
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w400,
            color: MyColor.TEXT_COLOR_NEW,
          ),
        ),
        const SizedBox(height: 24),
        InkWell(
          onTap: () {
            Get.back(result: 0);
          },
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(8)),
              border: Border.all(color: MyColor.PRIMARY_COLOR, width: 1),
            ),
            child:
                Text("Mua sắm ngay", style: TextStyle(color: MyColor.PRIMARY_COLOR, fontSize: 12)),
          ),
        ),
        const SizedBox(height: 24),
      ],
    );
  }
}
