import 'package:flutter/cupertino.dart';
import 'package:ints/base/base_controller.dart';
import 'package:ints/views/app/app_controller.dart';
import 'package:ints/views/cart/cart_binding.dart';
import 'package:ints/views/home/home_binding.dart';

import '../../models/address/address.dart';
import '../../models/cart/cart.dart';

class CheckoutBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => CheckoutController());
    Get.lazyPut(() => CartController());
    Get.lazyPut(() => HomeController());
  }
}

class CheckoutController extends BaseController {
  final homeController = Get.find<HomeController>();
  final cartController = Get.find<CartController>();
  AppController appController = Get.find();
  Rxn<Address> rxDefaultAddress = Rxn();
  RxList<Cart> rxReceivedListCart = RxList();
  RxList<Cart> rxListCart = RxList();
  RxList<CartItems> rxListCartItem = RxList();
  Rxn<Cart> rxOrderItem = Rxn();

  RxList<num> rxListCartItemId = RxList();
  final TextEditingController noteController = TextEditingController();
  RxNum rxTotalAmount = RxNum(0);
  RxNum rxTotalOrderPrice = RxNum(0);
  bool isBuyNowSelection = false;
  RxList<num> rxListCartId = RxList();
  Rxn<CartItems> rxCartItem = Rxn();
  final TextEditingController pointController =
      TextEditingController(text: "0");

  void onInit() {
    super.onInit();

    var address = Get.arguments["addressDefault"];
    var listCart = Get.arguments["listCart"];
    var listCartItem = Get.arguments["listCartItem"];

    var orderItem = Get.arguments["orderItem"];

    if (address != null) {
      rxDefaultAddress.value = address;
    }

    if (listCartItem != null) {
      rxListCartItem.value = listCartItem;
    }

    if (listCart != null) {
      rxReceivedListCart.value = listCart;
    }
    if (orderItem != null) {
      rxOrderItem.value = orderItem;
      isBuyNowSelection = true;
      rxTotalOrderPrice.value =
          (rxOrderItem.value?.cartItems?[0].priceAtPurchase ?? 0) *
              (rxOrderItem.value?.cartItems![0].quantity ?? 0);

      rxListCartId.add(rxOrderItem.value?.cartItems![0].id ?? 0);
    }

    for (var i in rxListCartItem) {
      rxListCartItemId.add(i.id ?? 0);
    }
  }

  @override
  void onReady() {
    super.onReady();
    getCartItemById(rxListCartId[0]).then((res) {
      rxCartItem.value = res;
    });
  }

  Future<void> checkout(
      {required num addressId,
      required String note,
      required List<num> listCartId,
      required num point}) async {
    showLoadingDialog();
    try {
      await orderRepositories.postOrder(
          addressId: addressId,
          note: note,
          listCartId: listCartId,
          point: point);
      hideDialog();
      handleSuccessStringShowToast(message: "Thanh toán thành công");

      await homeController.getCarts().then((value) {
        homeController.rxCartCount.value = value.data?.length ?? 0;
        cartController.rxListCart.value = value.data ?? [];
      });

      await appController.getUserInfor();

      Get.toNamed(RouterName.successful_order);
    } catch (e) {
      handleErr(e);
      hideDialog();
      throw Exception('Failed to post order');
    }
  }

  Future<CartItems> getCartItemById(num cartItemId) async {
    try {
      var res = await cartRepositories.getCartItemById(id: cartItemId);
      return res;
    } catch (e) {
      print(e.toString());
      throw e;
    }
  }

  Future<void> deleteCartItem(num cartItemId) async {
    showLoadingDialog();
    try {
      await cartRepositories.deleteCartItem(id: cartItemId);
      cartController.update();
      hideDialog();
    } catch (e) {
      hideDialog();
      handleErr(e);
      throw Exception('Failed to delete cart item');
    }
  }

  Future<void> checkoutBuyNow(
      {required num addressId,
      required num point,
      required String note,
      required List<num> listCartId}) async {
    showLoadingDialog();
    try {
      await orderRepositories.postOrder(
          addressId: addressId,
          note: note,
          listCartId: listCartId,
          point: point);
      hideDialog();
      handleSuccessStringShowToast(message: "Thanh toán thành công");

      homeController.getCarts().then((value) =>
          homeController.rxCartCount.value = value.data?.length ?? 0);
      Get.toNamed(RouterName.successful_order);
    } catch (e) {
      handleErr(e);
      hideDialog();
      throw Exception('Failed to post order');
    }
  }

  num get totalPrice {
    num sum = 0;
    for (var i in rxListCartItem) {
      sum += (i.priceAtPurchase ?? 0) * (i.quantity ?? 0);
    }
    return sum;
  }
}
