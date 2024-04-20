import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:ints/x_utils/widgets/my_loading_image.dart';

import '../../../models/store/store.dart';
import '../../../x_res/my_config.dart';
import '../../../x_res/x_r.dart';

class BasicInforStore extends StatelessWidget {
  final Store store;
  final double opacity;
  final Function likeShopFunction;
  final Function unlikeShopFunction;
  final bool isLiked;
  final num totalRating;

  BasicInforStore({
    super.key,
    required this.store,
    required this.opacity,
    required this.likeShopFunction,
    required this.isLiked,
    required this.unlikeShopFunction,
    required this.totalRating,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
        bottom: 0,
        left: 0,
        child: Opacity(
          opacity: opacity,
          child: opacity == 0
              ? Container()
              : Container(
                  padding: const EdgeInsets.only(
                      top: 25, bottom: 8, left: 16, right: 16),
                  width: Get.width,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Row(
                        children: [
                          MyLoadingImage(
                            imageUrl: store.image?.length == 0
                                ? "https://picsum.photos/200/300"
                                : store.image?[0].path ?? "",
                            size: 60,
                            isCircle: true,
                          ),
                          const SizedBox(width: 10),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                store.name ?? "",
                                style: TextStyle(
                                    color: MyColor.white,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600),
                              ),
                              Row(children: [
                                IgnorePointer(
                                  child: RatingBar(
                                    initialRating: totalRating.toDouble(),
                                    direction: Axis.horizontal,
                                    allowHalfRating: false,
                                    itemCount: 5,
                                    itemSize: 16,
                                    ratingWidget: RatingWidget(
                                      full: SvgPicture.asset(
                                          XR().svgImage.ic_colored_star),
                                      half: Image.asset(
                                          XR().assetsImage.img_star_color),
                                      empty: Image.asset(
                                          XR().assetsImage.img_star),
                                    ),
                                    itemPadding: EdgeInsets.zero,
                                    onRatingUpdate: (rating) {},
                                  ),
                                ),
                                const SizedBox(width: 9),
                                Text(
                                  store.rating != null
                                      ? '${store.rating}/5'
                                      : '',
                                  style: TextStyle(
                                      color: MyColor.white,
                                      fontSize: 12,
                                      fontWeight: FontWeight.w400),
                                ),
                              ]),
                              Text(
                                '${store.totalFavorite} Người yêu thích',
                                style: TextStyle(
                                    color: MyColor.white,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w400),
                              ),
                            ],
                          )
                        ],
                      ),
                      Column(
                        children: [
                          isLiked
                              ? Container(
                                  width: 80,
                                  child: OutlinedButton(
                                    onPressed: () => unlikeShopFunction(),
                                    child: Text(
                                      "Đã thích",
                                      style: TextStyle(
                                          color: Color.fromRGBO(34, 161, 33, 1),
                                          fontSize: 12,
                                          fontWeight: FontWeight.w500),
                                    ),
                                    style: OutlinedButton.styleFrom(
                                        minimumSize: Size(0, 0),
                                        backgroundColor: MyColor.white,
                                        side: BorderSide(
                                            color:
                                                Color.fromRGBO(34, 161, 33, 1)),
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 8, horizontal: 0),
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(8))),
                                  ),
                                )
                              : Container(
                                  width: 80,
                                  child: OutlinedButton(
                                    onPressed: () => likeShopFunction(),
                                    child: Text(
                                      "Yêu thích",
                                      style: TextStyle(
                                          color: MyColor.white,
                                          fontSize: 12,
                                          fontWeight: FontWeight.w500),
                                    ),
                                    style: OutlinedButton.styleFrom(
                                        minimumSize: Size(0, 0),
                                        backgroundColor:
                                            Color.fromRGBO(34, 161, 33, 1),
                                        side: BorderSide.none,
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 8, horizontal: 0),
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(8))),
                                  ),
                                ),
                          Container(
                            width: 80,
                            child: OutlinedButton(
                              onPressed: () {},
                              child: Text(
                                "Chat",
                                style: TextStyle(
                                    color: Color.fromRGBO(34, 161, 33, 1),
                                    fontSize: 12,
                                    fontWeight: FontWeight.w500),
                              ),
                              style: OutlinedButton.styleFrom(
                                  minimumSize: Size(0, 0),
                                  foregroundColor: MyColor.white,
                                  side: BorderSide(
                                      color: Color.fromRGBO(34, 161, 33, 1),
                                      width: 1),
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 8, horizontal: 0),
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8))),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
        ));
  }
}
