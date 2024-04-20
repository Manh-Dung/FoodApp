import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:ints/base/base_controller.dart';
import 'package:ints/base/base_view_view_model.dart';

import '../../forgot_password/forgot_password_binding.dart';

class OtpScreen extends BaseView<ForgotPasswordController> {
   final otp_controller = Get.find<ForgotPasswordController>();
  @override
  Widget vBuilder() {
    return Scaffold(
      appBar: AppBar(
        leadingWidth: 60,
        leading: IconButton(
            onPressed: () {
              Get.back();
            },
            icon: Icon(
              Icons.arrow_back,
              color: Colors.grey,
            )),
        backgroundColor: Colors.transparent,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 20),
        child: Column(children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Xác minh OTP",
                style: TextStyle(
                    fontWeight: FontWeight.w700, color: MyColor.TEXT_COLOR_NEW, fontSize: 24),
              ),
              Text(
                "Nhập mã OTP chúng tôi vừa gửi vào địa chỉ email của bạn",
                style: TextStyle(
                    fontSize: 12, fontWeight: FontWeight.w400, color: MyColor.TEXT_COLOR_NEW),
              ),
              Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
                  child: OtpTextField(
                    numberOfFields: 4,
                    showFieldAsBox: true,
                    onCodeChanged: (String code) {},
                    onSubmit: (String verification){
                      otp_controller.otpController.text = verification;
                    },
                  )),
              InkWell(
                onTap: () {
                  otp_controller.sendOTP();

                },
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                  width: 350,
                  height: 45,
                  decoration: BoxDecoration(
                      color: MyColor.PRIMARY_COLOR1, borderRadius: BorderRadius.circular(10)),
                  child: Text(
                    "Xác nhận",
                    style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ],
          ),
          Expanded(
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Bạn chưa nhận được mã OTP? ",
                    style: TextStyle(color: Colors.black, fontSize: 14),
                  ),
                  TextButton(
                      onPressed: () {
                        Get.toNamed(RouterName.register);
                      },
                      child: Text(
                        "Gửi lại",
                        style: TextStyle(color: MyColor.PRIMARY_COLOR),
                      ),style: TextButton.styleFrom(
                    minimumSize: Size.zero,
                    padding: EdgeInsets.zero,
                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  ),)
                ],
              ),
            ),
          ),
        ]),
      ),
    );
  }
}
