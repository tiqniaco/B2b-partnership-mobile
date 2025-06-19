import 'package:b2b_partenership/app_routes.dart';
import 'package:b2b_partenership/controller/shop/shop_controller.dart';
import 'package:b2b_partenership/core/theme/app_color.dart';
import 'package:b2b_partenership/core/theme/text_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

class AllFelidsWidget extends GetView<ShopController> {
  const AllFelidsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Get.toNamed(AppRoutes.allCategories,
            arguments: {"categories": controller.shopCategories});
      },
      child: SizedBox(
        width: 140.w,
        height: 84.h,
        child: Column(
          children: [
            Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(10.r),
                    bottomLeft: Radius.circular(10.r),
                  ),
                  child: Image.asset(
                    "assets/images/rr.png",
                    fit: BoxFit.cover,
                    width: 140.w,
                    height: 84.h,
                  ),
                ),
                Container(
                  width: 140.w,
                  height: 84.h,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(10.r),
                        bottomLeft: Radius.circular(10.r),
                      ),
                      color: blackColor.withAlpha(50)),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      top: 20.0, left: 20.0, right: 20.0, bottom: 10.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Icon(
                        Icons.mediation_outlined,
                        color: Colors.white,
                        size: 20.r,
                      ),
                      Gap(8.h),
                      Text(
                        "All fields".tr,
                        style: getMediumStyle(context).copyWith(
                            fontWeight: FontWeight.bold, color: whiteColor),
                      ),
                      Gap(8.h),
                    ],
                  ),
                ),
              ],
            ),
            Gap(5),
            Material(
              borderRadius: BorderRadius.circular(30),
              elevation: 1,
              child: Container(
                alignment: Alignment.center,
                padding: EdgeInsets.symmetric(vertical: 5),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  color: whiteColor,
                ),
                child: Text(
                  "Show All".tr,
                  style: TextStyle(
                      fontSize: 14.r,
                      fontWeight: FontWeight.w600,
                      color: Colors.teal),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
