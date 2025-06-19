import 'package:b2b_partenership/core/theme/app_color.dart';
import 'package:b2b_partenership/core/theme/text_style.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

Widget titleWidget(String title, {IconData? icon}) {
  return Row(
    children: [
      if (icon != null) ...[
        Icon(icon, color: primaryColor, size: 24),
        Gap(4),
      ],
      Text(
        title,
        style: getRegularStyle(Get.context!).copyWith(
          color: blackColor,
          fontWeight: FontWeight.w600,
        ),
      ),
    ],
  );
}

Widget valueWidget(String value) {
  return Text(
    value,
    style: getRegularStyle(Get.context!).copyWith(
      color: blackColor,
      fontWeight: FontWeight.w400,
    ),
    maxLines: 2,
    overflow: TextOverflow.ellipsis,
  );
}
