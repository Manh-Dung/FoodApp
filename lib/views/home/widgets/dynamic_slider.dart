import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:ints/base/base_controller.dart';

import '../../../x_utils/widgets/my_loading_image.dart';

class DynamicSlider extends StatelessWidget {
  final CarouselController carouselController;
  final ValueChanged<int> onChanged;

  final List<String> imageUrls = [
    'https://anhquanbakery.com/uploads/images/banh-mi-nuong-Kaya.jpg',
    'https://anhquanbakery.com/uploads/images/banh-mi-nuong-Kaya.jpg',
  ];

  DynamicSlider({
    required this.carouselController,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
      carouselController: carouselController,
      options: CarouselOptions(
        autoPlay: true,
        autoPlayInterval: Duration(seconds: 5),
        autoPlayCurve: Curves.fastOutSlowIn,
        aspectRatio: 16 / 5,
        enableInfiniteScroll: true,
        autoPlayAnimationDuration: Duration(milliseconds: 800),
        viewportFraction: 1,
        onPageChanged: (index, reason) {
          onChanged(index);
        },
      ),
      items: imageUrls.map((url) {
        return Container(
            height: 140,
            width: double.infinity,
            child: MyLoadingImage(
              borderRadius: 8,
              imageUrl: url,
              size: double.infinity,
              isBanner: true,
            ));
      }).toList(),
    );
  }
}
