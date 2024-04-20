import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ints/base/base_controller.dart';
import 'package:ints/x_utils/widgets/authentication_button.dart';

class ChangePasswordSuccess extends StatelessWidget {
  const ChangePasswordSuccess({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset(XR().svgImage.ic_success),
              const SizedBox(height: 32),
              Text(
                "Mật khẩu đã được thay đổi",
                style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: MyColor.TEXT_COLOR_NEW),
              ),
              Text(
                "Mật khẩu của bạn đã được thay đổi thành công",
                style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                    color: MyColor.TEXT_COLOR_NEW),
              ),
              const SizedBox(height: 112),
              AuthenticationButton(
                message: "Quay lại đăng nhập",
                onPressed: () {
                  while (Get.currentRoute != RouterName.login) {
                    Get.back();
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
