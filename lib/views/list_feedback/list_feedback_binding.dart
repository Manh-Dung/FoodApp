import 'package:flutter/material.dart' hide Feedback;

import '../../base/api_response_paging.dart';
import '../../base/base_controller.dart';
import '../../models/feedback/feedback_user.dart';
import '../../models/product/product.dart';
import '../app/app_controller.dart';

class ListFeedbackBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ListFeedbackController());
  }
}

class ListFeedbackController extends BaseController with GetTickerProviderStateMixin {
  late final TabController tabController;
  Rx<bool> rxShimmerLoading = Rx(true);
  RxList<FeedbackUser> rxListFeedBackUser = RxList();
  RxList<FeedbackUser> rxListNoFeedback = RxList();
  RxList<String> rxTabNameList = RxList([
    "Đã đánh giá",
    "Chưa đánh giá",
  ]);

  RxInt rxCount = RxInt(0);
  num pageFeedback = 1;
  num pageNoFeedback = 1;
  ScrollController scrollCtrlNoFeedback = ScrollController();
  bool isLoadMoreNoFeedback = false;

  AppController appController = Get.find();

  @override
  void onInit() {
    withScrollController = true;
    super.onInit();
    tabController = TabController(length: 2, vsync: this);

    scrollCtrlNoFeedback.addListener(() {
      if (scrollCtrlNoFeedback.offset >= scrollCtrlNoFeedback.position.maxScrollExtent &&
          !scrollCtrlNoFeedback.position.outOfRange) {
        if (!isLoadMoreNoFeedback) {
          isLoadMoreNoFeedback = true;
          update();
          onLoadMore();
          isLoadMoreNoFeedback = false;
        }
      }
    });
  }

  @override
  void onReady() {
    super.onReady();

    getFeedBacks(page: pageFeedback).then((res) {
      rxListFeedBackUser.value = res.data ?? [];
      rxShimmerLoading.value = false;
    });

    getNoFeedBacks(page: pageNoFeedback).then((res) {
      rxListNoFeedback.value = res.data ?? [];
      rxCount.value = (res.total ?? 0).toInt();
    });
  }

  @override
  onRefresh() async {
    super.onRefresh();
    showLoadingDialog();
    pageFeedback = 1;
    pageNoFeedback = 1;

    await getFeedBacks(page: pageFeedback).then((res) {
      rxListFeedBackUser.value = res.data ?? [];
      rxShimmerLoading.value = false;
    });

    await getNoFeedBacks(page: pageNoFeedback).then((res) {
      rxListNoFeedback.value = res.data ?? [];
    });
    hideDialog();
  }

  @override
  onLoadMore() async {
    super.onLoadMore();

    showLoadingDialog();

    pageFeedback++;
    pageNoFeedback++;

    await getFeedBacks(page: pageFeedback).then((res) {
      rxListFeedBackUser.addAll(res.data ?? []);
    });

    await getNoFeedBacks(page: pageNoFeedback).then((res) {
      rxListNoFeedback.addAll(res.data ?? []);
    });

    hideDialog();
  }

  @override
  void onClose() {
    tabController.dispose();
    super.onClose();
  }

  Future<APIResponsePaging<List<FeedbackUser>>> getFeedBacks(
      {String? orderBy, String? sortBy, String? search, num? limit, num? page}) async {
    showLoadingDialog();
    try {
      var res = await feedbackRepositories.getFeedbacks(
          orderBy: orderBy, sortBy: sortBy, search: search, limit: limit, page: page);
      hideDialog();
      return res;
    } catch (e) {
      hideDialog();
      handleErr(e);
      throw Exception('Failed to get feedbacks');
    }
  }

  Future<APIResponsePaging<List<FeedbackUser>>> getNoFeedBacks(
      {String? search, num? limit, num? page}) async {
    showLoadingDialog();
    try {
      var res = await feedbackRepositories.getNoFeedbacks(search: search, limit: limit, page: page);
      hideDialog();
      return res;
    } catch (e) {
      hideDialog();
      handleErr(e);
      throw Exception('Failed to get no feedbacks');
    }
  }

  Future<Product> getProductById(num id) async {
    showLoadingDialog();
    try {
      var res = await productRepositories.getProductById(id: id);
      hideDialog();
      return res;
    } catch (e) {
      hideDialog();
      handleErr(e);
      throw Exception('Failed to get product');
    }
  }
}
