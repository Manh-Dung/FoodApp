import 'package:flutter/material.dart';
import 'package:get/get_rx/src/rx_workers/utils/debouncer.dart';
import 'package:ints/base/base_controller.dart';

import '../../base/api_response_paging.dart';
import '../../base/cart_api_response_paging.dart';
import '../../models/address/address.dart';
import '../../models/cart/cart.dart';
import '../../models/product/product.dart';
import '../app/app_controller.dart';

class CartController extends BaseController {
  AppController appController = Get.find();

  RxList<Cart> rxListCart = RxList();
  RxList<CartItems> rxListCartItemSelect = RxList();

  late RxList<bool> rxListShopSelectCheck;
  RxBool rxIsSelectAllShop = RxBool(false);

  RxBool rxIsEditAll = RxBool(false);
  late RxList<bool> rxListShopSelectEdit;
  ScrollController scrollController1 = ScrollController();

  Rxn<Address> rxDefaultAddress = Rxn();
  Debouncer _debouncer = Debouncer(delay: Duration(milliseconds: 1000));
  Rx<bool> rxShimmerLoading = Rx(true);
  RxList<Product> rxListProduct = RxList();
  num page = 1;

  @override
  void onInit() {
    withScrollController = true;
    super.onInit();
  }

  @override
  void onReady() {
    withScrollController = true;
    super.onReady();
    loadingDataCart();

    getProducts(limit: 8, page: page).then((res) {
      rxListProduct.value = res.data ?? [];
      rxShimmerLoading.value = false;
    });
  }

  @override
  onRefresh() async {
    super.onRefresh();
    showLoadingDialog();
    await loadingDataCart();

    await getProducts(limit: 8, page: page).then((res) {
      rxListProduct.value = res.data ?? [];
      rxShimmerLoading.value = false;
    });
    hideDialog();
  }

  @override
  onLoadMore() async {
    super.onLoadMore();
    page++;
    showLoadingDialog();

    await loadingDataCart();
    await getProducts(limit: 8, page: page).then((res) {
      rxListProduct.addAll(res.data ?? []);
    });
    hideDialog();
  }

  loadingDataCart() {
    if (appController.isLogin.value) {
      getCarts().then((res) {
        rxListCart.value = res.data ?? [];
        rxListShopSelectCheck = RxList.filled(rxListCart.length, false);
        rxListShopSelectEdit = RxList.filled(rxListCart.length, false);
      });
    }
  }

  Future<APIResponsePaging<List<Product>>> getProducts(
      {num? limit,
      num? page,
      String? sortBy,
      String? orderBy,
      String? search,
      num? categoryId,
      num? storeId}) async {
    try {
      var res = await productRepositories.getProducts(
          limit: limit,
          page: page,
          sortBy: sortBy,
          orderBy: orderBy,
          search: search,
          categoryId: categoryId,
          storeId: storeId);

      return res;
    } catch (e) {
      handleErr(e);
      throw Exception('Failed to get products');
    }
  }

  num get totalPrice {
    num sum = 0;
    for (CartItems cartItem in rxListCartItemSelect) {
      sum += (cartItem.quantity ?? 0) * (cartItem.priceAtPurchase ?? 0);
    }
    return sum;
  }

  Future<CartAPIResponsePaging<List<Cart>>> getCarts(
      {int? limit,
      int? page,
      String? sortBy,
      String? orderBy,
      String? search}) async {
    try {
      var res = await cartRepositories.getCarts(
          limit: limit,
          page: page,
          sortBy: sortBy,
          orderBy: orderBy,
          search: search);

      return res;
    } catch (e) {
      handleErr(e);
      throw Exception('Failed to get carts');
    }
  }

  void changeQuantity(num? quantity, CartItems? cartItem) {
    _debouncer.call(() {
      updateQuantity(quantity: quantity, cartItem: cartItem);
    });
  }

