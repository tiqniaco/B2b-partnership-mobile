import 'package:b2b_partenership/app_routes.dart';
import 'package:b2b_partenership/controller/provider/setting/provider_setting_controller.dart';
import 'package:b2b_partenership/core/functions/logout.dart';
import 'package:b2b_partenership/core/functions/remove_account.dart';
import 'package:b2b_partenership/core/functions/translate_database.dart';
import 'package:b2b_partenership/core/global/widgets/app_pdf_view.dart';
import 'package:b2b_partenership/core/theme/app_color.dart';
import 'package:b2b_partenership/core/theme/text_style.dart';
import 'package:b2b_partenership/widgets/language_widget.dart';
// import 'package:b2b_partenership/widgets/language_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cached_pdfview/flutter_cached_pdfview.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

class ProviderSettingView extends StatelessWidget {
  const ProviderSettingView({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(ProviderSettingController());
    return Scaffold(
      body: GetBuilder<ProviderSettingController>(
        builder: (controller) => SafeArea(
            child: controller.menuModel == null
                ? Center(child: CircularProgressIndicator())
                : SingleChildScrollView(
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              height: context.isTablet ? 100.h : 60.h,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                border: Border.all(
                                  color: Colors.grey[300]!,
                                ),
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(8),
                                child: Image.network(
                                  controller.menuModel!.data!.image,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            Gap(10),
                            Text(
                              controller.menuModel!.data!.name,
                              style: getMediumStyle(context).copyWith(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              "+${controller.menuModel!.data!.countryCode}${controller.menuModel!.data!.phone}",
                              style: getMediumStyle(context).copyWith(
                                color: greyColor,
                              ),
                            ),
                            Gap(8.h),
                            InkWell(
                              onTap: () {
                                controller.switchAccount();
                              },
                              child: Container(
                                padding: EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(3),
                                    color: primaryColor.withAlpha(40)),
                                width: double.infinity,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      "Switch to Client Account".tr,
                                      textAlign: TextAlign.center,
                                      style: getRegularStyle(context).copyWith(
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
                                    controller.menuModel!.jobsCount.toString(),
                                    "Jobs".tr, () {
                                  Get.toNamed(AppRoutes.clientJobApplications);
                                }),
                                boxWidget(
                                    CupertinoIcons.news,
                                    Colors.blue,
                                    controller.menuModel!.shoppingCount
                                        .toString(),
                                    "Posts".tr, () {
                                  Get.toNamed(AppRoutes.getServicesRequest);
                                }),
                                boxWidget(
                                    Icons.shopping_cart_outlined,
                                    Colors.green,
                                    controller.menuModel!.ordersCount
                                        .toString(),
                                    "Orders".tr, () {
                                  Get.toNamed(AppRoutes.shopOrders);
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
                                  style: getMediumStyle(context),
                                ),
                                Gap(20),
                                rowWidget("Email".tr,
                                    controller.menuModel!.data!.email),
                                FractionallySizedBox(
                                  widthFactor: 10,
                                  child: Divider(
                                    color: borderColor,
                                  ),
                                ),
                                rowWidget(
                                    "City".tr,
                                    translateDatabase(
                                        arabic: controller
                                            .menuModel!.data!.governmentNameAr,
                                        english: controller.menuModel!.data!
                                            .governmentNameEn)),
                                FractionallySizedBox(
                                  widthFactor: 10,
                                  child: Divider(
                                    color: borderColor,
                                  ),
                                ),
                                rowWidget(
                                    "Country".tr,
                                    translateDatabase(
                                        arabic: controller
                                            .menuModel!.data!.countryNameAr,
                                        english: controller
                                            .menuModel!.data!.countryNameEn)),
                                FractionallySizedBox(
                                  widthFactor: 10,
                                  child: Divider(
                                    color: borderColor.withAlpha(40),
                                  ),
                                ),
                                rowWidget(
                                    "Company Type".tr,
                                    translateDatabase(
                                        arabic: controller.menuModel!.data!
                                            .providerTypeNameAr,
                                        english: controller.menuModel!.data!
                                            .providerTypeNameEn)),
                                FractionallySizedBox(
                                  widthFactor: 10,
                                  child: Divider(
                                    color: borderColor.withAlpha(40),
                                  ),
                                ),
                                Gap(10),
                                if (controller
                                        .menuModel!.data!.commercialRegister !=
                                    "") ...[
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        "Commercial Papers".tr,
                                        style: getMediumStyle(context),
                                      ),
                                    ],
                                  ),
                                  Gap(10.h),
                                  Row(
                                    children: [
                                      SizedBox(
                                        height: 90.h,
                                        width: 125.h,
                                        child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          child: PDF().cachedFromUrl(
                                            controller.menuModel!.data!
                                                .commercialRegister,
                                            placeholder: (progress) => Center(
                                                child: Text('loading...')),
                                            errorWidget: (error) => Center(
                                                child: Text(error.toString())),
                                          ),
                                        ),
                                      ),
                                      Spacer(),
                                      InkWell(
                                        onTap: () {
                                          Get.to(
                                            () => AppPdfView(
                                              url: controller.menuModel!.data!
                                                  .commercialRegister,
                                            ),
                                          );
                                        },
                                        child: Icon(
                                            Icons.arrow_circle_right_outlined,
                                            color: primaryColor,
                                            size: 30.r),
                                      ),
                                    ],
                                  ),
                                  Gap(15),
                                  FractionallySizedBox(
                                    widthFactor: 10,
                                    child: Divider(
                                      color: borderColor.withAlpha(40),
                                    ),
                                  ),
                                  Gap(10)
                                ],
                                if (controller.menuModel!.data!.taxCard !=
                                    "") ...[
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        "Tax Papers".tr,
                                        style: getMediumStyle(context),
                                      ),
                                    ],
                                  ),
                                  Gap(20),
                                  Row(
                                    children: [
                                      SizedBox(
                                        height: 90.h,
                                        width: 125.h,
                                        child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          child: PDF().cachedFromUrl(
                                            controller.menuModel!.data!.taxCard,
                                            placeholder: (progress) => Center(
                                                child: Text('loading...')),
                                            errorWidget: (error) => Center(
                                                child: Text(error.toString())),
                                          ),
                                        ),
                                      ),
                                      Spacer(),
                                      InkWell(
                                        onTap: () {
                                          Get.to(
                                            () => AppPdfView(
                                              url: controller
                                                  .menuModel!.data!.taxCard,
                                            ),
                                          );
                                        },
                                        child: Icon(
                                            Icons.arrow_circle_right_outlined,
                                            color: primaryColor,
                                            size: 30.r),
                                      ),
                                    ],
                                  ),
                                  Gap(30),
                                  FractionallySizedBox(
                                    widthFactor: 10,
                                    child: Divider(
                                      thickness: 5,
                                      color: borderColor.withAlpha(40),
                                    ),
                                  )
                                ],
                                Gap(20),
                                Text(
                                  "Other Services".tr,
                                  style: getMediumStyle(context),
                                ),
                                Gap(20),
                                rowWithArrow(
                                  CupertinoIcons.person,
                                  "Edit Profile".tr,
                                  () {
                                    Get.toNamed(
                                      AppRoutes.editProviderProfile,
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
                                  Icons.copy_outlined,
                                  "My Services".tr,
                                  () {
                                    Get.toNamed(
                                      AppRoutes.myServices,
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
                                  CupertinoIcons.book,
                                  "My Previous Work".tr,
                                  () {
                                    Get.toNamed(
                                      AppRoutes.managePreviousWork,
                                      arguments: {
                                        'from': "setting screen",
                                        'id': controller
                                            .menuModel!.data!.providerId
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
                                  CupertinoIcons.phone,
                                  "Mange your Contacts".tr,
                                  () {
                                    Get.toNamed(AppRoutes.providerContacts);
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
                                Gap(8),
                                FractionallySizedBox(
                                  widthFactor: 10,
                                  child: Divider(
                                    color: borderColor,
                                  ),
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
                                FractionallySizedBox(
                                  widthFactor: 10,
                                  child: Divider(
                                    color: borderColor,
                                  ),
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
                                FractionallySizedBox(
                                  widthFactor: 10,
                                  child: Divider(
                                    color: borderColor,
                                  ),
                                ),
                                Gap(8),
                                LanguageWidget(),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  )),
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
