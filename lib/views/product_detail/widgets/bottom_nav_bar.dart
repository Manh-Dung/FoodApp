import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:ints/models/product/product_option.dart';

import 'package:ints/views/product_detail/widgets/order_product_bottom_bar.dart';

import '../../../models/product/product.dart';
import '../../../x_res/my_config.dart';
import '../../../x_res/x_r.dart';
import '../../../x_routes/router_name.dart';
import '../../../x_utils/get_storage_util.dart';
import '../../app/app_controller.dart';

class BottomNavBar extends StatelessWidget {
  final Product? product;
  final List<ProductOption> productOption;
  final TextEditingController quantityController;
  final Function(String tag, num priceId) onTap;
  final AppController appController = Get.find();

  BottomNavBar({
    super.key,
    required this.product,
    required this.quantityController,
    required this.onTap,
    required this.productOption,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(vertical: 2),
      decoration: BoxDecoration(
        color: Colors.white,
      ),
      child: IntrinsicHeight(
        child: Container(
          child: IntrinsicHeight(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  flex: 1,
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 8, horizontal: 5),
                    decoration: BoxDecoration(color: Color(0xFF7CCEF9)),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SvgPicture.asset(
                          XR().svgImage.ic_chat,
                          colorFilter:
                              ColorFilter.mode(Colors.white, BlendMode.srcIn),
                        ),
                        const SizedBox(height: 5),
                        Text(
                          'Nhắn tin',
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: InkWell(
                    onTap: () {
                      if (appController.isLogin.value == false) {
                        Get.toNamed(RouterName.login);
                      } else {
                        showModalBottomSheet(
                          context: Get.context!,
                          builder: (BuildContext buildContext) {
                            return OrderProductBottomBar(
                              tag: "Thêm vào giỏ hàng",
                              onTap: (tag, priceId) => onTap(tag, priceId),
                              product: product,
                              quantityController: quantityController,
                            );
                          },
                          isScrollControlled: true,
                          constraints: BoxConstraints(
                            maxHeight: Get.height * 0.7,
                          ),
                        );
                      }
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(vertical: 9, horizontal: 3),
                      decoration: BoxDecoration(color: Color(0xFFF89402)),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          SvgPicture.asset(XR().svgImage.ic_cart_product),
                          const SizedBox(height: 5),
                          Text(
                            'Thêm vào giỏ hàng',
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Expanded(
                  flex: 3,
                  child: InkWell(
                    onTap: () {
                      if (appController.isLogin.value == false) {
                        Get.toNamed(RouterName.login);
                      } else {
                        showModalBottomSheet(
                          context: Get.context!,
                          builder: (BuildContext buildContext) {
                            return OrderProductBottomBar(
                              tag: "Mua ngay",
                              onTap: (tag, priceId) => onTap(tag, priceId),
                              product: product,
                              quantityController: quantityController,
                            );
                          },
                          showDragHandle: false,
                          isScrollControlled: true,
                          constraints: BoxConstraints(
                            maxHeight: Get.height * 0.7,
                          ),
                        );
                      }
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 20, horizontal: 10),
                      decoration: BoxDecoration(
                        color: MyColor.PRIMARY_COLOR,
                      ),
                      child: Text(
                        'Mua ngay',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
