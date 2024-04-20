import 'dart:io';

import 'package:flutter/material.dart';
import 'package:ints/x_res/x_r.dart';
import 'package:ints/x_utils/widgets/my_loading_image.dart';

import '../../../models/auth/user.dart';

class AvatarWidget extends StatelessWidget {
  final File? file;
  final VoidCallback onTap;
  final User? user;
  final bool isEdit;

  const AvatarWidget(
      {super.key,
      required this.file,
      required this.onTap,
      required this.user,
      required this.isEdit});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 16),
      child: Center(
        child: Container(
          height: 60,
          width: 60,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
          ),
          child: Stack(
            children: [
              ClipOval(
                  child: file == null
                      ? MyLoadingImage(
                          imageUrl: user?.image?.length == 0
                              ? "https://picsum.photos/200/300"
                              : user?.image?[0].path ?? "",
                          size: 60,
                          isCircle: true,
                        )
                      : Image.file(
                          file!,
                          fit: BoxFit.cover,
                          width: 60,
                          height: 60,
                        )),
              isEdit
                  ? Align(
                      alignment: Alignment.bottomCenter,
                      child: InkWell(
                        onTap: onTap,
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.black.withOpacity(0.5),
                            borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(50),
                              bottomRight: Radius.circular(50),
                            ),
                          ),
                          height: 30,
                          child: Center(
                            child: Text(
                              'Sửa',
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w400,
                                fontSize: 12,
                              ),
                            ),
                          ),
                        ),
                      ),
                    )
                  : SizedBox(),
            ],
          ),
        ),
      ),
    );
  }
}