  Future updateQuantity({num? quantity, CartItems? cartItem}) async {
    try {
      var resCartItem = await cartRepositories.updateQuantity(
          quantity: quantity ?? 1, id: cartItem?.id ?? 0);
      getCarts().then((value) {
        rxListCart.value = value.data ?? [];

        if (rxListCartItemSelect.contains(cartItem)) {
          rxListCartItemSelect[rxListCartItemSelect.indexOf(cartItem)] =
              resCartItem;
        }

        if (rxListCartItemSelect
            .where((element) => element.id == cartItem?.id)
            .isNotEmpty) {
          rxListCartItemSelect[rxListCartItemSelect.indexWhere(
              (element) => element.id == cartItem?.id)] = resCartItem;
        }
      });
    } catch (e) {
      print(e.toString());
      throw e;
    }
  }

  Future<bool> order() async {
    showLoadingDialog();
    try {
      var res = await addressRepositories.getDefaultAddress();
      rxDefaultAddress.value = res;
      hideDialog();

      if (rxListCart.isEmpty) {
        handleErr("Giỏ hàng trống");
        handleErrorStringShowToast(error: "Giỏ hàng trống");
        return false;
      } else {
        if (rxListCartItemSelect.isEmpty) {
          handleErr("Chưa chọn sản phẩm");
          handleErrorStringShowToast(error: "Chưa chọn sản phẩm");
          return false;
        } else {
          if (rxDefaultAddress.value?.id == null) {
            Get.toNamed(RouterName.create_address, arguments: {
              "listCart": rxListCart,
              "listCartItem": rxListCartItemSelect
            });
          } else {
            Get.toNamed(RouterName.checkout, arguments: {
              "addressDefault": rxDefaultAddress.value,
              "listCart": rxListCart,
              "listCartItem": rxListCartItemSelect
            });
          }
        }
      }

      return true;
    } catch (e) {
      hideDialog();
      handleErr(e);
      return false;
    }
  }

  Future<void> deleteCartItem(CartItems? cartItem, int index) async {
    showLoadingDialog();
    try {
      await cartRepositories.deleteCartItem(id: cartItem?.id ?? 0);
      getCarts().then((res) {
        rxListCart.value = res.data ?? [];
        rxListCartItemSelect.remove(cartItem);
        rxListShopSelectCheck = RxList.filled(rxListCart.length, false);
        rxListShopSelectEdit = RxList.filled(rxListCart.length, false);
        onCheckBoxChanged(false, cartItem, index);
      });
      hideDialog();
    } catch (e) {
      hideDialog();
      handleErr(e);
      throw Exception('Failed to delete cart item');
    }
  }

  void showAlertDialog({CartItems? cartItem, required int index}) {
    showGeneralDialog(
        context: Get.context!,
        barrierDismissible: true,
        barrierLabel: "Label",
        transitionDuration: Duration(milliseconds: 200),
        pageBuilder: (_, a1, a2) {
          return _dialog(cartItem: cartItem, index: index);
        });
  }

  void onBarCheckBoxChanged(bool value) {
    if (rxListCart.isEmpty) return;

    rxIsSelectAllShop.value = value;
    for (int i = 0; i < rxListCart.length; i++) {
      rxListShopSelectCheck[i] = value;
    }
    if (value) {
      rxListCartItemSelect.clear();
      rxListCart.forEach((e) => rxListCartItemSelect.addAll(e.cartItems ?? []));
    } else {
      rxListCartItemSelect.clear();
    }
  }

  void onShopCheckBoxChanged(bool? value, int index) {
    if (value ?? false) {
      for (var i in rxListCart[index].cartItems ?? []) {
        if (!rxListCartItemSelect.contains(i)) {
          rxListCartItemSelect.add(i);
          onCheckBoxChanged(true, i, index);
        }
      }

      rxListShopSelectCheck[index] = true;
      _updateSelectAllShopStatus(true);
    } else {
      for (var i in rxListCart[index].cartItems ?? []) {
        if (rxListCartItemSelect.contains(i)) {
          rxListCartItemSelect.remove(i);
          onCheckBoxChanged(false, i, index);
        }
      }
      rxListShopSelectCheck[index] = false;
      _updateSelectAllShopStatus(false);
    }
  }

