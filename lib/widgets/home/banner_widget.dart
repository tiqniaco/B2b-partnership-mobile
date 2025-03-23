import 'package:b2b_partenership/core/theme/app_color.dart';
import 'package:b2b_partenership/core/theme/text_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

class BannerWidget extends StatelessWidget {
  const BannerWidget(
      {super.key,
      required this.image,
      required this.title,
      required this.description,
      required this.buttonTitle,
      required this.onPressed});
  final String image;
  final String title;
  final String description;
  final String buttonTitle;
  final void Function() onPressed;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration:
          BoxDecoration(border: Border.all(color: primaryColor, width: 0)),
      height: context.isTablet ? 170.h : 140.h,
      width: double.infinity,
      child: Stack(
        children: [
          ClipRRect(
              child: Image.asset(
            image, // "assets/images/man.jpeg",
            fit: BoxFit.cover,
            width: double.infinity,
          )),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title, //"Need Custom Service?",
                  textAlign: TextAlign.start,
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                    fontSize: context.isTablet ? 12.sp : 16.sp,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                Text(
                  description,
                  // "you can post your custom services",
                  textAlign: TextAlign.start,
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: context.isTablet ? 9.sp : 13.sp,
                      fontWeight: FontWeight.normal),
                ),
                Gap(8.h),
                SizedBox(
                  height: 33.h,
                  width: context.isTablet ? 65.w : 90.w,
                  child: ElevatedButton(
                    style: ButtonStyle(
                      padding: WidgetStatePropertyAll(
                        EdgeInsets.symmetric(
                          horizontal: 10,
                        ),
                      ),
                      backgroundColor: WidgetStatePropertyAll(
                        whiteColor,
                      ),
                      shape: WidgetStatePropertyAll(
                        RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.r)),
                      ),
                    ),
                    onPressed: onPressed,
                    child: Text(
                      buttonTitle,
                      style: getLightStyle(context).copyWith(
                        fontWeight: FontWeight.bold,
                        color: blackColor,
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
