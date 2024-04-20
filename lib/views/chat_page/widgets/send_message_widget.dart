import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:ints/views/chat_page/widgets/custom_shape.dart';

import '../../../x_res/x_r.dart';

class SentMessageWidget extends StatefulWidget {
  final String message;
  final String time;
  final VoidCallback? onEdit;
  final VoidCallback? onDelete;
  final bool? isEdit;

  const SentMessageWidget({
    Key? key,
    required this.message,
    required this.time,
    this.onEdit,
    this.onDelete,
    this.isEdit = false,
  }) : super(key: key);

  @override
  State<SentMessageWidget> createState() => _SentMessageWidgetState();
}

class _SentMessageWidgetState extends State<SentMessageWidget> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 16).r,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          Flexible(
              child: InkWell(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Flexible(
                  child: InkWell(
                    onTap: () {},
                    child: Container(
                      margin: EdgeInsets.only(left: 98.w, right: 20.w),
                      padding: EdgeInsets.only(left: 15.w, right: 15.w, top: 16.h, bottom: 3.h),
                      decoration: BoxDecoration(
                        color: Color.fromRGBO(255, 236, 209, 1),
                        borderRadius: BorderRadius.circular(8.r),
                        boxShadow: [
                          BoxShadow(
                            color: Color.fromRGBO(0, 0, 0, 0.25),
                            spreadRadius: 0,
                            blurRadius: 1,
                            offset: Offset(0, 1),
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 4),
                          Text(
                            widget.message,
                            style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w400,
                                color: Color.fromRGBO(78, 79, 84, 1),
                                ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Text(
                                widget.time,
                                style: TextStyle(
                                    fontSize: 10,
                                    color: Color.fromRGBO(148, 148, 153, 1),
                                    decoration: TextDecoration.none),
                              ),
                              SizedBox(
                                width: 5.h,
                              ),
                              SvgPicture.asset(
                                XR().svgImage.ic_check,
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          )),
        ],
      ),
    );
  }
}
