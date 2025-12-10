import 'package:b2b_partenership/core/theme/app_color.dart';
import 'package:b2b_partenership/core/theme/text_style.dart';
import 'package:b2b_partenership/core/theme/themes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

Widget boxWidget(IconData icon, Color color, String title, String subTitle,
    void Function() onTap) {
  return InkWell(
    onTap: onTap,
    child: Container(
      alignment: Alignment.center,
      decoration: BoxDecoration(
          color: primaryColor.withAlpha(30), borderRadius: customBorderRadius),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            icon,
            color: primaryColor,
            size: 26.r,
          ),
          Gap(10),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                subTitle,
                style: getMediumStyle(Get.context!)
                    .copyWith(fontWeight: FontWeight.w600, fontSize: 13.r),
              ),
              Text(
                title,
                style: getRegularStyle(Get.context!).copyWith(
                  color: blackColor,
                ),
              ),
            ],
          )
        ],
      ),
    ),
  );
}

Widget rowWidget(
  String data, {
  IconData? icon,
  String? title,
}) {
  return Container(
    padding: const EdgeInsets.all(10.0),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(10.r),
      border: Border.all(
        color: Colors.black12,
      ),
    ),
    child: Row(
      children: [
        icon == null
            ? Text(
                "${title!}: ",
                style: getRegularStyle(Get.context!).copyWith(
                  fontWeight: FontWeight.w400,
                  fontSize: 14.r,
                ),
              )
            : Icon(icon, color: primaryColor, size: 20.r),
        Gap(12),
        Expanded(
            flex: 2,
            child: Text(
              data,
              style: getRegularStyle(Get.context!).copyWith(
                  // fontWeight: FontWeight.w500,
                  color: blackColor),
            ))
      ],
    ),
  );
}

Widget rowWithArrow(IconData icon, String title, void Function() onPressed) {
  return Container(
    padding: const EdgeInsets.all(10.0),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(10.r),
      border: Border.all(
        color: Colors.black12,
      ),
    ),
    child: InkWell(
      onTap: onPressed,
      child: Row(
        children: [
          Icon(
            icon,
            color: primaryColor,
            size: 20.r,
          ),
          Gap(15),
          Text(
            title,
            style: getRegularStyle(Get.context!).copyWith(
              fontWeight: FontWeight.w400,
            ),
          ),
          Spacer(),
          InkWell(
              onTap: onPressed,
              child: Icon(
                Icons.arrow_forward_ios_rounded,
                size: 15.r,
                color: primaryColor,
              ))
        ],
      ),
    ),
  );
}
