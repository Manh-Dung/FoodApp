import 'package:flutter/material.dart';
import 'package:ints/base/base_controller.dart';
import 'package:ints/models/cart/cart.dart';
import 'package:ints/x_utils/utilities.dart';
import 'package:ints/x_utils/widgets/my_loading_image.dart';

class CheckoutItem extends StatelessWidget {
  final List<Cart> cartList;
  final List<CartItems> cartItemsList;
  final int index;
  final TextEditingController noteController;

  const CheckoutItem(
      {super.key,
      required this.cartList,
      required this.index,
      required this.noteController,
      required this.cartItemsList});

  @override
  Widget build(BuildContext context) {
    return Container(
        color: MyColor.BACKGROUND_COLOR,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _store(),
            Divider(height: 1, color: Colors.grey.shade300),
            _cartItemsListView(cartList, index),
            const SizedBox(height: 4),
          ],
        ));
  }

  Widget _store() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
      width: double.infinity,
      color: Colors.white,
      child: Text(
        cartList[index].store?.name ?? "",
        style: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w400,
          color: Colors.black,
        ),
      ),
    );
  }

  Widget _cartItemsListView(List<Cart> cart, int index) {
    return Container(
      color: Colors.white,
      width: double.infinity,
      child: ListView.builder(
        itemBuilder: (BuildContext context, int itemIndex) {
          var item = cart[index].cartItems?[itemIndex];
          var cartItemIndex =
              cartItemsList.indexWhere((element) => element.id == item?.id);
          return cartItemIndex != -1
              ? _product(cartItemsList[cartItemIndex])
              : Container();
        },
        itemCount: Get.previousRoute == RouterName.product_detail
            ? 1
            : cart[index].cartItems?.length ?? 0,
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
      ),
    );
  }

  Widget _product(CartItems? item) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      child: IntrinsicHeight(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Row(children: [
              MyLoadingImage(
                imageUrl: item?.product?.image?.length == 0
                    ? "https://picsum.photos/200/300"
                    : item?.product?.image?[0].path ?? "",
                size: 85,
                borderRadius: 8,
              ),
              const SizedBox(width: 8),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                mainAxisSize: MainAxisSize.max,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        item?.productName ?? "Tên sản phẩm",
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                          color: Colors.black,
                        ),
                      ),
                      Text(
                        "Loại: " +
                            (item?.optionAttributesName ?? "Loại sản phẩm"),
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w400,
                          color: MyColor.TEXT_COLOR_NEW,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Text(
                        Utilities().moneyFormater(
                            item?.priceAtPurchase.toString() ?? "0"),
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                          color: MyColor.TEXT_COLOR_NEW,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ]),
            Text(
              "x" + (item?.quantity.toString() ?? "0"),
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w400,
                color: MyColor.TEXT_COLOR_NEW,
              ),
            )
          ],
        ),
      ),
    );
  }
}

class CheckoutCart extends StatelessWidget {
  final Cart? orderItem;
  final CartItems? cartItem;
  final TextEditingController noteController;

  const CheckoutCart({
    super.key,
    required this.noteController,
    required this.orderItem,
    this.cartItem,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
        color: MyColor.BACKGROUND_COLOR,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _store(),
            Divider(height: 1, color: Colors.grey.shade300),
            _product(cartItem),
            const SizedBox(height: 4),
          ],
        ));
  }

  Widget _store() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
      width: double.infinity,
      color: Colors.white,
      child: Text(
        orderItem?.store?.name ?? "",
        style: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w400,
          color: Colors.black,
        ),
      ),
    );
  }

  Widget _product(CartItems? cartItem) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      color: MyColor.white,
      child: IntrinsicHeight(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Row(children: [
              FutureBuilder<String>(
                future: fetchImageUrl(cartItem),
                builder:
                    (BuildContext context, AsyncSnapshot<String> snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return CircularProgressIndicator();
                  } else {
                    if (snapshot.hasError || snapshot.data == null) {
                      return ClipRRect(
                        borderRadius: BorderRadius.circular(4),
                        child: Image.asset(
                          XR().assetsImage.img_logo,
                          fit: BoxFit.cover,
                        ),
                      );
                    } else {
                      return Image.network(
                        snapshot.data ?? '',
                        fit: BoxFit.cover,
                        height: 85,
                        width: 85,
                      );
                    }
                  }
                },
              ),
              const SizedBox(width: 8),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                mainAxisSize: MainAxisSize.max,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        cartItem?.productName ?? "Tên sản phẩm",
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                          color: Colors.black,
                        ),
                      ),
                      Text(
                        "Loại: ${cartItem?.optionName} - ${cartItem?.optionAttributesName}",
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w400,
                          color: MyColor.TEXT_COLOR_NEW,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Text(
                        Utilities().moneyFormater(
                            cartItem?.priceAtPurchase.toString() ?? "0"),
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                          color: MyColor.TEXT_COLOR_NEW,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ]),
            Text(
              "x" + (cartItem?.quantity.toString() ?? "0"),
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w400,
                color: MyColor.TEXT_COLOR_NEW,
              ),
            )
          ],
        ),
      ),
    );
  }

  Future<String> fetchImageUrl(CartItems? cartItem) async {
    await Future.delayed(Duration(seconds: 1));
    return cartItem?.product?.image![0].path ?? '';
  }
}
