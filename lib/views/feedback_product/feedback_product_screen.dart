import 'package:flutter/material.dart';
import 'package:ints/base/base_view_view_model.dart';

import 'feedback_product_binding.dart';
import 'widgets/feedback_product_item.dart';

class FeedBackProductScreen extends BaseView<FeedBackProductController> {
  @override
  Widget vBuilder() {
    return Scaffold(
      appBar: _appBar(),
      backgroundColor: MyColor.BACKGROUND_COLOR,
      body: SafeArea(
          child: ListView.separated(
        separatorBuilder: (_, index) => const SizedBox(height: 4),
        shrinkWrap: true,
        physics: const BouncingScrollPhysics(),
        itemBuilder: (_, index) {
          return Padding(
            padding: index == 0
                ? const EdgeInsets.only(top: 8)
                : const EdgeInsets.all(0),
            child: Obx(() => FeedBackProductItem(
                  feedbackProduct: controller.rxListFeedBackProduct[index],
                )),
          );
        },
        itemCount: controller.rxListFeedBackProduct.length,
      )),
    );
  }

  AppBar _appBar() {
    return AppBar(
      leading: IconButton(
        icon: Icon(Icons.arrow_back_rounded, color: Colors.black),
        onPressed: () => Get.back(),
      ),
      title: Text('Đánh giá sản phẩm',
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
    );
  }
}
