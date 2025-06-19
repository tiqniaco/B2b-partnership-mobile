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
      decoration: BoxDecoration(
        border: Border.all(color: primaryColor, width: 0),
        borderRadius: BorderRadius.circular(10.r),
      ),
      height: context.isTablet ? 200 : 128.h,
      width: double.infinity,
      child: Stack(
        children: [
          ClipRRect(
              borderRadius: BorderRadius.circular(10.r),
              child: Image.asset(
                image,
                fit: BoxFit.cover,
                width: double.infinity,
              )),
          Container(
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(10.r),
                topRight: Radius.circular(10.r),
              ),
              color: Colors.white,
              gradient: LinearGradient(
                begin: Get.locale?.languageCode == "en"
                    ? Alignment.topLeft
                    : Alignment.topRight,
                end: Get.locale?.languageCode == "en"
                    ? Alignment.bottomRight
                    : Alignment.bottomLeft,
                colors: [
                  lightPrimaryColor,
                  lightPrimaryColor.withAlpha(160),
                  whiteColor.withAlpha(50),
                  Colors.transparent,
                  Colors.transparent,
                ],
              ),
            ),
            padding: EdgeInsets.only(
              top: 20,
              bottom: 12,
            ),
          ),
          Container(
            width: double.infinity,
            height: context.isTablet ? 250 : 127.h,
            padding: EdgeInsets.only(
              top: 25,
              bottom: 12,
              right: 16.0,
              left: 16.0,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  title,
                  textAlign: TextAlign.start,
                  style: TextStyle(
                    color: primaryColor,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'PlaypenSans',
                    fontSize: context.isTablet ? 12.r : 16.r,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                Gap(8),
                Text(
                  description,
                  textAlign: TextAlign.start,
                  style: TextStyle(
                      height: 1,
                      color: primaryColor,
                      fontSize: 12.r,
                      fontWeight: FontWeight.w400),
                ),
                Spacer(),
                SizedBox(
                  height: 30.h,
                  width: 150.r,
                  child: ElevatedButton(
                    style: ButtonStyle(
                      padding: WidgetStatePropertyAll(
                        EdgeInsets.symmetric(horizontal: 16),
                      ),
                      backgroundColor: WidgetStatePropertyAll(
                        primaryColor,
                      ),
                      shape: WidgetStatePropertyAll(
                        RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30.r)),
                      ),
                    ),
                    onPressed: onPressed,
                    child: Text(
                      buttonTitle,
                      style: getLightStyle(context).copyWith(
                        fontWeight: FontWeight.w500,
                        color: whiteColor,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          PositionedDirectional(
            end: 0,
            top: 0,
            child: Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 10,
                vertical: 5,
              ),
              decoration: BoxDecoration(
                color: primaryColor,
                borderRadius: BorderRadius.only(
                  topLeft: Get.locale?.languageCode == "en"
                      ? Radius.circular(0.r)
                      : Radius.circular(10.r),
                  topRight: Get.locale?.languageCode == "en"
                      ? Radius.circular(10.r)
                      : Radius.circular(0),
                ),
              ),
              child: Text(
                "Special Opportunity".tr,
                style: getLightStyle(context).copyWith(
                  fontWeight: FontWeight.bold,
                  color: whiteColor,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
