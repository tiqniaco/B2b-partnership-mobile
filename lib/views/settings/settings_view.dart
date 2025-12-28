import 'package:b2b_partenership/app_routes.dart';
import 'package:b2b_partenership/controller/settings/setting_controller.dart';
import 'package:b2b_partenership/core/functions/logout.dart';
import 'package:b2b_partenership/core/functions/remove_account.dart';
import 'package:b2b_partenership/core/functions/translate_database.dart';
import 'package:b2b_partenership/core/global/widgets/custom_network_image.dart';
import 'package:b2b_partenership/core/network/api_constance.dart';
import 'package:b2b_partenership/core/theme/app_color.dart';
import 'package:b2b_partenership/core/theme/text_style.dart';
import 'package:b2b_partenership/widgets/language_widget.dart';
import 'package:b2b_partenership/widgets/please_login_widget.dart';
import 'package:b2b_partenership/widgets/settings/setting_loading_widget.dart';
import 'package:b2b_partenership/widgets/settings/settings_widgets.dart';
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
                    ? SettingLoadingWidget()
                    : SingleChildScrollView(
                        child: Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Gap(20),
                                  Column(
                                    children: [
                                      CustomNetworkImage(
                                        imageUrl:
                                            controller.menuModel!.data.image,
                                        fit: BoxFit.cover,
                                        borderRadius: 8,
                                        height: context.isTablet ? 100.h : 60.h,
                                      ),
                                      Gap(10),
                                      Text(
                                        controller.menuModel!.data.name,
                                        style: getMediumStyle(context).copyWith(
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Column(
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
                                ],
                              ),
                              Gap(10),
                              if (controller.menuModel!.data.providerId !=
                                      null &&
                                  controller.menuModel!.data.providerId != "")
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 24.0),
                                  child: InkWell(
                                    onTap: () {
                                      controller.switchAccount();
                                    },
                                    child: Container(
                                      alignment: Alignment.center,
                                      width: double.infinity,
                                      padding: EdgeInsets.all(12),
                                      decoration: BoxDecoration(
                                        color: lightPrimaryColor.withAlpha(190),
                                        borderRadius: BorderRadius.circular(5),
                                      ),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            "Switch to Provider Account".tr,
                                            style: getRegularStyle(context)
                                                .copyWith(
                                              color: primaryColor,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                          Gap(10),
                                          Icon(
                                            Icons.restart_alt_rounded,
                                            size: 17.r,
                                            color: primaryColor,
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              Gap(24),
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
                                  childAspectRatio: 9 / 3.5,
                                ),
                                children: [
                                  boxWidget(
                                    Icons.work_outline,
                                    Colors.amber,
                                    controller.menuModel!.jobsCount.toString(),
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
                                    Get.toNamed(AppRoutes
                                            .getServicesRequest //getRequestServices
                                        );
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
                              Gap(24),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Personal Information".tr,
                                    style: getMediumStyle(context).copyWith(
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  Gap(16),
                                  rowWidget(
                                    icon: Icons.phone_in_talk,
                                    controller.menuModel!.data.phone,
                                  ),
                                  Gap(8),
                                  rowWidget(
                                    icon: Icons.email,
                                    controller.menuModel!.data.email,
                                  ),
                                  Gap(8),
                                  rowWidget(
                                      icon: Icons.location_on,
                                      translateDatabase(
                                          arabic: controller
                                              .menuModel!.data.governmentNameAr,
                                          english: controller.menuModel!.data
                                              .governmentNameEn)),
                                  Gap(8),
                                  rowWidget(
                                      icon: FontAwesomeIcons.locationArrow,
                                      translateDatabase(
                                          arabic: controller
                                              .menuModel!.data.countryNameAr,
                                          english: controller
                                              .menuModel!.data.countryNameEn)),
                                  Gap(24),
                                  Text(
                                    "Other Services".tr,
                                    style:
                                        getMediumStyle(Get.context!).copyWith(
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  Gap(16),
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
                                  rowWithArrow(
                                    CupertinoIcons.padlock,
                                    "Change Password".tr,
                                    () {
                                      Get.toNamed(AppRoutes.changePassword);
                                    },
                                  ),
                                  Gap(8),
                                  // if(Get.find<AppPreferences>().getUserRole() == 'provider')...[
                                 
                                  // ],
                                  rowWithArrow(
                                    CupertinoIcons.delete_simple,
                                    "Remove Account".tr,
                                    () {
                                      removeAccountDialog(
                                        context: context,
                                        removeAccountLoading:
                                            controller.removeAccountLoading,
                                        update: controller.update,
                                      );
                                    },
                                  ),
                                  Gap(8),
                                  rowWithArrow(
                                    Icons.logout_rounded,
                                    "Logout".tr,
                                    () {
                                      logoutDialog(context);
                                    },
                                  ),
                                  Gap(8),
                                  rowWithArrow(
                                    Icons.report_gmailerrorred,
                                    "About us".tr,
                                    () {
                                      Get.toNamed(AppRoutes.aboutUs);
                                    },
                                  ),
                                  Gap(8),
                                  rowWithArrow(
                                    CupertinoIcons.news,
                                    "Terms & Conditions".tr,
                                    () {
                                      Get.toNamed(AppRoutes.termsAndConditions);
                                    },
                                  ),
                                  Gap(8),
                                  LanguageWidget(),
                                  Gap(8),
                                ],
                              ),
                            ],
                          ),
                        ),
                      )),
          ],
        ),
      ),
    );
  }
}
