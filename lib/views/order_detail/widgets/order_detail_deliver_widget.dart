import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../base/base_view_view_model.dart';

class OrderDetailDeliverWidget extends StatelessWidget {
  const OrderDetailDeliverWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 22, horizontal: 16),
      width: double.infinity,
      decoration: BoxDecoration(
        color: Color(0xffFDAA30),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Đang giao hàng",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                  fontSize: 16,
                ),
              ),
              Text(
                "Ngày nhận hàng dự kiến 27-03-2024",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 12,
                ),
              ),
            ],
          ),
          Container(
              padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 8),
              child: SvgPicture.asset(XR().svgImage.ic_deliver))
        ],
      ),
    );
  }
}
