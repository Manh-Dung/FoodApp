import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ints/x_res/app_text_style.dart';

class DropdownWidget<T> extends StatelessWidget {
  const DropdownWidget(
      {Key? key,
      required this.items,
      this.value,
      required this.onChange,
      this.leadingIcon,
      this.spaceLeadingIcon,
      this.radius,
      this.buttonWidth,
      this.height,
      this.marginTop,
      this.width,
      this.colorIcon,
      this.colorDropDown,
      this.paddingHint,
      this.styleHint,
      this.borderRadius,
      this.onTab,
      this.itemsWidget,
      required this.isHighLightHint,
      this.showData,
      this.isDisable,
      // required this.validator,
      this.dropDownError,
      required this.title})
      : super(key: key);

  final List<T> items;
  final String? value;
  final ValueChanged<T?> onChange;
  final Widget? leadingIcon;
  final double? spaceLeadingIcon;
  final double? radius;
  final double? buttonWidth;
  final double? height;
  final double? marginTop;
  final double? width;
  final Color? colorIcon;
  final Color? colorDropDown;
  final EdgeInsetsGeometry? paddingHint;
  final TextStyle? styleHint;
  final VoidCallback? onTab;
  final bool isHighLightHint;
  final BorderRadius? borderRadius;
  final List<DropdownMenuItem<T>>? itemsWidget;
  final String Function(T)? showData;
  final bool? isDisable;
  final String title;
  // final String? Function(T? value) validator;
  final String? dropDownError;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 8.0, right: 8.0),
      child: Column(
        children: [
          Row(
            children: [
              Text(title),
              Text(
                "*",
                style: TextStyle(color: Colors.red),
              )
            ],
          ),
          SizedBox(
            height: 10,
          ),
          Container(
            height: 45,
            decoration: BoxDecoration(
                border: Border.all(color: Colors.grey, width: 1.0),
                borderRadius: BorderRadius.circular(10)),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 0),
              child: InkWell(
                onTap: onTab,
                child: Container(
                  //margin: EdgeInsets.only(top: marginTop ?? 0),
                  height: height ?? 52.h,
                  width: width,
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton2<T>(
                        isExpanded: true,
                        hint: Container(
                          padding: paddingHint ?? EdgeInsets.only(bottom: 2),
                          child: Text(
                            value ?? '',
                            overflow: TextOverflow.ellipsis,
                            style: AppTextStyle.blackS14,
                          ),
                        ),
                        items: itemsWidget ??
                            items
                                .map(
                                  (item) => DropdownMenuItem<T>(
                                    value: item,
                                    child: Row(
                                      children: [
                                        leadingIcon ?? SizedBox(),
                                        SizedBox(
                                          width: spaceLeadingIcon ?? 0,
                                        ),
                                        Text(
                                          showData?.call(item) ?? '',
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ],
                                    ),
                                  ),
                                )
                                .toList(),
                        // dropdownMaxHeight: 300.h,
                        onChanged: (T? value) {

                          onChange.call(value);

                        },
                        dropdownStyleData: DropdownStyleData(
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Colors.grey,
                              width: 1.0,
                            ),
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        menuItemStyleData: MenuItemStyleData(),
                        iconStyleData: IconStyleData(
                          icon: Icon(
                            Icons.keyboard_arrow_down,
                            color: colorIcon ?? Colors.white,
                          ),
                        )
                        // icon: Icon(
                        //   Icons.keyboard_arrow_down,
                        //   color: colorIcon ?? Colors.white,
                        // ),
                        // iconSize: 24.r,
                        // buttonHeight: height,
                        // buttonWidth: buttonWidth,
                        // buttonPadding: const EdgeInsets.only(right: 4).r,
                        // buttonDecoration: BoxDecoration(
                        //     color: isDisable ?? false
                        //         ? Colors.grey.withOpacity(0.2)
                        //         : Colors.white.withOpacity(0.2),
                        //     border: Border.all(color: MyColor.COLOR_STOKE),
                        //     borderRadius: borderRadius ??
                        //         BorderRadius.all(Radius.circular(radius ?? 16).w)),
                        // itemHeight: 40.h,
                        // itemPadding: const EdgeInsets.only(left: 15, right: 15).r,
                        // dropdownDecoration: BoxDecoration(
                        //   borderRadius: BorderRadius.circular(15).w,
                        //   color: colorDropDown ?? Colors.white,
                        // ),
                        // dropdownElevation: 0,
                        // scrollbarRadius: const Radius.circular(40).w,
                        // scrollbarThickness: 6,
                        // scrollbarAlwaysShow: true,
                        ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
