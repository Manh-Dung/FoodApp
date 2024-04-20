import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ints/models/favorite/favorite.dart';
import 'package:ints/x_utils/widgets/my_loading_image.dart';

import '../../../x_res/my_config.dart';

class FavoriteShopItem extends StatelessWidget {
  final Favorite favorite;
  final Function unlikeShopFunction;
  final Function likeShopFunction;
  final Function seeDetailStore;
  final bool isBeingEdited;

  FavoriteShopItem({
    super.key,
    required this.unlikeShopFunction,
    required this.favorite,
    required this.likeShopFunction,
    required this.seeDetailStore,
    required this.isBeingEdited,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => seeDetailStore(),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
        width: Get.width,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                MyLoadingImage(
                  imageUrl: favorite.store?.image?.length == 0
                      ? "https://picsum.photos/200/300"
                      : favorite.store?.image?[0].path ?? "",
                  size: 40,
                  isCircle: true,
                ),
                const SizedBox(width: 10),
                Text(favorite.store?.name ?? "Cửa hàng",
                    style: TextStyle(
                        color: MyColor.TEXT_COLOR,
                        fontSize: 12,
                        fontWeight: FontWeight.w400))
              ],
            ),
            Container(
              width: 80,
              child: OutlinedButton(
                onPressed: () =>
                    isBeingEdited ? unlikeShopFunction() : likeShopFunction(),
                child: Text(
                  isBeingEdited ? "Đã thích" : "Yêu thích",
                  style: TextStyle(
                      color:
                          isBeingEdited ? MyColor.PRIMARY_COLOR : MyColor.white,
                      fontSize: 12,
                      fontWeight: FontWeight.w500),
                ),
                style: OutlinedButton.styleFrom(
                    minimumSize: Size(0, 0),
                    backgroundColor:
                        isBeingEdited ? MyColor.white : MyColor.PRIMARY_COLOR,
                    side: isBeingEdited
                        ? BorderSide(color: MyColor.PRIMARY_COLOR)
                        : BorderSide.none,
                    padding:
                        const EdgeInsets.symmetric(vertical: 8, horizontal: 0),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8))),
              ),
            )
          ],
        ),
      ),
    );
  }
}
