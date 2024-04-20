import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ints/base/base_controller.dart';
import 'package:ints/models/product/attribute_price.dart';
import 'package:ints/models/product/product_option.dart' as product_option;
import 'package:ints/models/product/product_option_attribute.dart';
import 'package:ints/views/product_detail/product_detail_binding.dart';
import 'package:ints/x_utils/utilities.dart';

import '../../../models/product/product.dart';
import '../../../x_utils/widgets/my_loading_image.dart';

class OrderProductBottomBar extends StatefulWidget {
  final Product? product;

  final Function(String tag, num priceId) onTap;
  final String tag;
  final TextEditingController quantityController;

  OrderProductBottomBar({
    super.key,
    required this.product,
    required this.onTap,
    required this.tag,
    required this.quantityController,
  });

  @override
  State<OrderProductBottomBar> createState() => _OrderProductBottomBarState();
}

class _OrderProductBottomBarState extends State<OrderProductBottomBar> {
  final productController = Get.find<ProductDetailController>();
  Rxn<AttributePrice> attributePriceValue = Rxn();

  List<ProductOptionAttribute> productOptionAttributeList = [];

  List<bool> isOptionBeingEdited = [];
  List<bool> isOptionAttributeBeingEdited = [];

  double priceAfterDiscount = 0;

  double totalPrice = 0;
  num priceId = 0;

  @override
  void initState() {
    super.initState();
    final productOption = productController.rxProductOption;
    isOptionBeingEdited = List.generate(productOption.length, (_) => false);
  }

  void updateEditOptionStatus(int index) {
    setState(() {
      isOptionBeingEdited =
          List.generate(isOptionBeingEdited.length, (_) => false);
      isOptionBeingEdited[index] = true;
    });
  }

