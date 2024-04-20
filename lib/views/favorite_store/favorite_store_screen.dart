import 'package:flutter/material.dart';
import 'package:ints/base/base_view_view_model.dart';

import 'favorite_store_binding.dart';
import 'widgets/favorite_shop_item.dart';

class FavoriteStoreScreen extends BaseView<FavoriteStoreController> {
  @override
  Widget vBuilder() {
    controller.scrollController.addListener(() {
      if (controller.scrollController.position.pixels ==
          controller.scrollController.position.maxScrollExtent) {
        controller.loadMoreFavoriteStores();
      }
    });
    return Scaffold(
      appBar: _appBar(),
      body: Obx(() {
        if (controller.rxShimmerLoading.value) {
          return Center(child: CircularProgressIndicator());
        } else {
          return ListView.separated(
            controller: controller.scrollController,
            itemCount: controller.rxListFavoriteStore.length,
            separatorBuilder: (context, index) => Divider(
              color: Color.fromRGBO(217, 217, 217, 1),
              height: 1,
            ),
            itemBuilder: (context, index) {
              return FavoriteShopItem(
                favorite: controller.rxListFavoriteStore[index],
                unlikeShopFunction: () {
                  controller.removeFavoriteStatus(
                      controller.rxListFavoriteStore[index].store?.id ?? 0);
                  controller.updateEditStatus(index);
                },
                likeShopFunction: () {
                  controller.addFavoriteStatus(
                      controller.rxListFavoriteStore[index].store?.id ?? 0);
                  controller.updateEditStatus(index);
                },
                isBeingEdited: controller.isBeingEdited[index],
                seeDetailStore: () async {
                  controller
                      .getStoreById(
                          storeId:
                              controller.rxListFavoriteStore[index].storeId ??
                                  0)
                      .then((value) {
                    Get.toNamed(RouterName.store_detail,
                        arguments: {"store": value});
                  });
                },
              );
            },
          );
        }
      }),
    );
  }

  AppBar _appBar() {
    return AppBar(
      flexibleSpace: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 2,
              blurRadius: 2,
              offset: Offset(0, 1),
            ),
          ],
        ),
      ),
      leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: Icon(
            Icons.arrow_back,
            color: Colors.grey,
          )),
      title: Text(
        "Yêu thích",
        style: TextStyle(
            color: MyColor.TEXT_COLOR_NEW,
            fontSize: 20,
            fontWeight: FontWeight.w700),
      ),
      centerTitle: true,
      backgroundColor: Colors.white,
    );
  }
}
