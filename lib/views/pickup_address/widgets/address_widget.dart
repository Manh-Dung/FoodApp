// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:ints/base/base_controller.dart';
import 'package:ints/models/address/address.dart';

class AddressWidget extends StatelessWidget {
  final Address address;
  final bool isBeingEdited;
  final Function removeAddress;
  final Function editAddress;

  AddressWidget(
      {super.key,
      required this.removeAddress,
      required this.isBeingEdited,
      required this.editAddress,
      required this.address});

  @override
  Widget build(BuildContext context) {
    return Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        color: MyColor.white,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SvgPicture.asset(
                  address.type == 0
                      ? XR().svgImage.ic_privatehome
                      : XR().svgImage.ic_company,
                  width: 16,
                  height: 16,
                ),
                const SizedBox(width: 16),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(address.type == 0 ? "Nhà riêng" : "Văn phòng",
                        style: TextStyle(
                            fontSize: 14, color: MyColor.TEXT_COLOR_NEW)),
                    const SizedBox(height: 10),
                    Container(
                      width: 240,
                      child: Text(
                        address.addressDetail ?? "Địa chỉ chi tiết",
                        style: TextStyle(
                          fontSize: 12,
                          color: MyColor.TEXT_COLOR_NEW,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                    Container(
                      width: 250,
                      child: Text(
                        address.ward != '0'
                            ? '${address.ward}, ${address.district}, ${address.province}'
                            : '${address.district}, ${address.province}',
                        style: TextStyle(
                          fontSize: 13,
                          color: MyColor.black_80,
                        ),
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      '${address.fullName} | ${address.phoneNumber}',
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.black,
                      ),
                    )
                  ],
                ),
              ],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                GestureDetector(
                  onTap: () => editAddress(),
                  child: Text(
                    isBeingEdited ? 'Xong' : 'Sửa',
                    style:
                        TextStyle(color: MyColor.TEXT_COLOR_NEW, fontSize: 12),
                  ),
                ),
                isBeingEdited
                    ? GestureDetector(
                        onTap: () => removeAddress(),
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 24, vertical: 8),
                          decoration: BoxDecoration(
                              color: MyColor.PRIMARY_COLOR,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(8))),
                          child: Text(
                            'Xoá',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: MyColor.white,
                                fontSize: 12,
                                fontWeight: FontWeight.w400),
                          ),
                        ),
                      )
                    : Container()
              ],
            )
          ],
        ));
  }
}