  void updateEditOptionAttributeStatus(int index) {
    setState(() {
      isOptionAttributeBeingEdited =
          List.generate(isOptionAttributeBeingEdited.length, (_) => false);
      isOptionAttributeBeingEdited[index] = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    var totalInventory =
        Utilities().totalInventory(widget.product?.prices ?? []);
    List<int> listMaxMinPrice =
        Utilities().findMaxMinPrice(widget.product?.prices ?? []);
    final productOption = productController.rxProductOption;
    return DraggableScrollableSheet(
      initialChildSize: 1,
      minChildSize: 0.1,
      maxChildSize: 1,
      expand: true,
      builder: (context, scrollController) {
        return Container(
          width: double.infinity,
          child: Stack(children: [
            ListView(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 16, horizontal: 16),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              MyLoadingImage(
                                imageUrl: widget.product?.image?.length == 0
                                    ? "https://picsum.photos/200/300"
                                    : widget.product?.image?[0].path ?? "",
                                size: 130,
                                borderRadius: 4,
                              ),
                              const SizedBox(width: 10),
                              attributePriceValue.value == null
                                  ? Column(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        SizedBox(
                                          width: 150,
                                          child: Text(
                                            Utilities().moneyFormater(widget
                                                        .product
                                                        ?.prices?[
                                                            listMaxMinPrice[0]]
                                                        .price) !=
                                                    Utilities().moneyFormater(widget
                                                        .product
                                                        ?.prices?[
                                                            listMaxMinPrice[1]]
                                                        .price)
                                                ? Utilities().moneyFormater(widget
                                                        .product
                                                        ?.prices?[
                                                            listMaxMinPrice[0]]
                                                        .price) +
                                                    " - " +
                                                    Utilities().moneyFormater(widget
                                                        .product
                                                        ?.prices?[
                                                            listMaxMinPrice[1]]
                                                        .price)
                                                : Utilities().moneyFormater(widget
                                                    .product
                                                    ?.prices?[listMaxMinPrice[0]]
                                                    .price),
                                            style: TextStyle(
                                              fontSize: 16,
                                              color: MyColor.PRICE_COLOR,
                                              fontWeight: FontWeight.w600,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ),
                                        ),
                                        const SizedBox(height: 4),
                                        Text(
                                          "Hiện còn " +
                                              (totalInventory.toString()) +
                                              " sản phẩm",
                                          style: TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.w400,
                                            color: MyColor.TEXT_COLOR_NEW,
                                          ),
                                        ),
                                      ],
                                    )
                                  : Column(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          Utilities().moneyFormater(
                                              priceAfterDiscount.toString()),
                                          style: TextStyle(
                                              fontSize: 16,
                                              color: MyColor.PRICE_COLOR,
                                              fontWeight: FontWeight.w600),
                                        ),
                                        const SizedBox(height: 4),
                                        Text(
                                          "Hiện còn " +
                                              (attributePriceValue
                                                  .value!.inventory
                                                  .toString()) +
                                              " sản phẩm",
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
                          InkWell(
                              onTap: () {
                                Get.back();
                              },
                              child: SvgPicture.asset(XR().svgImage.ic_x)),
                        ],
                      ),
                    ),
                    Divider(height: 1, color: MyColor.DIVIDER_COLOR),
                    // -----
                    Column(
                      children: [
                        Container(
                          padding: const EdgeInsets.only(
                              top: 16, bottom: 8, left: 16, right: 16),
                          child: GridView.builder(
                            padding: EdgeInsets.all(0),
                            shrinkWrap: true,
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              crossAxisSpacing: 20,
                              mainAxisSpacing: 8,
                              childAspectRatio: 4.2,
                            ),
                            itemCount: productOption.length,
                            itemBuilder: (BuildContext context, int index) {
                              return GridOptionItem(
                                productOption: productOption[index],
                                isOptionBeingEdited: isOptionBeingEdited[index],
                                onTap: () {
                                  updateEditOptionStatus(index);
                                  productController
                                      .getProductOptionAttributeByOptionId(
                                          optionId:
                                              productOption[index].id ?? 0)
                                      .then((res) {
                                    setState(() {
                                      productOptionAttributeList = res;
                                      isOptionAttributeBeingEdited =
                                          List.generate(
                                              productOptionAttributeList.length,
                                              (_) => false);
                                    });
                                    setState(() {
                                      totalPrice = priceAfterDiscount;
                                      widget.quantityController.text = '1';
                                    });
                                  });
                                },
                              );
                            },
                          ),
                        ),
                        Divider(height: 1, color: MyColor.DIVIDER_COLOR),

                        // Option Attribute
                        Container(
                          padding:
                              EdgeInsets.only(left: 16, right: 16, top: 16),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Size',
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w400,
                                    fontSize: 12),
                              ),
                              const SizedBox(height: 6),
                              Container(
                                child: GridView.builder(
                                  shrinkWrap: true,
                                  gridDelegate:
                                      SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 4,
                                    crossAxisSpacing: 20,
                                    mainAxisSpacing: 8,
                                    childAspectRatio: 1.2,
                                  ),
                                  itemCount: productOptionAttributeList.length,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    return GridOptionAttributeItem(
                                      isOptionAttributeBeingEdited:
                                          isOptionAttributeBeingEdited[index],
                                      onTap: () {
                                        updateEditOptionAttributeStatus(index);
                                        productController
                                            .getProductOptionAttributePrice(
                                                optionAttributeId:
                                                    productOptionAttributeList[
                                                                index]
                                                            .id ??
                                                        0)
                                            .then((value) {
                                          setState(() {
                                            attributePriceValue.value = value;
                                            priceAfterDiscount = double.parse(
                                                    attributePriceValue
                                                            .value!.price ??
                                                        '') -
                                                double.parse(attributePriceValue
                                                        .value!.discount ??
                                                    '');
                                            totalPrice = priceAfterDiscount;
                                          });
                                        });
                                        setState(() {
                                          priceId =
                                              productOptionAttributeList[index]
                                                      .priceId ??
                                                  0;
                                          widget.quantityController.text = '1';
                                        });
                                      },
                                      attributeName:
                                          productOptionAttributeList[index]
                                                  .name ??
                                              '',
                                    );
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    Divider(height: 1, color: MyColor.DIVIDER_COLOR),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 8, horizontal: 16),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text("Số lượng",
                              style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w400,
                                  color: Colors.black)),
                          _changeQuantity(totalInventory: totalInventory),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
            Positioned(
                bottom: 0,
                child: Container(
                  width: Get.width,
                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                          color: Colors.grey.shade300,
                          spreadRadius: 1,
                          blurRadius: 5,
                          offset: Offset(0, -3)),
                    ],
                  ),
                  child: _button(),
                ))
          ]),
        );
      },
    );
  }

  Widget _button() {
    return InkWell(
        onTap: widget.quantityController.text != '0'
            ? () {
                widget.onTap(widget.tag, priceId);
              }
            : null,
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(vertical: 15),
          decoration: BoxDecoration(
            color: widget.quantityController.text != '0'
                ? MyColor.PRIMARY_COLOR
                : MyColor.disabled,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Center(
            child: Text(
              widget.tag,
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w600,
                color: widget.quantityController.text != '0'
                    ? MyColor.TEXT_BUTTON_COLOR
                    : MyColor.BORDER_COLOR,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ));
  }

  Widget _changeQuantity({required num totalInventory}) {
    return Container(
      child: Row(children: [
        InkWell(
          onTap: () {
            onDecrease();
          },
          child: Container(
            decoration:
                BoxDecoration(border: Border.all(color: MyColor.BORDER_COLOR)),
            padding: EdgeInsets.symmetric(vertical: 7, horizontal: 10),
            child: Icon(
              Icons.remove,
              color: Colors.grey,
            ),
          ),
        ),
        SizedBox(
          height: 40,
          child: TextField(
            keyboardType: TextInputType.number,
            controller: widget.quantityController,
            onChanged: (value) {
              if (int.parse(value) > (totalInventory)) {
                widget.quantityController.text = (totalInventory).toString();
              }
            },
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w400,
              color: MyColor.PRIMARY_COLOR,
            ),
            textAlign: TextAlign.center,
            decoration: InputDecoration(
              constraints: BoxConstraints(
                maxWidth: 50,
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(0),
                borderSide: BorderSide(color: MyColor.BORDER_COLOR),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(0),
                borderSide: BorderSide(color: MyColor.BORDER_COLOR),
              ),
              contentPadding: const EdgeInsets.symmetric(
                vertical: 0,
                horizontal: 10,
              ),
            ),
          ),
        ),
        InkWell(
          onTap: () {
            onIncrease(totalInventory: totalInventory);
          },
          child: Container(
            decoration: BoxDecoration(border: Border.all(color: Colors.grey)),
            padding: EdgeInsets.symmetric(vertical: 7, horizontal: 10),
            child: Icon(
              Icons.add,
              color: Colors.grey,
            ),
          ),
        ),
      ]),
    );
  }

  void onDecrease() {
    if (int.parse(widget.quantityController.text) > 1) {
      int num = int.parse(widget.quantityController.text);
      num--;
      widget.quantityController.text = num.toString();
    }
    totalPrice = priceAfterDiscount * num.parse(widget.quantityController.text);
  }

  void onIncrease({required num totalInventory}) {
    if (int.parse(widget.quantityController.text) < (totalInventory)) {
      int num = int.parse(widget.quantityController.text);
      num++;
      widget.quantityController.text = num.toString();
    }
    totalPrice = priceAfterDiscount * num.parse(widget.quantityController.text);
  }
}

