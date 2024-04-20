import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ints/x_utils/widgets/my_loading_image.dart';

import '../../../base/base_view_view_model.dart';

class FeedbackRatingWidget extends StatelessWidget {
  final Function(double) onRatingUpdate;
  final String status;
  final TextEditingController controller;
  final List<String?> listImage;
  final Function() onPickImage;
  final Function(int index) onRemoveImage;
  final double rating;

  const FeedbackRatingWidget({
    super.key,
    required this.onRatingUpdate,
    required this.status,
    required this.controller,
    required this.listImage,
    required this.onPickImage,
    required this.onRemoveImage,
    required this.rating,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          _rating(),
          const SizedBox(height: 16),
          (listImage.every((element) => element == null)) ? _pickImageWidget() : _imageGridView(),
          const SizedBox(height: 18),
          _textField(),
        ],
      ),
    );
  }

  Widget _rating() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text("Chất lượng sản phẩm:",
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w400,
              color: Colors.black,
            )),
        const SizedBox(width: 8),
        RatingBar.builder(
          initialRating: rating,
          minRating: 1,
          direction: Axis.horizontal,
          allowHalfRating: false,
          itemCount: 5,
          itemSize: 24,
          itemPadding: const EdgeInsets.symmetric(horizontal: 4),
          itemBuilder: (context, _) => SvgPicture.asset(
            XR().svgImage.ic_star,
          ),
          onRatingUpdate: (value) {
            onRatingUpdate(value);
          },
        ),
        const SizedBox(width: 15),
        Text(status,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w400,
              color: MyColor.TEXT_COLOR_NEW,
            )),
      ],
    );
  }

  Widget _pickImageWidget() {
    return InkWell(
      onTap: () {
        onPickImage();
      },
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: MyColor.PRIMARY_COLOR, width: 1),
          borderRadius: BorderRadius.circular(8),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 9),
        child: Column(
          children: [
            SvgPicture.asset(XR().svgImage.ic_camera),
            const SizedBox(height: 8),
            Text(
              "Thêm hình ảnh",
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w400,
                color: MyColor.PRIMARY_COLOR,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _textField() {
    return TextField(
      controller: controller,
      cursorColor: MyColor.BORDER_COLOR,
      maxLines: 5,
      maxLength: 255,
      // Thêm maxLength để giới hạn số ký tự
      maxLengthEnforcement: MaxLengthEnforcement.enforced,
      // Bắt buộc giới hạn
      style: TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.w400,
        color: MyColor.BORDER_COLOR,
      ),
      decoration: InputDecoration(
        hintText: "Hãy viết đánh giá về sản phẩm này bạn nhé!",
        hintStyle: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w400,
          color: MyColor.BORDER_COLOR,
        ),
        contentPadding: const EdgeInsets.all(16),
        constraints: BoxConstraints(
          maxHeight: 130,
        ),
        fillColor: MyColor.BACKGROUND_COLOR,
        filled: true,
        focusColor: MyColor.TEXT_COLOR_NEW,
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: MyColor.BORDER_COLOR, width: 1),
          borderRadius: BorderRadius.circular(8),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: MyColor.BORDER_COLOR, width: 1),
          borderRadius: BorderRadius.circular(8),
        ),
        errorBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.red, width: 1),
          borderRadius: BorderRadius.circular(8),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.red, width: 1),
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    );
  }

  Widget _imageWidget({required String image, required int index}) {
    return ConstrainedBox(
      constraints: BoxConstraints(
        maxHeight: 124,
        maxWidth: 124,
      ),
      child: Stack(
        children: [
          MyLoadingImage(
            imageUrl: image,
            size: 124,
            borderRadius: 8,
          ),
          Positioned(
            right: 10,
            top: 10,
            child: InkWell(
              onTap: () {
                onRemoveImage(index);
              },
              child: Icon(Icons.close, color: MyColor.white, size: 16),
            ),
          ),
        ],
      ),
    );
  }

  Widget _emptyImageWidget() {
    return InkWell(
      onTap: () {
        onPickImage();
      },
      child: ConstrainedBox(
        constraints: BoxConstraints(
          maxHeight: 124,
          maxWidth: 124,
        ),
        child: DottedBorder(
          color: MyColor.BORDER_COLOR,
          borderType: BorderType.RRect,
          radius: Radius.circular(5),
          stackFit: StackFit.expand,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SvgPicture.asset(XR().svgImage.ic_camera_grey),
              Text(
                listImage.where((element) => element != null).length.toString() + "/6",
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                  color: MyColor.BORDER_COLOR,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _imageGridView() {
    return GridView.builder(
      shrinkWrap: true,
      itemCount: 6,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        crossAxisSpacing: 13,
        mainAxisSpacing: 13,
        childAspectRatio: 1,
      ),
      itemBuilder: (context, index) {
        return listImage[index] == null
            ? _emptyImageWidget()
            : _imageWidget(image: listImage[index]!, index: index);
      },
    );
  }
}
