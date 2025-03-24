import 'package:b2b_partenership/app_routes.dart';
import 'package:b2b_partenership/core/global/widgets/custom_loading_button.dart';
import 'package:b2b_partenership/core/theme/app_color.dart';
import 'package:b2b_partenership/core/theme/text_style.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:lucide_icons/lucide_icons.dart';

class PleaseLoginWidget extends StatelessWidget {
  const PleaseLoginWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: whiteColor),
      body: Container(
        alignment: AlignmentDirectional.center,
        padding: EdgeInsets.only(bottom: MediaQuery.paddingOf(context).top * 2),
        child: SizedBox(
          width: context.isTablet ? 0.75.sw : 1.sw,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: InkWell(
                  onTap: () {
                    Get.toNamed(AppRoutes.aboutUs);
                  },
                  child: Row(
                    children: [
                      CircleAvatar(
                        radius: 18.sp,
                        backgroundColor: borderColor.withAlpha(30),
                        child: Icon(
                          Icons.report_gmailerrorred,
                          color: primaryColor,
                          size: 20.sp,
                        ),
                      ),
                      Gap(15),
                      Text(
                        "About us".tr,
                        style: TextStyle(
                            fontSize: 14.sp, fontWeight: FontWeight.bold),
                      ),
                      Spacer(),
                      Icon(
                        Icons.arrow_forward_ios_rounded,
                        size: 15.sp,
                      )
                    ],
                  ),
                ),
              ),
              Gap(10.h),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: InkWell(
                  onTap: () {
                    Get.toNamed(AppRoutes.termsAndConditions);
                  },
                  child: Row(
                    children: [
                      CircleAvatar(
                        radius: 18.sp,
                        backgroundColor: borderColor.withAlpha(30),
                        child: Icon(
                          CupertinoIcons.news,
                          color: primaryColor,
                          size: 20.sp,
                        ),
                      ),
                      Gap(15),
                      Text(
                        "Terms & Conditions".tr,
                        style: TextStyle(
                            fontSize: 14.sp, fontWeight: FontWeight.bold),
                      ),
                      Spacer(),
                      Icon(
                        Icons.arrow_forward_ios_rounded,
                        size: 15.sp,
                      )
                    ],
                  ),
                ),
              ),
              Gap(20.h),
              Card(
                elevation: 6,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(24),
                ),
                margin: const EdgeInsets.symmetric(horizontal: 24),
                child: Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        LucideIcons.userX,
                        size: context.isTablet ? 40.h : 35.h,
                        color: Colors.grey[700],
                      ),
                      SizedBox(height: 16.h),
                      Text(
                        "You're not logged in".tr,
                        style: getSemiBoldStyle(context),
                      ),
                      SizedBox(height: 5.h),
                      Text(
                        "Please log in to access this feature.".tr,
                        style: getRegularStyle(context).copyWith(
                          color: hintColor,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: 24.h),
                      CustomLoadingButton(
                        text: "Login".tr,
                        onPressed: () {
                          Get.toNamed(AppRoutes.login);
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
