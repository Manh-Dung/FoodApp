import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../base/base_controller.dart';
import '../../../x_utils/get_storage_util.dart';

class NavItem extends StatelessWidget {
  final int index;
  final String icon;
  final String title;
  final Function() onTap;
  final bool isSelected;
  final int? cartCount;
  final int? chatCount;
  final bool? isLogin;

  const NavItem(
      {required this.index,
      required this.icon,
      required this.title,
      required this.onTap,
      required this.isSelected,
      this.cartCount,
      this.chatCount,
      this.isLogin});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
        if (isLogin == false) {
          var data = await Get.toNamed(RouterName.choose_login_signup);
        } else {
          onTap();
        }
      },
      child: Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 12),
        decoration: BoxDecoration(
          border: Border(
            top: BorderSide(
              color: isSelected ? MyColor.PRIMARY_COLOR : Colors.transparent,
              width: 2,
            ),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
                width: 24,
                height: 24,
                child: Stack(
                  children: [
                    SvgPicture.asset(icon),
                    if (index == 2)
                      cartCount != 0 && cartCount != null
                          ? Positioned(
                              right: 0,
                              top: -3,
                              child: Container(
                                padding: const EdgeInsets.all(3),
                                decoration: BoxDecoration(
                                  color: Colors.red,
                                  shape: BoxShape.circle,
                                  border: Border.all(color: MyColor.white, width: 1),
                                ),
                                child: Text(
                                  "${cartCount ?? 0}",
                                  style: TextStyle(
                                    color: MyColor.white,
                                    fontSize: 7,
                                  ),
                                ),
                              ),
                            )
                          : Container()
                    else if (index == 3)
                      chatCount != null
                          ? Positioned(
                              right: 0,
                              top: -3,
                              child: Container(
                                padding: const EdgeInsets.all(3),
                                decoration: BoxDecoration(
                                  color: Colors.red,
                                  shape: BoxShape.circle,
                                  border: Border.all(color: MyColor.white, width: 1),
                                ),
                                child: Text(
                                  "${chatCount ?? 0}",
                                  style: TextStyle(
                                    color: MyColor.white,
                                    fontSize: 7,
                                  ),
                                ),
                              ),
                            )
                          : Container()
                  ],
                )),
            Text(
              title,
              style: TextStyle(
                  color: isSelected ? MyColor.PRIMARY_COLOR : MyColor.TEXT_COLOR_NEW,
                  fontWeight: FontWeight.w400,
                  fontSize: 12.0),
            ),
          ],
        ),
      ),
    );
  }
}
