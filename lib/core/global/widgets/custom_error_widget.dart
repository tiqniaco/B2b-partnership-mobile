import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '/core/theme/app_color.dart';
import '/core/theme/text_style.dart';

class CustomErrorWidget extends StatelessWidget {
  const CustomErrorWidget({
    super.key,
    this.message,
  });
  final String? message;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      height: 0.25.sh,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.error,
            size: 100.r,
            color: greyColor,
          ),
          Text(
            message != null
                ? message ?? ''
                : Get.locale?.languageCode == 'ar'
                    ? 'حدث خطأ ما، يرجى المحاولة مرة أخرى'
                    : 'Error occurred, please try again later!',
            style: getMediumStyle(context).copyWith(
              color: blackWithOpacityColor,
            ),
            maxLines: 5,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
