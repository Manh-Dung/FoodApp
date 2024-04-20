import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:ints/base/base_controller.dart';
import 'package:ints/models/feedback/feedback_user.dart';
import 'package:ints/models/image_model/image_model.dart';

import '../../base/base_view_view_model.dart';
import '../../models/feedback/post_feedback.dart';
import '../../models/order/order.dart';

class FeedbackBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => FeedbackController());
  }
}

class FeedbackController extends BaseController {
  Rxn<Order> rxOrder = Rxn<Order>();
  Rxn<FeedbackUser> rxFeedback = Rxn<FeedbackUser>();

  RxList<String> rxListStatus = RxList<String>([
    "Rất tệ",
    "Tệ",
    "Bình thường",
    "Tốt",
    "Rất tốt",
  ]);

  RxList<double> rxListRating = RxList<double>();
  late TextEditingController ratingControllers;

  RxList<String?> rxListImagePath = RxList.filled(6, null);

  @override
  void onInit() {
    super.onInit();

    var order = Get.arguments['order'];
    var feedback = Get.arguments['feedback'];

    if (order != null) {
      rxOrder.value = order;
      rxListRating.value = RxList.filled(rxOrder.value?.cartItems?.length ?? 0, 5.0);
      ratingControllers = TextEditingController();
    }

    if (feedback != null) {
      rxFeedback.value = feedback;
      rxListRating.value = RxList.filled(
          1,
          rxFeedback.value?.feedbackId != null
              ? (rxFeedback.value?.feedback?.rating ?? 1).toDouble()
              : 5.0);
      ratingControllers = TextEditingController(text: rxFeedback.value?.feedback?.content ?? "");
      for (ImageModel item in rxFeedback.value?.feedback?.image ?? []) {
        rxListImagePath[rxListImagePath.indexWhere((element) => element == null)] = item.path;
      }
    }
  }

  void onPickImage() async {
    final List<XFile> returnImages = await ImagePicker().pickMultiImage(imageQuality: 6);
    if (returnImages.isNotEmpty) {
      if (returnImages.length <= 6) {
        postFiles(files: returnImages.map((e) => File(e.path)).toList());
      } else {
        handleErrorStringShowToast(error: "Chỉ được chọn tối đa 6 ảnh");
      }
    }
  }

  Future postFiles({required List<File?> files}) async {
    showLoadingDialog();
    try {
      var res = await fileRepositories.postFiles(files: files);
      for (var item in res) {
        int? nullIndex = rxListImagePath.indexWhere((element) => element == null);
        if (nullIndex != -1) {
          rxListImagePath[nullIndex] = item.path;
          update();
        } else {
          break;
        }
      }
      hideDialog();
    } catch (e) {
      hideDialog();
      print(e.toString());
    }
  }

  Future postSingleFeedback() async {
    showLoadingDialog();
    try {
      await feedbackRepositories.postSingleFeedback(
        productId: rxFeedback.value!.productId!,
        images: rxListImagePath,
        rating: rxListRating[0],
        content: ratingControllers.text,
        priceId: rxFeedback.value?.priceId ?? 0,
      );
      hideDialog();
      while (Get.currentRoute != RouterName.home) {
        Get.back();
      }
    } catch (e) {
      hideDialog();
      print(e.toString());
    }
  }

  Future postMultiFeedback() async {
    showLoadingDialog();
    try {
      List<PostFeedback> feedbacks = [];
      List<String> images = [];
      images = rxListImagePath.where((p0) => p0 != null).toList().cast<String>();

      for (int i = 0; i < rxOrder.value!.cartItems!.length; i++) {
        feedbacks.add(PostFeedback(
          productId: rxOrder.value?.cartItems?[i].productId ?? 0,
          priceId: rxOrder.value?.cartItems?[i].priceId ?? 0,
          image: images,
          rating: rxListRating[i],
          content: ratingControllers.text,
        ));
      }
      await feedbackRepositories.postMultiFeedback(feedbacks: feedbacks);
      hideDialog();

      while (Get.currentRoute != RouterName.home) {
        Get.back();
      }
    } catch (e) {
      hideDialog();
      print(e.toString());
    }
  }

  Future<void> onRemoveImage(int index) async {
    rxListImagePath[index] = null;
    rxListImagePath.refresh();
    update();
  }

  Future<void> updateFeedback() async {
    showLoadingDialog();
    try {
      await feedbackRepositories.updateFeedback(
        feedbackId: rxFeedback.value?.feedbackId ?? 0,
        images: rxListImagePath,
        rating: rxListRating[0],
        content: ratingControllers.text,
        priceId: rxFeedback.value?.priceId ?? 0,
      );
      hideDialog();
      while (Get.currentRoute != RouterName.home) {
        Get.back();
      }
    } catch (e) {
      hideDialog();
      print(e.toString());
    }
  }
}
