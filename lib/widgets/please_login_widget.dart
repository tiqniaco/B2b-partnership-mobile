import 'package:b2b_partenership/app_routes.dart';
import 'package:b2b_partenership/core/global/widgets/custom_loading_button.dart';
import 'package:b2b_partenership/core/theme/app_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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
        child: Card(
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
                  size: 40.sp,
                  color: Colors.grey[700],
                ),
                SizedBox(height: 16.h),
                Text(
                  "You're not logged in".tr,
                  style: TextStyle(
                    fontSize: 19.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: 5.h),
                Text(
                  "Please log in to access this feature.".tr,
                  style: TextStyle(
                    fontSize: 12.sp,
                    color: Colors.grey[600],
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 24),
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
      ),
    );
  }
}