  void onCheckBoxChanged(bool value, CartItems? item, int index) {
    bool isUnSelectAll = false;
    bool isSelectAll = false;

    if (value) {
      rxListCartItemSelect.add(item!);

      if (rxListCart[index]
              .cartItems
              ?.every((element) => rxListCartItemSelect.contains(element)) ??
          false) {
        isSelectAll = true;
      }
      if (isSelectAll) {
        rxListShopSelectCheck[index] = true;
        onShopCheckBoxChanged(true, index);
      } else {
        rxListShopSelectCheck[index] = false;
        rxIsSelectAllShop.value = false;
      }
    } else if (value == false) {
      rxListCartItemSelect.remove(item);

      if (rxListCart[index]
              .cartItems
              ?.every((element) => !rxListCartItemSelect.contains(element)) ??
          false) {
        isUnSelectAll = true;
      }
      if (isUnSelectAll) {
        rxListShopSelectCheck[index] = false;
        onShopCheckBoxChanged(false, index);
      } else {
        rxListShopSelectCheck[index] = false;
        rxIsSelectAllShop.value = false;
      }
    }
  }

  void _updateSelectAllShopStatus(bool value) {
    if (value) {
      if (rxListShopSelectCheck.every((element) => element == value)) {
        rxIsSelectAllShop.value = value;
        onBarCheckBoxChanged(value);
      }
    } else {
      if (rxListShopSelectCheck.every((element) => element == value)) {
        rxIsSelectAllShop.value = value;
        onBarCheckBoxChanged(value);
      } else {
        rxIsSelectAllShop.value = value;
      }
    }
  }

  void onBarEditCheck() {
    if (rxListCart.isEmpty) return;
    rxIsEditAll.value = !rxIsEditAll.value;
    for (int i = 0; i < rxListCart.length; i++) {
      rxListShopSelectEdit[i] = rxIsEditAll.value;
    }
  }

  void onShopEdit(int index) {
    rxListShopSelectEdit[index] = !rxListShopSelectEdit[index];
    if (rxListShopSelectEdit.every((element) => true)) {
      rxIsEditAll.value = true;
    } else if (rxListShopSelectEdit.every((element) => false)) {
      rxIsEditAll.value = false;
    } else {
      rxIsEditAll.value = false;
    }
  }

  Widget _dialog({CartItems? cartItem, required int index}) {
    return Dialog(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: Colors.white,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              "Bạn có chắc chắn muốn bỏ sản phẩm này?",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w400,
                color: MyColor.TEXT_COLOR_NEW,
              ),
            ),
            const SizedBox(height: 10),
            IntrinsicHeight(
              child: Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                        onPressed: () {
                          Get.back();
                        },
                        style: OutlinedButton.styleFrom(
                          side: BorderSide(
                            color: MyColor.TEXT_COLOR_NEW,
                            width: 1,
                          ),
                          backgroundColor: Colors.white,
                          minimumSize: Size(0, 40),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        child: Text("Không",
                            style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                                color: MyColor.TEXT_COLOR_NEW))),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: OutlinedButton(
                        onPressed: () {
                          Get.back();
                          deleteCartItem(cartItem, index);
                        },
                        style: OutlinedButton.styleFrom(
                          side: BorderSide(
                            color: MyColor.PRIMARY_COLOR,
                            width: 1,
                          ),
                          backgroundColor: Colors.white,
                          minimumSize: Size(0, 40),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        child: Text("Đồng ý",
                            style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                                color: MyColor.PRIMARY_COLOR))),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
