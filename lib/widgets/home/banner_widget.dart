import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class BannerWidget extends StatelessWidget {
  const BannerWidget(
      {super.key,
      required this.image,
      required this.title,
      required this.description,
      required this.buttonTitle,
      required this.onPressed,
      required this.imageAr});
  final String image;
  final String imageAr;
  final String title;
  final String description;
  final String buttonTitle;
  final void Function() onPressed;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 6.w),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(6.r),
      ),
      height: context.isTablet ? 250 : 240.h,
      width: double.infinity,
      child: Stack(
        children: [
          ClipRRect(
              borderRadius: BorderRadius.circular(6.r),
              child: Image.asset(
                image,
                fit: BoxFit.fitWidth,
                width: double.infinity,
              )),
          Container(
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(10.r),
                topRight: Radius.circular(10.r),
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
              top: 16,
              bottom: 12,
              right: 12.0,
              left: 12.0,
            ),
            // child: Column(
            //   crossAxisAlignment: CrossAxisAlignment.start,
            //   mainAxisAlignment: MainAxisAlignment.center,
            //   children: [
            //     Text(
            //       title,
            //       textAlign: TextAlign.start,
            //       style: TextStyle(
            //         color: whiteColor,
            //         fontWeight: FontWeight.w700,
            //         fontFamily: 'PlaypenSans',
            //         fontSize: context.isTablet ? 12.r : 16.r,
            //       ),
            //       // maxLines: 2,
            //       // overflow: TextOverflow.ellipsis,
            //     ),
            //     Gap(8),
            //     // Text(
            //     //   description,
            //     //   textAlign: TextAlign.start,
            //     //   style: TextStyle(
            //     //       height: 1,
            //     //       color: whiteColor,
            //     //       fontSize: Get.locale?.languageCode == "en" ? 12.r : 16.r,
            //     //       fontWeight: FontWeight.w600),
            //     // ),
            //     // Spacer(),
            //     SizedBox(
            //       height: 30.h,
            //       width: 120.r,
            //       child: ElevatedButton(
            //         style: ButtonStyle(
            //           padding: WidgetStatePropertyAll(
            //             EdgeInsets.symmetric(horizontal: 16),
            //           ),
            //           backgroundColor: WidgetStatePropertyAll(
            //             whiteColor,
            //           ),
            //           shape: WidgetStatePropertyAll(
            //             RoundedRectangleBorder(
            //                 borderRadius: BorderRadius.circular(30.r)),
            //           ),
            //         ),
            //         onPressed: onPressed,
            //         child: Text(
            //           buttonTitle,
            //           style: getLightStyle(context).copyWith(
            //             fontWeight: FontWeight.w500,
            //             color: blackColor,
            //           ),
            //         ),
            //       ),
            //     ),
            //   ],
            // ),
          ),
          // PositionedDirectional(
          //   end: 0,
          //   top: 0,
          //   child: Container(
          //     padding: const EdgeInsets.symmetric(
          //       horizontal: 10,
          //       vertical: 5,
          //     ),
          //     decoration: BoxDecoration(
          //       color: primaryColor,
          //       borderRadius: BorderRadius.only(
          //         topLeft: Get.locale?.languageCode == "en"
          //             ? Radius.circular(0.r)
          //             : Radius.circular(10.r),
          //         topRight: Get.locale?.languageCode == "en"
          //             ? Radius.circular(10.r)
          //             : Radius.circular(0),
          //       ),
          //     ),
          //     child: Text(
          //       "Special Opportunity".tr,
          //       style: getLightStyle(context).copyWith(
          //         fontWeight: FontWeight.bold,
          //         color: whiteColor,
          //       ),
          //     ),
          //   ),
          // ),
        ],
      ),
    );
  }
}
