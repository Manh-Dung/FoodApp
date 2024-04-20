import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ints/base/base_controller.dart';

class InforAccount extends StatelessWidget {
  final String svgPath1;
  final String para;
  final int count;

  InforAccount({
    Key? key,
    required this.svgPath1,
    required this.para,
    required this.count,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Stack(
          children: [
            SvgPicture.asset(
              svgPath1,
              width: 24,
              height: 24,
            ),
            count == 0
                ? Container()
                : Positioned(
                    right: 0,
                    top: -2,
                    child: Container(
                      padding: const EdgeInsets.all(3),
                      decoration: BoxDecoration(
                        color: Colors.red,
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.white, width: 1),
                      ),
                      child: Center(
                        child: Text(
                          count.toString(),
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 7,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                    ),
                  )
          ],
        ),
        SizedBox(width: 6),
        Text(
          para,
          style: TextStyle(
            fontWeight: FontWeight.w400,
            color: MyColor.TEXT_COLOR_NEW,
          ),
        ),
        Spacer(),
        Icon(
          Icons.arrow_forward_ios,
          size: 16,
          color: Colors.grey,
        ),
      ],
    );
  }
}

// import 'package:flutter/material.dart';
// import 'package:flutter_svg/flutter_svg.dart';
// import 'package:ints/base/base_controller.dart';
// import 'package:ints/views/list_feedback/list_feedback_binding.dart';
// import 'package:ints/views/wait_for_delivery/wait_for_delivery_binding.dart';
//
// class InforAccount extends StatelessWidget {
//   final String svgPath1;
//   final String label;
//
//   final waitController = Get.find<WaitForDeliveryController>();
//   final feedbackController = Get.find<ListFeedbackController>();
//
//   InforAccount({
//     Key? key,
//     required this.svgPath1,
//     required this.label,
//   }) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Row(
//       children: [
//         Stack(
//           children: [
//             SvgPicture.asset(
//               svgPath1,
//               width: 24,
//               height: 24,
//             ),
//             waitController.rxListOrder.isEmpty && label == "Chờ lấy hàng"
//                 ? Container()
//                 : feedbackController.rxListNoFeedback.isEmpty && label == "Đánh giá"
//                 ? Container()
//                 : _dotCount(
//               count: label == "Chờ lấy hàng"
//                   ? waitController.rxListOrder.length.toString()
//                   : feedbackController.rxListNoFeedback.length.toString(),
//             ),
//           ],
//         ),
//         SizedBox(width: 6),
//         Text(
//           label,
//           style: TextStyle(
//             fontWeight: FontWeight.w400,
//             color: MyColor.TEXT_COLOR_NEW,
//           ),
//         ),
//         Spacer(),
//         Icon(
//           Icons.arrow_forward_ios,
//           size: 16,
//           color: Colors.grey,
//         ),
//       ],
//     );
//   }
//
//   Widget _dotCount({required String count}) {
//     return Positioned(
//       right: 0,
//       top: -2,
//       child: Container(
//         padding: const EdgeInsets.all(3),
//         decoration: BoxDecoration(
//           color: Colors.red,
//           shape: BoxShape.circle,
//           border: Border.all(color: Colors.white, width: 1),
//         ),
//         child: Center(
//           child: Text(
//             count,
//             style: TextStyle(
//               color: Colors.white,
//               fontSize: 7,
//               fontWeight: FontWeight.w400,
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
