import 'package:flutter/material.dart';
import 'package:ints/base/base_view_view_model.dart';

import 'feedback_binding.dart';
import 'widgets/feedback_product_item.dart';

class FeedbackScreen extends BaseView<FeedbackController> {
  @override
  Widget vBuilder() {
    return Scaffold(
      appBar: _appBar(),
      backgroundColor: MyColor.BACKGROUND_COLOR,
      body: Obx(
        () => Container(
          color: MyColor.white,
          width: double.infinity,
          child: ListView.separated(
            shrinkWrap: true,
            itemBuilder: (BuildContext context, int index) {
              return Obx(() => FeedbackProductItem(
                    order: controller.rxOrder.value != null ? controller.rxOrder.value : null,
                    noFeedback:
                        controller.rxFeedback.value != null ? controller.rxFeedback.value : null,
                    index: index,
                    listImage: controller.rxListImagePath,
                    onRatingUpdate: (value) {
                      controller.rxListRating[index] = value;
                      controller.rxListStatus[controller.rxListRating[index].toInt() - 1];
                    },
                    status: controller.rxListStatus[controller.rxListRating[index].toInt() - 1],
                    controller: controller.ratingControllers,
                    onPickImage: () {
                      controller.onPickImage();
                    },
                    onRemoveImage: (int index) {
                      controller.onRemoveImage(index);
                    },
                    rating: controller.rxListRating[index],
                  ));
            },
            separatorBuilder: (BuildContext context, int index) {
              return Container(height: 4, color: MyColor.BACKGROUND_COLOR);
            },
            itemCount:
                controller.rxOrder.value != null ? controller.rxOrder.value!.cartItems!.length : 1,
          ),
        ),
      ),
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
            fontWeight: FontWeight.w700,
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
        InkWell(
          onTap: () {
            if (controller.rxFeedback.value?.feedbackId != null) {
              controller.updateFeedback();
            } else {
              if (controller.rxOrder.value != null) {
                controller.postMultiFeedback();
              } else {
                controller.postSingleFeedback();
              }
            }
          },
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 20),
            decoration: BoxDecoration(
              color: MyColor.PRIMARY_COLOR,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              "Gửi",
              style: TextStyle(
                color: MyColor.white,
                fontSize: 12,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
        ),
        const SizedBox(width: 16),
      ],
    );
  }
}