class GridOptionItem extends StatelessWidget {
  const GridOptionItem({
    super.key,
    required this.isOptionBeingEdited,
    required this.onTap,
    required this.productOption,
  });

  final Function onTap;
  final bool isOptionBeingEdited;
  final product_option.ProductOption productOption;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onTap();
      },
      child: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(4),
              color: MyColor.INPUT_FORM_COLOR,
              border: isOptionBeingEdited
                  ? Border.all(
                      color: MyColor.PRIMARY_COLOR,
                      width: 1,
                    )
                  : null,
            ),
            width: double.infinity,
            child: IntrinsicHeight(
              child: Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  productOption.image!.length != 0
                      ? Image.network(
                          productOption.image![0].path ?? '',
                          fit: BoxFit.cover,
                          height: 40,
                          width: 40,
                        )
                      : ClipRRect(
                          borderRadius: BorderRadius.circular(4),
                          child: Image.asset(
                            XR().assetsImage.img_logo,
                            fit: BoxFit.cover,
                          ),
                        ),
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(4),
                        color: MyColor.INPUT_FORM_COLOR,
                      ),
                      child: Center(
                        child: Text(
                          productOption.name ?? '',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                              color: MyColor.NAME_COLOR_PRODUCT_CLASSFIACTION),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          if (isOptionBeingEdited)
            Positioned(
              top: 0,
              left: 0,
              child: ClipPath(
                clipper: CustomHalfClipper(),
                child: Container(
                    decoration: BoxDecoration(
                      color: MyColor.PRIMARY_COLOR,
                    ),
                    width: 17,
                    height: 17,
                    child: Container()),
              ),
            ),
          if (isOptionBeingEdited)
            Positioned(
              top: 2,
              left: 2,
              child: Icon(
                Icons.check,
                color: Colors.white,
                size: 6,
              ),
            )
        ],
      ),
    );
  }
}

class GridOptionAttributeItem extends StatelessWidget {
  final Function onTap;
  final String attributeName;
  final bool isOptionAttributeBeingEdited;

  const GridOptionAttributeItem({
    super.key,
    required this.isOptionAttributeBeingEdited,
    required this.onTap,
    required this.attributeName,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onTap();
      },
      child: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(4),
              color: MyColor.INPUT_FORM_COLOR,
              border: isOptionAttributeBeingEdited
                  ? Border.all(
                      color: MyColor.PRIMARY_COLOR,
                      width: 1,
                    )
                  : null,
            ),
            width: double.infinity,
            child: IntrinsicHeight(
              child: Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Expanded(
                    child: Container(
                      height: 40,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(4),
                        color: MyColor.INPUT_FORM_COLOR,
                      ),
                      child: Center(
                        child: Text(
                          attributeName,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                              color: MyColor.NAME_COLOR_PRODUCT_CLASSFIACTION),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          if (isOptionAttributeBeingEdited)
            Positioned(
              top: 0,
              left: 0,
              child: ClipPath(
                clipper: CustomHalfClipper(),
                child: Container(
                    decoration: BoxDecoration(
                      color: MyColor.PRIMARY_COLOR,
                    ),
                    width: 17,
                    height: 17,
                    child: Container()),
              ),
            ),
          if (isOptionAttributeBeingEdited)
            Positioned(
              top: 2,
              left: 2,
              child: Icon(
                Icons.check,
                color: Colors.white,
                size: 6,
              ),
            )
        ],
      ),
    );
  }
}

class CustomHalfClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    path.lineTo(0, size.height);
    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
