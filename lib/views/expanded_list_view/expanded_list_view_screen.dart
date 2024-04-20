import 'package:flutter/material.dart';
import 'package:ints/base/base_view_view_model.dart';
import 'package:ints/views/expanded_list_view/expanded_list_view_binding.dart';
import 'package:ints/x_utils/widgets/my_grid_view.dart';

class ExpandedListViewScreen extends BaseView<ExpandedListViewController> {
  @override
  Widget vBuilder() {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(kToolbarHeight),
        child: Container(
          decoration: BoxDecoration(
            color: MyColor.white,
            border: Border(
              bottom: BorderSide(
                color: Colors.grey.shade300,
                width: 1,
              ),
            ),
          ),
          child: AppBar(
            title: Text(
              controller.title ?? '',
              style: TextStyle(
                color: MyColor.black,
                fontSize: 18,
                fontWeight: FontWeight.w700,
              ),
            ),
            centerTitle: true,
            backgroundColor: MyColor.white,
          ),
        ),
      ),
      body: SafeArea(
          child: Container(
              width: double.infinity,
              height: double.infinity,
              color: MyColor.BACKGROUND_COLOR,
              child: SingleChildScrollView(
                child: Obx(() => MyGridView(
                      shimmerLoading: controller.rxShimmerLoading.value,
                      listProduct: controller.rxListProduct,
                      listLength: controller.rxListProduct.length,
                      scrollController: controller.scrollController,
                      paddingVertical: 8,
                      paddingHorizontal: 16,
                    )),
              ))),
    );
  }
}
