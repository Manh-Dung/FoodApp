import 'package:flutter/material.dart';
import 'package:ints/base/base_controller.dart';

import '../../x_utils/get_storage_util.dart';

class SearchProductBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => SearchProductController());
  }
}

class SearchProductController extends BaseController {
  final FocusNode focusNode = FocusNode();
  final TextEditingController searchController = TextEditingController();

  RxList rxSearchHistory = RxList();
  Rx<int> itemCount = Rx<int>(4);
  Rx<String> searchListOption = Rx<String>('Xem thêm');

  @override
  void onInit() {
    super.onInit();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      focusNode.requestFocus();
    });

    var searchHistory = ShareStorage.storage.read(MyConfig.SEARCH_HISTORY);
    if (searchHistory != null) {
      rxSearchHistory.value = searchHistory;
    }
  }

  void seeAllSearchHistory() {
    itemCount.value = rxSearchHistory.length;
    searchListOption.value = '';
  }

  Future<void> saveSearchHistory() async {
    List<dynamic>? currentHistory =
        await ShareStorage.storage.read(MyConfig.SEARCH_HISTORY);

    if (currentHistory == null) {
      currentHistory = [];
    }

    List<String> searchHistory = List<String>.from(currentHistory);

    searchHistory.insert(0, searchController.text.trimRight());

    await ShareStorage.storage.write(MyConfig.SEARCH_HISTORY, searchHistory);

    Get.toNamed(RouterName.category_detail, arguments: {
      'searchKey': searchController.text.isEmpty
          ? rxSearchHistory.length > 0
              ? rxSearchHistory.first
              : ""
          : searchController.text.trimRight(),
    });
  }
}
