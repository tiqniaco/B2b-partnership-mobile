import 'package:b2b_partenership/core/theme/app_color.dart';
import 'package:b2b_partenership/core/theme/text_style.dart';
import 'package:b2b_partenership/core/theme/themes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class PrintType extends StatelessWidget {
  const PrintType({super.key, required this.type});
  final String type;
  @override
  Widget build(BuildContext context) {
    return switch (type) {
      "pending" => containerType("Pending".tr, Colors.teal),
      "approved" => containerType("Active".tr, orange),
      "completed" => containerType("Complete".tr, green),
      "canceled" => containerType("Checked".tr, redColor),
      "delivered" => containerType("Delivered".tr, Colors.blue),
      _ => containerType(
          "Unknown".tr,
          whiteColor,
        )
    };
  }

  Widget containerType(String title, Color color) {
    return Material(
      color: primaryColor,
      borderRadius: customBorderRadius,
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 4,
        ),
        child: Text(
          title,
          style: getLightStyle(Get.context!).copyWith(
            fontSize: 14.r,
            color: whiteColor,
            fontWeight: FontWeight.w400,
          ),
        ),
      ),
    );
  }
}
