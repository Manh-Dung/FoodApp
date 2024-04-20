import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../base/base_controller.dart';

class LoginOrSignUpScreen extends StatelessWidget {
  const LoginOrSignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SvgPicture.asset(
              XR().svgImage.ic_logo_app_new,
            ),
            Padding(padding: EdgeInsets.only(bottom: 150)),
            InkWell(
              onTap: () {
                Get.toNamed(RouterName.login);
              },
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 15, horizontal: 140),
                // width: 350,
                // height: 45,
                decoration: BoxDecoration(
                    color: MyColor.PRIMARY_COLOR1,
                    borderRadius: BorderRadius.circular(8)),
                child: Text(
                  "Đăng nhập",
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold,fontSize: 14),
                  textAlign: TextAlign.center
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            InkWell(
              onTap: () {
                Get.toNamed(RouterName.register);
              },
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 15, horizontal: 150),
                // width: 350,
                // height: 45,
                decoration: BoxDecoration(
                    border: Border.all(color: MyColor.TEXT_COLOR_NEW, width: 1),
                    borderRadius: BorderRadius.circular(8)),
                child: Text(
                  "Đăng ký",
                  style: TextStyle(
                      color: MyColor.TEXT_COLOR_NEW,
                      fontWeight: FontWeight.w400,fontSize: 12),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            InkWell(
              onTap: () {
                Get.back();
              },
              child: Container(
                child: Text(
                  "Tiếp tục bằng tài khoản khách",
                  style: TextStyle(
                      color: MyColor.PRIMARY_COLOR1,
                      decoration: TextDecoration.underline,
                      decorationColor: MyColor.PRIMARY_COLOR1,
                      fontWeight: FontWeight.bold,
                      fontSize: 12),
                ),
              ),
              enableFeedback: false,
            )
          ],
        ),
      ),
    );
  }
}
