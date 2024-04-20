import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ints/base/base_view_view_model.dart';
import 'package:ints/views/home/home_binding.dart';
import 'package:ints/x_utils/widgets/my_loading_image.dart';

import '../../../x_utils/widgets/list_infor.dart';

class AccountPage extends BaseView<HomeController> {
  @override
  Widget vBuilder() => Stack(children: [
        Container(
          color: MyColor.BACKGROUND_COLOR,
        ),
        SingleChildScrollView(
          child: Column(
            children: [
              Container(
                height: 140,
                color: MyColor.PRIMARY_COLOR,
                child: Padding(
                  padding:
                      const EdgeInsets.only(left: 16, right: 16, bottom: 10),
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: Row(
                      children: [
                        Obx(() => MyLoadingImage(
                            isCircle: true,
                            imageUrl: controller.appController.rxUser.value
                                        ?.image?.length ==
                                    0
                                ? "https://picsum.photos/200/300"
                                : controller.appController.rxUser.value
                                        ?.image?[0].path ??
                                    "",
                            size: 60)),
                        const SizedBox(width: 16),
                        Obx(
                          () => Expanded(
                            child: Text(
                              '${controller.appController.rxUser.value?.fullName}',
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  color: Colors.white),
                            ),
                          ),
                        ),
                        Spacer(),
                        InkWell(
                          onTap: () async {
                            var data =
                                await Get.toNamed(RouterName.account_setting);
                            controller.appController.isLogin.value = data;

                            controller.tabController.animateTo(0);
                            controller.currentPage.value = 0;
                          },
                          child: SvgPicture.asset(
                            XR().svgImage.ic_setting_ac,
                            colorFilter:
                                ColorFilter.mode(Colors.white, BlendMode.srcIn),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Container(
                color: Colors.white,
                child: Column(
                  children: [
                    InkWell(
                      onTap: () {
                        Get.toNamed(RouterName.order);
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 20),
                        child: InforAccount(
                          svgPath1: XR().svgImage.ic_history,
                          para: 'Lịch sử mua hàng',
                          count: 1,
                        ),
                      ),
                    ),
                    Divider(height: 1, color: MyColor.DIVIDER_COLOR),
                    InkWell(
                      onTap: () {
                        Get.toNamed(RouterName.wait_for_delivery);
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 20),
                        child: InforAccount(
                          svgPath1: XR().svgImage.ic_truck_svgrepo_com,
                          para: 'Chờ lấy hàng',
                          count: 1,
                        ),
                      ),
                    ),
                    Divider(height: 1, color: MyColor.DIVIDER_COLOR),
                    InkWell(
                      onTap: () {
                        Get.toNamed(RouterName.list_feedback);
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 20),
                        child: InforAccount(
                          svgPath1: XR().svgImage.ic_feedback,
                          para: 'Đánh giá',
                          count: 1,
                        ),
                      ),
                    ),
                    Divider(height: 1, color: MyColor.DIVIDER_COLOR),
                    Container(
                      color: MyColor.white,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 16),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          SvgPicture.asset(XR().svgImage.ic_coin),
                          const SizedBox(width: 4),
                          Text("Coin bạn tích lũy được: ",
                              style: TextStyle(
                                  fontSize: 12, color: MyColor.black)),
                          Obx(() => Flexible(
                                child: Text(
                                    (controller.appController.rxUser.value
                                                ?.point ??
                                            0)
                                        .toString(),
                                    style: TextStyle(
                                        fontSize: 12,
                                        color: Color(0xffFDA018))),
                              )),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ]);
}
