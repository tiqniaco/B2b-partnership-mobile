import 'package:b2b_partenership/core/theme/app_color.dart';
import 'package:b2b_partenership/core/theme/text_style.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

Widget titleWidget(String title) {
  return Text(
    title,
    style: getRegularStyle(Get.context!).copyWith(
      color: Colors.black54,
    ),
  );
}

Widget valueWidget(String value) {
  return Text(
    value,
    style: getRegularStyle(Get.context!).copyWith(
      color: blackColor,
      fontWeight: FontWeight.w500,
    ),
    maxLines: 2,
    overflow: TextOverflow.ellipsis,
  );
}
