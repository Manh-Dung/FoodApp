import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:ints/base/base_view_view_model.dart';
import 'package:ints/views/search_product/search_product_binding.dart';

class SearchProductScreen extends BaseView<SearchProductController> {
  @override
  Widget vBuilder() => Scaffold(
        body: SafeArea(
          child: Column(
            children: [
              _headerBar(),
              Expanded(
                child: Container(
                  decoration: BoxDecoration(color: MyColor.BACKGROUND_COLOR),
                  child: Obx(() => controller.rxSearchHistory.length > 0
                      ? ListView.separated(
                          separatorBuilder: (context, index) => Divider(
                            height: 0.1,
                            thickness: 0.2,
                          ),
                          itemBuilder: (BuildContext context, int index) {
                            return PhysicalModel(
                              elevation: 10,
                              shadowColor: Color.fromRGBO(0, 0, 0, 0.25),
                              color: Colors.white,
                              child: Container(
                                child: Column(
                                  children: [
                                    if (index == controller.itemCount.value)
                                      Container(
                                        height: 35,
                                        child: Center(
                                          child: TextButton(
                                            child: Text(
                                              controller.searchListOption.value,
                                              style: TextStyle(
                                                color: Color.fromRGBO(
                                                    148, 148, 153, 1),
                                                fontWeight: FontWeight.w400,
                                                fontSize: 12,
                                              ),
                                            ),
                                            onPressed: () {
                                              controller.seeAllSearchHistory();
                                            },
                                          ),
                                        ),
                                      )
                                    else
                                      InkWell(
                                        onTap: () {
                                          controller.searchController.text =
                                              controller.rxSearchHistory[index];
                                          controller.saveSearchHistory();
                                        },
                                        child: Padding(
                                          padding:
                                              const EdgeInsets.only(left: 15),
                                          child: SizedBox(
                                            height: 35,
                                            child: ListTile(
                                              dense: true,
                                              visualDensity:
                                                  VisualDensity(vertical: 0.2),
                                              title: Align(
                                                alignment:
                                                    FractionalOffset.topLeft,
                                                child: Text(
                                                  controller
                                                      .rxSearchHistory[index],
                                                  style: TextStyle(
                                                      color: Color.fromRGBO(
                                                          78, 79, 84, 1),
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.w400),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                  ],
                                ),
                              ),
                            );
                          },
                          itemCount: controller.rxSearchHistory.length >= 4
                              ? controller.itemCount.value <= 10
                                  ? controller.itemCount.value + 1
                                  : 10
                              : controller.rxSearchHistory.length,
                        )
                      : Container()),
                ),
              ),
            ],
          ),
        ),
      );

  Container _headerBar() {
    return Container(
      color: Colors.white,
      padding: EdgeInsets.only(top: 15),
      child: Column(children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Expanded(
              flex: 1,
              child: IconButton(
                icon: SvgPicture.asset(
                  XR().svgImage.ic_back,
                  color: MyColor.PRIMARY_COLOR,
                ),
                onPressed: () => Get.back(),
              ),
            ),
            Expanded(
                child: Container(
                    decoration: BoxDecoration(
                      color: Colors.transparent,
                    ),
                    child: TextField(
                      focusNode: controller.focusNode,
                      controller: controller.searchController,
                      decoration: InputDecoration(
                          constraints: BoxConstraints(
                            maxHeight: 40,
                          ),
                          filled: true,
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide: BorderSide(
                                  color: Color.fromRGBO(34, 161, 33, 1),
                                  width: 0.11)),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: BorderSide(
                              color: Color.fromRGBO(34, 161, 33, 1),
                              width: 1,
                            ),
                          ),
                          hintText: controller.rxSearchHistory.isNotEmpty
                              ? controller.rxSearchHistory[0]
                              : 'Hiển thị nhiều hơn',
                          hintStyle: TextStyle(
                              color: Color.fromRGBO(148, 148, 153, 1),
                              fontWeight: FontWeight.w400,
                              fontSize: 12)),
                    )),
                flex: 6),
            const SizedBox(width: 10),
            Expanded(
              flex: 1,
              child: Container(
                margin: EdgeInsets.only(right: 10),
                height: 40,
                decoration: BoxDecoration(
                  color: const Color.fromRGBO(34, 161, 33, 1),
                  borderRadius: BorderRadius.all(Radius.circular(8)),
                ),
                child: IconButton(
                  icon: SvgPicture.asset(XR().svgImage.ic_magnifying),
                  onPressed: () {
                    controller.saveSearchHistory();
                  },
                ),
              ),
            ),
          ],
        ),
      ]),
    );
  }
}
