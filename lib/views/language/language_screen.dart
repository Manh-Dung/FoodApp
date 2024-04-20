import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../base/base_view_view_model.dart';
import 'language_binding.dart';

class LanguageScreen extends BaseView<LanguageController> {
  LanguageScreen({super.key});
  @override
  Widget vBuilder() {
    return Scaffold(
        backgroundColor: Color.fromRGBO(225, 226, 227, 1),
        appBar: _appBar(),
        body: Obx(() => Column(
              children: [
                IntrinsicHeight(
                  child: GestureDetector(
                    onTap: () => controller.toggleLanguage(),
                    child: Container(
                        width: double.infinity,
                        padding: const EdgeInsets.symmetric(
                            vertical: 20, horizontal: 20),
                        decoration: (BoxDecoration(
                            color: MyColor.SHIMMER_BASE_COLOR,
                            border: Border(
                              bottom:
                                  BorderSide(width: 0.5, color: MyColor.border),
                            ))),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Tiếng Anh",
                              style: TextStyle(
                                fontSize: 12,
                                color: Color.fromRGBO(23, 23, 23, 1),
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            controller.isVietnameseChecked.value == true
                                ? Container()
                                : SvgPicture.asset(
                                    XR().svgImage.ic_check,
                                    width: 24,
                                    height: 24,
                                  )
                          ],
                        )),
                  ),
                ),
                IntrinsicHeight(
                  child: GestureDetector(
                    onTap: () => controller.toggleLanguage(),
                    child: Container(
                        width: double.infinity,
                        padding: const EdgeInsets.symmetric(
                            vertical: 20, horizontal: 20),
                        decoration: (BoxDecoration(
                            color: MyColor.SHIMMER_BASE_COLOR,
                            border: Border(
                              bottom:
                                  BorderSide(width: 0.5, color: MyColor.border),
                            ))),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Tiếng Việt",
                              style: TextStyle(
                                fontSize: 12,
                                color: Color.fromRGBO(23, 23, 23, 1),
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            controller.isVietnameseChecked.value == true
                                ? SvgPicture.asset(
                                    XR().svgImage.ic_check,
                                    width: 24,
                                    height: 24,
                                  )
                                : Container()
                          ],
                        )),
                  ),
                ),
              ],
            )));
  }

  AppBar _appBar() {
    return AppBar(
      leading: IconButton(
        icon: Icon(Icons.arrow_back_rounded, color: Colors.black),
        onPressed: () => Get.back(),
      ),
      title: Text('Chọn ngôn ngữ',
          style: TextStyle(
            fontSize: 21,
            fontWeight: FontWeight.w500,
            color: Colors.black,
          )),
      centerTitle: true,
      flexibleSpace: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 2,
              blurRadius: 2,
              offset: Offset(0, 1),
            ),
          ],
        ),
      ),
      actions: [
        Obx(() => controller.isToggled.value
            ? Container(
                margin: EdgeInsets.only(right: 16),
                padding: EdgeInsets.all(9),
                decoration: BoxDecoration(
                    color: MyColor.PRIMARY_COLOR,
                    borderRadius: BorderRadius.all(Radius.circular(8))),
                child: Text(
                  'Hoàn thành',
                  style: TextStyle(
                      color: MyColor.white,
                      fontSize: 12,
                      fontWeight: FontWeight.w400),
                ),
              )
            : Container()),
      ],
    );
  }
}
