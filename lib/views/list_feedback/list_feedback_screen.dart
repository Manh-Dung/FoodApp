import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:ints/base/base_view_view_model.dart';

import 'list_feedback_binding.dart';
import 'widget/feedback_item.dart';
import 'widget/not_yet_rate.dart';

class ListFeedbackScreen extends BaseView<ListFeedbackController> {
  @override
  Widget vBuilder() {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          "Đánh giá của tôi",
          style: TextStyle(
            color: MyColor.TEXT_COLOR_NEW,
            fontSize: 20,
            fontWeight: FontWeight.w700,
          ),
        ),
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: Icon(
            Icons.arrow_back,
            color: MyColor.TEXT_COLOR_NEW,
          ),
        ),
      ),
      body: SafeArea(
        child: Container(
          color: MyColor.BACKGROUND_COLOR,
          child: Obx(
            () => Column(
              children: [
                _tabBar(),
                const SizedBox(height: 8),
                Expanded(
                  child: TabBarView(controller: controller.tabController, children: [
                    Obx(() => _listFeedBackSeparated()),
                    Obx(() => _listFeedBackSeparatedNot()),
                  ]),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _tabBar() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 1,
            blurRadius: 2,
            offset: Offset(0, 2), // changes position of shadow
          ),
        ],
      ),
      child: TabBar(
        tabAlignment: TabAlignment.fill,
        controller: controller.tabController,
        isScrollable: false,
        unselectedLabelColor: MyColor.TEXT_COLOR_NEW,
        indicatorSize: TabBarIndicatorSize.tab,
        labelStyle: TextStyle(fontSize: 14, fontWeight: FontWeight.w400),
        indicatorColor: MyColor.PRIMARY_COLOR,
        tabs: List.generate(
          controller.rxTabNameList.length,
          (index) => Tab(
            text: controller.rxTabNameList[index],
          ),
        ),
      ),
    );
  }

  Widget _listFeedBackSeparated() {
    return RefreshIndicator(
      onRefresh: () async {
        controller.onRefresh();
      },
      child: ListView.separated(
        separatorBuilder: (_, index) => const SizedBox(height: 4),
        controller: controller.scrollController,
        itemBuilder: (_, index) {
          return Obx(() => FeedBackItemUser(
                feedback: controller.rxListFeedBackUser[index],
                isCheckShimmerLoading: controller.rxShimmerLoading.value,
                user: controller.appController.rxUser.value,
                onTapEditFeedback: () {
                  Get.toNamed(RouterName.feedback, arguments: {
                    "feedback": controller.rxListFeedBackUser[index],
                  });
                },
                onTapProductDetail: () {
                  controller
                      .getProductById(controller.rxListFeedBackUser[index].productId ?? 0)
                      .then((value) =>
                          Navigator.pushNamed(Get.context!, RouterName.product_detail, arguments: {
                            "product": value.toJson(),
                          }));
                },
              ));
        },
        itemCount: controller.rxListFeedBackUser.length,
        shrinkWrap: true,
      ),
    );
  }

  Widget _listFeedBackSeparatedNot() {
    return RefreshIndicator(
      onRefresh: () async {
        controller.onRefresh();
      },
      child: ListView.separated(
        separatorBuilder: (_, index) => const SizedBox(height: 4),
        controller: controller.scrollCtrlNoFeedback,
        itemBuilder: (_, index) {
          return NotYetRate(
            noFeedback: controller.rxListNoFeedback[index],
          );
        },
        itemCount: controller.rxListNoFeedback.length,
        shrinkWrap: true,
      ),
    );
  }

  Widget _dotCount({required bool isDisplay, required String count}) {
    return isDisplay
        ? Positioned(
            right: 0,
            top: -3,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.red,
                shape: BoxShape.circle,
              ),
              padding: const EdgeInsets.all(2),
              child: Text(
                count,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 7,
                ),
              ),
            ))
        : Container();
  }
}
