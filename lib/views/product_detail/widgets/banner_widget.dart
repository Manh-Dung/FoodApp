import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ints/base/base_controller.dart';
import 'package:ints/x_utils/widgets/my_loading_image.dart';

class BannerWidget extends StatelessWidget {
  final int currentBannerIndex;
  final List<String> listBannerImg;
  final CarouselController carouselController;
  final ValueChanged<int> onChanged;

  const BannerWidget(
      {super.key,
      required this.listBannerImg,
      required this.carouselController,
      required this.onChanged,
      required this.currentBannerIndex});

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 350,
        width: Get.width,
        color: Colors.transparent,
        child: Stack(children: [
          Container(
            width: Get.width,
            child: banner(),
          ),
          listBannerImg.length > 0
              ? Padding(
                  padding: const EdgeInsets.only(bottom: 8.0, right: 16),
                  child: Align(
                    alignment: Alignment.bottomRight,
                    child: Container(
                      padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                      decoration: BoxDecoration(
                        color: Color(0xFF171717).withOpacity(0.2),
                        borderRadius: BorderRadius.circular(100),
                      ),
                      child: Text(
                        listBannerImg.length > 0
                            ? "${currentBannerIndex + 1} / ${listBannerImg.length}"
                            : "",
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                )
              : Container(),
        ]));
  }

  Widget banner() {
    return CarouselSlider(
      carouselController: carouselController,
      options: CarouselOptions(
        enlargeCenterPage: true,
        autoPlay: false,
        autoPlayCurve: Curves.fastOutSlowIn,
        autoPlayInterval: Duration(seconds: 5),
        aspectRatio: 9 / 16,
        enableInfiniteScroll: false,
        autoPlayAnimationDuration: Duration(milliseconds: 800),
        viewportFraction: 1,
        reverse: false,
        onPageChanged: (index, reason) {
          onChanged(index);
        },
      ),
      items: listBannerImg.asMap().entries.map((entry) {
        final index = entry.key;
        final uri = entry.value;

        if (index > 1) {
          return Stack(
            children: [
              MyLoadingImage(
                imageUrl: uri,
                size: Get.width,
                isBanner: true,
                borderRadius: 8,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 17.0),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: InkWell(
                    onTap: () {
                      carouselController.animateToPage(0);
                    },
                    child: Container(
                      width: 40,
                      height: 40,
                      padding: EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.2),
                        shape: BoxShape.circle,
                      ),
                      child: Center(
                          child: SvgPicture.asset(
                        XR().svgImage.ic_lager,
                      )),
                    ),
                  ),
                ),
              ),
            ],
          );
        } else {
          return MyLoadingImage(
            imageUrl: uri,
            size: Get.width,
            isBanner: true,
            borderRadius: 8,
          );
        }
      }).toList(),
    );
  }
}
