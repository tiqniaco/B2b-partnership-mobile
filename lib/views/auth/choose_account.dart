import 'package:b2b_partenership/app_routes.dart';
import 'package:b2b_partenership/controller/auth/choose_account_controller.dart';
import 'package:b2b_partenership/core/global/widgets/custom_loading_button.dart';
import 'package:b2b_partenership/core/theme/app_color.dart';
import 'package:b2b_partenership/core/theme/text_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

class ChooseAccount extends StatelessWidget {
  const ChooseAccount({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder<ChooseAccountController>(
          init: ChooseAccountController(),
          builder: (controller) {
            return SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Center(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Row(
                        children: [
                          IconButton(
                            onPressed: () {
                              Get.back();
                            },
                            icon: Icon(
                              Icons.close,
                              size: 32.r,
                            ),
                          ),
                        ],
                      ),
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.r),
                        ),
                        clipBehavior: Clip.antiAlias,
                        child: Image.asset(
                          "assets/images/logo.png",
                          height: 160.h,
                          // width: 100,
                          fit: BoxFit.fill,
                        ),
                      ),
                      Gap(20.h),
                      Text(
                        "Join as a Client or Service Provider".tr,
                        style: getMediumStyle(context).copyWith(
                            // fontWeight: FontWeight.bold,
                            color: greyColor),
                      ),
                      Gap(30),
                      containerWidget(
                          "assets/images/client.jpg",
                          "I'm a client".tr,
                          "Looking for help with a project.".tr,
                          controller.isClient, () {
                        controller.onTapClient();
                      }),
                      Gap(10.h),
                      containerWidget(
                          "assets/images/provider.jpeg",
                          "I'm a Service provider".tr,
                          "Looking for my favorite work.".tr,
                          controller.isProvider, () {
                        controller.onTapProvider();
                      }),
                      Gap(40.h),
                      CustomLoadingButton(
                        text: "Create Account".tr,
                        width: context.isTablet ? 0.75.sw : null,
                        onPressed: () {
                          return controller.goOnTap();
                        },
                        backgroundColor: primaryColor,
                        // height: 0.06.sh,
                      ),
                      Gap(10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Already have an account?".tr,
                            style: context.isTablet
                                ? getRegularStyle(context).copyWith(
                                    color: greyColor,
                                    fontWeight: FontWeight.bold)
                                : getLightStyle(context).copyWith(
                                    color: greyColor,
                                    fontWeight: FontWeight.bold,
                                  ),
                          ),
                          Gap(5.w),
                          InkWell(
                            onTap: () {
                              Get.offNamed(AppRoutes.login);
                            },
                            child: Text(
                              "Login".tr,
                              style: context.isTablet
                                  ? getMediumStyle(context).copyWith(
                                      fontWeight: FontWeight.w600,
                                      color: primaryColor,
                                    )
                                  : getRegularStyle(context).copyWith(
                                      fontWeight: FontWeight.w600,
                                      color: primaryColor,
                                    ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            );
          }),
    );
  }

  Widget containerWidget(String image, String title, String subtitle,
      bool isActive, void Function()? onTap) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: whiteColor,
          boxShadow: [BoxShadow(color: pageColor)],
          border: Border.all(color: pageColor.withAlpha(110), width: 1.7),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          children: [
            Image.asset(
              image,
              height: 45.h,
              width: 45.h,
            ),
            Gap(10.w),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: getMediumStyle(Get.context!).copyWith(
                      fontWeight: FontWeight.w700, color: Colors.black87),
                ),
                Text(
                  subtitle,
                  style: getLightStyle(Get.context!).copyWith(
                    color: greyColor,
                  ),
                ),
              ],
            ),
            Spacer(),
            isActive
                ? Icon(
                    Icons.check_circle,
                    color: primaryColor,
                    size: 18.r,
                  )
                : Icon(
                    Icons.circle_outlined,
                    color: greyColor,
                    size: 18.r,
                  )
          ],
        ),
      ),
    );
  }
}
