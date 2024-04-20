// import 'package:flutter/material.dart';
// import 'package:ints/base/base_view_view_model.dart';
// import 'package:ints/views/reset_password/reset_password_binding.dart';
// import 'package:ints/x_utils/widgets/authentication_button.dart';
// import 'package:ints/x_utils/widgets/my_text_form_field.dart';
//
// class ResetPasswordScreen extends BaseView<ResetPasswordController> {
//   @override
//   Widget vBuilder() {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(
//           "Đặt lại mật khẩu ",
//           style: TextStyle(color: Colors.white, fontSize: 24),
//         ),
//         centerTitle: true,
//         toolbarHeight: 100,
//       ),
//       body: SafeArea(
//         child: Padding(
//           padding: const EdgeInsets.only(top: 50.0, left: 10, right: 10),
//           child: Column(
//             children: [
//               Icon(
//                 Icons.security,
//                 size: 50,
//                 color: Colors.black,
//               ),
//               SizedBox(
//                 height: 50,
//               ),
//               MyTextFormField(
//                 controller: controller.otp,
//                 labelText: "Nhập mã OTP",
//               ),
//               SizedBox(
//                 height: 20,
//               ),
//               MyTextFormField(
//                 controller: controller.newPassword,
//                 labelText: "Nhập mật khẩu mới",
//                 obscureText: true,
//               ),
//               SizedBox(
//                 height: 20,
//               ),
//               MyTextFormField(
//                 controller: controller.confirmPassword,
//                 labelText: "Nhập mật khẩu xác thực ",
//                 obscureText: true,
//               ),
//               SizedBox(
//                 height: 20,
//               ),
//               AuthenticationButton(
//                   message: "Đổi mật khẩu",
//                   onPressed: () {
//                     controller.resetPassword();
//                   }),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
