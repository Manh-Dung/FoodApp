import 'package:ints/base/base_controller.dart';

import '../../models/product/product.dart';

class ExpandedListViewBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ExpandedListViewController());
  }
}

class ExpandedListViewController extends BaseController {
  Rx<bool> rxShimmerLoading = Rx(true);

  final String title = Get.arguments?['title'];
  RxList<Product> rxListProduct = RxList(Get.arguments?['listProduct']);

  @override
  void onInit() {
    withScrollController = true;
    super.onInit();

    rxShimmerLoading.value = false;
  }
}
