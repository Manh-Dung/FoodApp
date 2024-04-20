import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:ints/x_utils/widgets/my_loading_image.dart';

import '../../../base/base_controller.dart';
import '../../../models/cart/cart.dart';
import '../../../x_utils/utilities.dart';

class ItemCartWidget extends StatefulWidget {
  const ItemCartWidget({
    super.key,
    required this.item,
    this.onPressed,
    this.isChecked = false,
    required this.isEdit,
    required this.onCheckBoxChanged,
    required this.onEdit,
  });

  final CartItems? item;
  final bool isChecked;
  final bool isEdit;
  final Function(num?)? onPressed;
  final ValueChanged<bool> onCheckBoxChanged;
  final VoidCallback onEdit;

  @override
  State<ItemCartWidget> createState() => _ItemCartWidgetState();
}

class _ItemCartWidgetState extends State<ItemCartWidget> {
  CartItems? item;

  @override
  void initState() {
    super.initState();
    item = widget.item;
  }

  @override
  void didUpdateWidget(covariant ItemCartWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    item = widget.item;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IntrinsicHeight(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Checkbox(
                    materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    visualDensity: VisualDensity(horizontal: -4, vertical: -4),
                    value: widget.isChecked,
                    activeColor: MyColor.white,
                    checkColor: MyColor.PRIMARY_COLOR,
                    side: MaterialStateBorderSide.resolveWith(
                      (Set<MaterialState> states) {
                        if (states.contains(MaterialState.selected)) {
                          return BorderSide(
                              color: MyColor.CHECKBOX_COLOR, width: 1.0);
                        }
                        return BorderSide(color: Colors.grey, width: 1.0);
                      },
                    ),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(4)),
                    focusColor: Colors.grey,
                    hoverColor: Colors.grey,
                    onChanged: (value) {
                      widget.onCheckBoxChanged(value ?? false);
                    }),
                MyLoadingImage(
                    imageUrl: item?.product?.image?.length == 0
                        ? "https://picsum.photos/200/300"
                        : item?.product?.image?[0].path ?? "",
                    size: 85,
                    borderRadius: 8),
                const SizedBox(width: 8),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      width: 140,
                      child: Text(
                        "${item?.productName}",
                        style: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: 12,
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 140,
                      child: Text(
                        "Loại: ${item?.optionName} - ${item?.optionAttributesName}",
                        style: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: 12,
                        ),
                      ),
                    ),
                    Text(
                      "${Utilities().moneyFormater(item?.priceAtPurchase.toString() ?? "0")}",
                      style: TextStyle(
                          color: MyColor.PRICE_COLOR,
                          fontSize: 16,
                          fontWeight: FontWeight.w600),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    _buttons(),
                  ],
                )
              ],
            ),
          ),
          widget.isEdit ? _editWidget() : Container(),
        ],
      ),
    );
  }

  Container _buttons() {
    return Container(
        decoration: BoxDecoration(
            border: Border.all(color: MyColor.BORDER_COLOR, width: 1)),
        child: IntrinsicHeight(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: [
              InkWell(
                onTap: () {
                  if (item?.quantity != null && (item?.quantity ?? 0) > 0) {
                    setState(() {
                      item =
                          item?.copyWith(quantity: (item?.quantity ?? 0) - 1);
                    });
                    widget.onPressed?.call(item?.quantity);
                  }
                },
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                  child: SvgPicture.asset(XR().svgImage.ic_sub),
                ),
              ),
              VerticalDivider(width: 1, color: MyColor.BORDER_COLOR),
              Container(
                width: 40,
                child: Text(
                  "${item?.quantity}",
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                      color: MyColor.PRIMARY_COLOR),
                  textAlign: TextAlign.center,
                ),
              ),
              VerticalDivider(width: 1, color: MyColor.BORDER_COLOR),
              InkWell(
                onTap: () {
                  if (item?.quantity != null) {
                    setState(() {
                      item =
                          item?.copyWith(quantity: (item?.quantity ?? 0) + 1);
                    });
                    widget.onPressed?.call(item?.quantity);
                  }
                },
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                  child: SvgPicture.asset(XR().svgImage.ic_add),
                ),
              ),
            ],
          ),
        ));
  }

  Widget _editWidget() {
    return InkWell(
      onTap: widget.onEdit,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 24),
        decoration: BoxDecoration(
          color: MyColor.PRIMARY_COLOR,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Text(
          "Xóa",
          style: TextStyle(
            color: Colors.white,
            fontSize: 12,
            fontWeight: FontWeight.w400,
          ),
        ),
      ),
    );
  }
}
