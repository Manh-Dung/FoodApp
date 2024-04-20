import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ints/base/base_controller.dart';
import 'package:ints/views/checkout/checkout_binding.dart';

class ShippingMethod extends StatelessWidget {
  const ShippingMethod({super.key, required this.totalCoint});
  final num totalCoint;
  @override
  Widget build(BuildContext context) {
    final CheckoutController checkoutController = Get.find();
    return Column(
      children: [
        Container(
          width: double.infinity,
          padding:
              const EdgeInsets.only(top: 14, right: 16, left: 16, bottom: 36),
          decoration: BoxDecoration(
            color: Color(0xffE2F5FF),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Phương thức vận chuyển",
                style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                    color: Color(0xff0B9EEA)),
              ),
              const SizedBox(height: 4),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "COD",
                    style: TextStyle(fontSize: 12, fontWeight: FontWeight.w400),
                  ),
                  Row(
                    children: [
                      Text("Giá vận chuyển",
                          style: TextStyle(
                              fontSize: 12, fontWeight: FontWeight.w400)),
                      const SizedBox(width: 12),
                      Icon(Icons.arrow_forward_ios,
                          size: 12, color: Colors.black),
                    ],
                  )
                ],
              )
            ],
          ),
        ),
        const SizedBox(height: 4),
        Container(
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
          color: Colors.white,
          child: Column(
            children: [
              Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text("Tiêu",
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                      )),
                  const SizedBox(width: 4),
                  Flexible(
                    child: TextField(
                      textAlign: TextAlign.center,
                      controller: checkoutController.pointController,
                      keyboardType: TextInputType.number,
                      onChanged: (value) {
                        if (num.tryParse(value) != null) {
                          if (num.parse(value) >
                              (checkoutController
                                      .appController.rxUser.value?.point ??
                                  0)) {
                            checkoutController.pointController.text =
                                (checkoutController.appController.rxUser.value
                                            ?.point ??
                                        0)
                                    .toString();
                          }
                        }
                      },
                      decoration: InputDecoration(
                        constraints:
                            BoxConstraints(maxWidth: 80, maxHeight: 30),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: MyColor.BORDER_COLOR),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: MyColor.BORDER_COLOR),
                        ),
                        contentPadding:
                            const EdgeInsets.symmetric(horizontal: 4),
                      ),
                    ),
                  ),
                  const SizedBox(width: 4),
                  Text("Coin", style: TextStyle(fontSize: 12))
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(top: 8),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    SvgPicture.asset(XR().svgImage.ic_coin),
                    const SizedBox(width: 4),
                    Text("Coin hiện có: $totalCoint",
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                        )),
                  ],
                ),
              ),
            ],
          ),
        )
      ],
    );
  }
}
