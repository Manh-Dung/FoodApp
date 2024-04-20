import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ints/base/base_view_view_model.dart';
import 'package:ints/views/expanded_list_view/expanded_list_view_screen.dart';
import 'package:ints/views/login/login_binding.dart';
import 'package:ints/x_utils/widgets/authentication_button.dart';

import '../../x_utils/widgets/my_text_form_field.dart';

class LoginScreen extends BaseView<LoginController> {
  final _formError = GlobalKey<FormState>();

  @override
  Widget vBuilder() => Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(50),
          child: AppBar(
            leadingWidth: 60,
            leading: IconButton(
                onPressed: () {},
                icon: IconButton(
                    onPressed: () {
                      Get.back();
                    },
                    icon: Icon(
                      Icons.arrow_back,
                      color: Colors.grey,
                    ))),
            backgroundColor: Colors.transparent,
          ),
        ),
        body: Form(
          key: _formError,
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Xin chào bạn !",
                      style: TextStyle(
                          color: MyColor.TEXT_COLOR_NEW,
                          fontSize: 24,
                          fontWeight: FontWeight.w700),
                    ),
                    Text(
                      "Rất vui vì đã quay trở lại",
                      style: TextStyle(
                          color: MyColor.TEXT_COLOR_NEW,
                          fontSize: 24,
                          fontWeight: FontWeight.w700),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    MyTextFormField(
                      controller: controller.userNameTextController,
                      labelText: "Nhập số điện thoại hoặc email",
                    ),
                    const SizedBox(height: 8),
                    MyTextFormField(
                      obscureText: true,
                      controller: controller.passwordTextController,
                      // prefixIcon: Icon(Icons.security),
                      labelText: XR().string.hintText2,
                    ),
                    SizedBox(height: 6),
                    Row(
                      children: [
                        InkWell(
                          onTap: () {
                            controller.isChecked.value =
                                !controller.isChecked.value;
                          },
                          splashColor: Colors.transparent,
                          child: Row(
                            children: [
                              Obx(
                                () => Checkbox(
                                  materialTapTargetSize:
                                      MaterialTapTargetSize.shrinkWrap,
                                  visualDensity:
                                      VisualDensity(horizontal: -4, vertical: -4),
                                  value: controller.isChecked.value,
                                  onChanged: (value) {
                                    controller.isChecked.value = value!;
                                  },
                                  activeColor: Colors.white,
                                  checkColor: MyColor.PRIMARY_COLOR,
                                  side: MaterialStateBorderSide.resolveWith(
                                    (Set<MaterialState> states) {
                                      if (states.contains(MaterialState.selected)) {
                                        return BorderSide(
                                            color: MyColor.CHECKBOX_COLOR,
                                            width: 1.0);
                                      }
                                      return BorderSide(
                                          color: Colors.grey, width: 1.0);
                                    },
                                  ),
                                ),
                              ),
                              SizedBox(width: 8),
                              Text(XR().string.rememberPass)
                            ],
                          ),
                        ),
                        TextButton(
                          onPressed: () {
                            Get.toNamed(RouterName.forgot_password);
                          },
                          child: Text(
                            XR().string.forgotPass,
                            style: TextStyle(color: Colors.red),
                          ),
                          style: TextButton.styleFrom(padding: EdgeInsets.zero),
                        )
                      ],
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    ),
                    SizedBox(height: 6),
                    AuthenticationButton(
                      message: "Đăng nhập ",
                      onPressed: () {
                        if (_formError.currentState!.validate()) {
                          if (!controller.isEmail(
                              controller.userNameTextController.text.trim())) {
                            if (!controller.isPhoneNumber(
                                controller.userNameTextController.text.trim())) {
                              controller.handleErrorStringShowToast(
                                error: "Số điện thoại hoặc email không hợp lệ",
                              );
                              return;
                            }
                            controller.loginPhone();
                          } else {
                            controller.login();
                          }
                        }
                      },
                    ),
                    const SizedBox(height: 40),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                            width: 80,
                            child: Divider(
                              height: 1,
                              color: Colors.grey.shade300,
                            )),
                        Text(
                          "Hoặc đăng nhập bằng",
                          style: TextStyle(color: Colors.grey.shade600),
                        ),
                        SizedBox(
                            width: 80,
                            child: Divider(
                              height: 1,
                              color: Colors.grey.shade300,
                            )),
                        // Divider(height: 1,color: MyColor.TEXT_COLOR_NEW,),
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        icon(icon: XR().svgImage.ic_facebook),
                        const SizedBox(width: 8),
                        icon(icon: XR().svgImage.ic_google),
                        const SizedBox(width: 8),
                        icon(icon: XR().svgImage.ic_apple),
                      ],
                    ),
                  ],
                ),
                Spacer(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Bạn chưa có tài khoản? ",
                      style: TextStyle(color: Colors.black, fontSize: 12),
                    ),
                    TextButton(
                      onPressed: () {
                        Get.toNamed(RouterName.register);
                      },
                      child: Text(
                        "Đăng ký",
                        style: TextStyle(
                            color: Colors.green.shade800, fontSize: 12),
                      ),
                      style: TextButton.styleFrom(
                          padding: EdgeInsets.zero,
                          minimumSize: Size.zero,
                          tapTargetSize: MaterialTapTargetSize.shrinkWrap),
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      );

  Widget icon({required String icon}) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: MyColor.DIVIDER_COLOR, width: 1),
      ),
      child: SvgPicture.asset(icon),
    );
  }
}
