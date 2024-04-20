import 'package:flutter/material.dart';
import 'package:ints/base/api_response_paging.dart';
import 'package:ints/base/base_controller.dart';
import 'package:ints/models/address/address.dart';
import 'package:ints/models/store/store.dart';

import '../../models/product/product.dart';

class NearByProductBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => NearByProductController());
  }
}

class NearByProductController extends BaseController {
  ScrollController scrollCtrl = ScrollController();
  RxList<Product> rxListNearByProduct = RxList();
  String defaultAddress = '';
  @override
  void onInit() {
    withScrollController = true;

    super.onInit();
    getNearByStore().then((res) {
      var stores = (res.data ?? [])
          .where((store) => store.product?.isNotEmpty ?? false)
          .toList();

      for (var store in stores) {
        var products = store.product!;
        int count = 0;
        for (var product in products) {
          if (count < 2) {
            rxListNearByProduct.add(product);
            count++;
          } else {
            break;
          }
        }
      }
      update();
    });

    getDefaultAddress().then((value) {
      defaultAddress = value.ward != '0'
          ? '${value.addressDetail}, ${value.ward}, ${value.district}, ${value.province}'
          : '${value.addressDetail}, ${value.district}, ${value.province}';
    });
  }

  @override
  onRefresh() async {
    super.onRefresh();
    rxListNearByProduct.clear();
    showLoadingDialog();
    getNearByStore().then((res) {
      var stores = (res.data ?? [])
          .where((store) => store.product?.isNotEmpty ?? false)
          .toList();

      for (var store in stores) {
        var products = store.product!;
        int count = 0;
        for (var product in products) {
          if (count < 2) {
            rxListNearByProduct.add(product);
            count++;
          } else {
            break;
          }
        }
      }
      update();
      hideDialog();
    });
  }

  Future<APIResponsePaging<List<Store>>> getNearByStore(
      {num? limit,
      num? page,
      num? sortBy,
      num? orderBy,
      String? search}) async {
    try {
      var res = await storeRepositories.getNearByStores(
          limit: limit,
          page: page,
          sortBy: sortBy,
          orderBy: orderBy,
          search: search);

      return res;
    } catch (e) {
      throw Exception('Failed to get nearby stores');
    }
  }

  Future<Address> getDefaultAddress() async {
    try {
      return addressRepositories.getDefaultAddress();
    } catch (e) {
      throw Exception('Failed to get default address');
    }
  }
}
