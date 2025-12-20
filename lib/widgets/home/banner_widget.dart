import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class BannerWidget extends StatelessWidget {
  const BannerWidget(
      {super.key,
      required this.image,
      required this.onPressed,
      required this.imageAr});
  final String image;
  final String imageAr;

  final void Function() onPressed;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 6.w),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(6.r),
        ),
        height: context.isTablet ? 260.h : 240.h,
        width: double.infinity,
        child: Stack(
          children: [
            ClipRRect(
                borderRadius: BorderRadius.circular(6.r),
                child: Image.asset(
                  Get.locale?.languageCode == "en" ? image : imageAr,
                  fit: BoxFit.fitWidth,
                  //   height: context.isTablet ? 250 : 200.h,
                  width: double.infinity,
                )),
          ],
        ),
      ),
    );
  }
}
