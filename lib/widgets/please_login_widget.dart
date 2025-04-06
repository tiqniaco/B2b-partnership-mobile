import 'package:b2b_partenership/app_routes.dart';
import 'package:b2b_partenership/core/global/widgets/custom_loading_button.dart';
import 'package:b2b_partenership/core/theme/app_color.dart';
import 'package:b2b_partenership/core/theme/text_style.dart';
import 'package:b2b_partenership/core/utils/font_manager.dart';
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
              CustomLoginItemWidget(
                icon: Icons.report_gmailerrorred,
                title: "About us".tr,
                onTap: () {
                  Get.toNamed(AppRoutes.aboutUs);
                },
              ),
              Gap(10.h),
              CustomLoginItemWidget(
                icon: CupertinoIcons.news,
                title: "Terms & Conditions".tr,
                onTap: () {
                  Get.toNamed(AppRoutes.termsAndConditions);
                },
              ),
              Spacer(),
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
              Spacer(),
            ],
          ),
        ),
      ),
    );
  }
}

class CustomLoginItemWidget extends StatelessWidget {
  const CustomLoginItemWidget({
    super.key,
    this.onTap,
    required this.icon,
    required this.title,
  });
  final Function()? onTap;
  final IconData icon;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: InkWell(
        onTap: onTap,
        child: Row(
          children: [
            CircleAvatar(
              radius: 20.r,
              backgroundColor: borderColor.withAlpha(30),
              child: Icon(
                icon,
                color: primaryColor,
                size: 20.r,
              ),
            ),
            Gap(10.w),
            Text(
              title,
              style: getMediumStyle(context).copyWith(
                fontWeight: FontManager.boldFontWeight,
              ),
            ),
            Spacer(),
            Icon(
              Icons.arrow_forward_ios_rounded,
              size: 15.r,
            )
          ],
        ),
      ),
    );
  }
}
