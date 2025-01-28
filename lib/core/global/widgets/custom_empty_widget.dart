import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import '/core/theme/app_color.dart';
import '/core/theme/text_style.dart';
import '/core/utils/assets_data.dart';

class CustomEmptyWidget extends StatelessWidget {
  const CustomEmptyWidget({
    super.key,
    this.height,
  });
  final double? height;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          alignment: Alignment.center,
          height: height ?? 0.25.sh,
          child: Lottie.asset(
            AssetsData.noDataAnimation,
            repeat: false,
          ),
        ),
        Text(
          Get.locale?.languageCode == 'ar' ? 'لا يوجد بيانات' : 'No Data',
          style: getMediumStyle.copyWith(
            color: blackWithOpacityColor,
            fontSize: 16.sp,
          ),
        ),
      ],
    );
  }
}
