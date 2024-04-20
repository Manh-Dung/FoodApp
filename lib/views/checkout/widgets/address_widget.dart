import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ints/base/base_controller.dart';

import '../../../x_res/my_config.dart';

class AddressWidget extends StatelessWidget {
  final String name;
  final String phone;
  final String address;
  final String detailAddress;

  const AddressWidget(
      {super.key,
      required this.name,
      required this.phone,
      required this.address,
      required this.detailAddress});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: MyColor.white,
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            children: [
              Container(
                child: SvgPicture.asset(XR().svgImage.ic_location, width: 24, height: 24),
              ),
              const SizedBox(width: 6),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Địa chỉ nhận hàng",
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                        color: Colors.black,
                      )),
                  const SizedBox(height: 4),
                  Row(children: [
                    Text(name, style: TextStyle(fontSize: 12, fontWeight: FontWeight.w400)),
                    Text(" | ", style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
                    Text(phone, style: TextStyle(fontSize: 12, fontWeight: FontWeight.w400)),
                  ]),
                  Text(detailAddress, style: TextStyle(fontSize: 12, fontWeight: FontWeight.w400)),
                  Text(address, style: TextStyle(fontSize: 12, fontWeight: FontWeight.w400)),
                ],
              ),
            ],
          ),
          Get.currentRoute != RouterName.pickup_address
              ? Container()
              : InkWell(
                  onTap: () {
                    Get.toNamed(RouterName.pickup_address);
                  },
                  child: Icon(Icons.arrow_forward_ios, size: 12, color: Colors.black))
        ],
      ),
    );
  }
}
