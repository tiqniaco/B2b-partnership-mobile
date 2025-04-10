import 'package:b2b_partenership/app_routes.dart';
import 'package:b2b_partenership/controller/settings/setting_controller.dart';
import 'package:b2b_partenership/core/functions/logout.dart';
import 'package:b2b_partenership/core/functions/remove_account.dart';
import 'package:b2b_partenership/core/functions/translate_database.dart';
import 'package:b2b_partenership/core/network/api_constance.dart';
import 'package:b2b_partenership/core/theme/app_color.dart';
import 'package:b2b_partenership/core/theme/text_style.dart';
import 'package:b2b_partenership/widgets/language_widget.dart';
import 'package:b2b_partenership/widgets/please_login_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

class SettingsView extends StatelessWidget {
  const SettingsView({super.key});

  @override
  Widget build(BuildContext context) {
    if (ApiConstance.token.isEmpty) {
      return const PleaseLoginWidget();
    }
    return Scaffold(
      body: GetBuilder<SettingController>(
        init: SettingController(),
        builder: (controller) => Stack(
          children: [
            SafeArea(
                child: controller.menuModel == null
                    ? Center(child: CircularProgressIndicator())
                    : SingleChildScrollView(
                        child: Center(
                          child: Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                SizedBox(
                                  width: 1.sw,
                                  child: Stack(
                                    children: [
                                      Align(
                                        alignment: AlignmentDirectional.center,
                                        child: Column(
                                          children: [
                                            Container(
                                              height: context.isTablet
                                                  ? 100.h
                                                  : 60.h,
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(8),
                                                border: Border.all(
                                                  color: Colors.grey[300]!,
                                                ),
                                              ),
                                              child: ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(8),
                                                child: Image.network(
                                                  controller
                                                      .menuModel!.data!.image!,
                                                  fit: BoxFit.cover,
                                                ),
                                              ),
                                            ),
                                            Gap(10),
                                            Text(
                                              controller.menuModel!.data!.name!,
                                              style: getMediumStyle(context)
                                                  .copyWith(
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            Text(
                                              "+${controller.menuModel!.data!.countryCode}${controller.menuModel!.data!.phone}",
                                              style: getMediumStyle(context)
                                                  .copyWith(
                                                color: greyColor,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      PositionedDirectional(
                                        top: 0,
                                        end: 0,
                                        child: Column(
                                          children: [
                                            InkWell(
                                              borderRadius:
                                                  BorderRadius.circular(20.r),
                                              onTap: () {
                                                Get.toNamed(
                                                  AppRoutes.notification,
                                                );
                                              },
                                              child: CircleAvatar(
                                                radius: 20.r,
                                                backgroundColor:
                                                    blackColor.withAlpha(10),
                                                child: Icon(
                                                  FontAwesomeIcons.bell,
                                                  color: blackColor,
                                                  size: 20.r,
                                                ),
                                              ),
                                            ),
                                            Gap(4.h),
                                            InkWell(
                                              borderRadius:
                                                  BorderRadius.circular(20.r),
                                              onTap: () {
                                                Get.toNamed(AppRoutes.save);
                                              },
                                              child: CircleAvatar(
                                                radius: 20.r,
                                                backgroundColor:
                                                    blackColor.withAlpha(10),
                                                child: SvgPicture.asset(
                                                  'assets/svgs/save.svg',
                                                  height: 20.r,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Gap(10),
                                if (controller.menuModel!.data!.providerId !=
                                        null &&
                                    controller.menuModel!.data!.providerId !=
                                        "")
                                  InkWell(
                                    onTap: () {
                                      controller.switchAccount();
                                    },
                                    child: Material(
                                      borderRadius: BorderRadius.circular(5),
                                      elevation: 0.5,
                                      child: Container(
                                        alignment: Alignment.center,
                                        width: double.infinity,
                                        padding: EdgeInsets.all(12),
                                        decoration: BoxDecoration(
                                          color: primaryColor.withAlpha(40),
                                          borderRadius:
                                              BorderRadius.circular(5),
                                        ),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Text(
                                              "Switch to Provider Account".tr,
                                              style: getRegularStyle(context)
                                                  .copyWith(
                                                color: blackColor,
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                            Gap(10),
                                            Icon(
                                              Icons.restart_alt_rounded,
                                              size: 17.r,
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                Gap(10),
                                GridView(
                                  physics: NeverScrollableScrollPhysics(),
                                  shrinkWrap: true,
                                  gridDelegate:
                                      SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: context.isLargeTablet
                                        ? 4
                                        : context.isTablet
                                            ? 3
                                            : 2,
                                    mainAxisSpacing: 15,
                                    crossAxisSpacing: 15,
                                    childAspectRatio: 9 / 4.1,
                                  ),
                                  children: [
                                    boxWidget(
                                      Icons.work_outline,
                                      Colors.amber,
                                      controller.menuModel!.jobsCount
                                          .toString(),
                                      "Jobs".tr,
                                      () {
                                        Get.toNamed(
                                            AppRoutes.clientJobApplications);
                                      },
                                    ),
                                    boxWidget(
                                        Icons.shopping_cart_outlined,
                                        Colors.blue,
                                        controller.menuModel!.shoppingCount
                                            .toString(),
                                        "Orders".tr, () {
                                      Get.toNamed(AppRoutes.shopOrders);
                                    }),
                                    boxWidget(
                                        CupertinoIcons.news,
                                        Colors.green,
                                        controller.menuModel!.servicesCount
                                            .toString(),
                                        "Posts".tr, () {
                                      Get.toNamed(AppRoutes.getRequestServices);
                                    }),
                                    boxWidget(
                                        Icons.headset_mic_outlined,
                                        Colors.red,
                                        controller.menuModel!.complaintsCount
                                            .toString(),
                                        "Complaints".tr, () {
                                      Get.toNamed(AppRoutes.complaints);
                                    })
                                  ],
                                ),
                                Gap(20.h),
                                FractionallySizedBox(
                                  widthFactor: 10,
                                  child: Divider(
                                    thickness: 5,
                                    color: borderColor.withAlpha(40),
                                  ),
                                ),
                                Gap(10.h),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Personal Information".tr,
                                      style: getMediumStyle(context).copyWith(
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    Gap(20),
                                    rowWidget("Email".tr,
                                        controller.menuModel!.data!.email!),
                                    FractionallySizedBox(
                                      widthFactor: 10,
                                      child: Divider(
                                        color: borderColor,
                                      ),
                                    ),
                                    rowWidget(
                                        "City".tr,
                                        translateDatabase(
                                            arabic: controller.menuModel!.data!
                                                .governmentNameAr!,
                                            english: controller.menuModel!.data!
                                                .governmentNameEn!)),
                                    FractionallySizedBox(
                                      widthFactor: 10,
                                      child: Divider(
                                        color: borderColor,
                                      ),
                                    ),
                                    rowWidget(
                                        "Country".tr,
                                        translateDatabase(
                                            arabic: controller.menuModel!.data!
                                                .countryNameAr!,
                                            english: controller.menuModel!.data!
                                                .countryNameEn!)),
                                    Gap(30),
                                    FractionallySizedBox(
                                      widthFactor: 10,
                                      child: Divider(
                                        thickness: 5,
                                        color: borderColor.withAlpha(40),
                                      ),
                                    ),
                                    Gap(20),
                                    Text(
                                      "Other Services".tr,
                                      style:
                                          getMediumStyle(Get.context!).copyWith(
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    Gap(20),
                                    rowWithArrow(
                                      CupertinoIcons.person,
                                      "Edit Profile".tr,
                                      () {
                                        Get.toNamed(
                                          AppRoutes.editClientProfile,
                                          arguments: {
                                            'model': controller.menuModel!.data,
                                          },
                                        );
                                      },
                                    ),
                                    Gap(8),
                                    FractionallySizedBox(
                                      widthFactor: 10,
                                      child: Divider(
                                        color: borderColor,
                                      ),
                                    ),
                                    Gap(8),
                                    rowWithArrow(
                                      CupertinoIcons.padlock,
                                      "Change Password".tr,
                                      () {
                                        Get.toNamed(AppRoutes.changePassword);
                                      },
                                    ),
                                    Gap(8),
                                    FractionallySizedBox(
                                      widthFactor: 10,
                                      child: Divider(
                                        color: borderColor,
                                      ),
                                    ),
                                    Gap(8),
                                    rowWithArrow(
                                      CupertinoIcons.delete_simple,
                                      "Remove Account".tr,
                                      () {
                                        removeAccountDialog(
                                          removeAccountLoading:
                                              controller.removeAccountLoading,
                                          update: controller.update,
                                        );
                                      },
                                    ),
                                    Gap(8),
                                    FractionallySizedBox(
                                      widthFactor: 10,
                                      child: Divider(
                                        color: borderColor,
                                      ),
                                    ),
                                    Gap(8),
                                    rowWithArrow(
                                      Icons.logout_rounded,
                                      "Logout".tr,
                                      () {
                                        logoutDialog();
                                      },
                                    ),
                                    FractionallySizedBox(
                                      widthFactor: 10,
                                      child: Divider(
                                        color: borderColor,
                                      ),
                                    ),
                                    Gap(8),
                                    LanguageWidget(),
                                    Gap(8),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      )),
            if (controller.removeAccountLoading)
              Container(
                width: 1.sw,
                height: 1.sh,
                color: Colors.black26.withAlpha(80),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ...[
                      Container(
                        width: 80.w,
                        height: 80.w,
                        decoration: BoxDecoration(
                          color: whiteColor,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            CircularProgressIndicator(),
                          ],
                        ),
                      )
                    ],
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget boxWidget(IconData icon, Color color, String title, String subTitle,
      void Function() onTap) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: borderColor)),
        child: Row(
          children: [
            CircleAvatar(
              radius: 19.r,
              backgroundColor: color.withAlpha(30),
              child: Icon(
                icon,
                color: color,
                size: 20.r,
              ),
            ),
            Gap(10),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: getMediumStyle(Get.context!).copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  subTitle,
                  style: getRegularStyle(Get.context!).copyWith(
                    color: greyColor,
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget rowWidget(String title, String data) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 9.0),
      child: Row(
        children: [
          Expanded(
            flex: 1,
            child: Text(
              title,
              style: getRegularStyle(Get.context!).copyWith(
                fontWeight: FontWeight.w300,
              ),
            ),
          ),
          Expanded(
              flex: 2,
              child: Text(
                data,
                style: getRegularStyle(Get.context!).copyWith(
                  fontWeight: FontWeight.w500,
                  color: Colors.black54,
                ),
              ))
        ],
      ),
    );
  }

  Widget rowWithArrow(IconData icon, String title, void Function() onPressed) {
    return InkWell(
      onTap: onPressed,
      child: Row(
        children: [
          CircleAvatar(
            radius: 18.r,
            backgroundColor: borderColor.withAlpha(30),
            child: Icon(
              icon,
              color: Colors.black54,
              size: 20.r,
            ),
          ),
          Gap(15),
          Text(
            title,
            style: getRegularStyle(Get.context!).copyWith(
              fontWeight: FontWeight.w300,
            ),
          ),
          Spacer(),
          IconButton(
              onPressed: onPressed,
              icon: Icon(
                Icons.arrow_forward_ios_rounded,
                size: 15.r,
              ))
        ],
      ),
    );
  }
}
