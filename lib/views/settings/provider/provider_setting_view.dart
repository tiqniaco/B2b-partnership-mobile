import 'package:b2b_partenership/app_routes.dart';
import 'package:b2b_partenership/controller/settings/provider/provider_setting_controller.dart';
import 'package:b2b_partenership/core/functions/get_text_direction.dart';
import 'package:b2b_partenership/core/functions/logout.dart';
import 'package:b2b_partenership/core/functions/remove_account.dart';
import 'package:b2b_partenership/core/functions/translate_database.dart';
import 'package:b2b_partenership/core/global/widgets/app_pdf_view.dart';
import 'package:b2b_partenership/core/global/widgets/custom_network_image.dart';
import 'package:b2b_partenership/core/theme/app_color.dart';
import 'package:b2b_partenership/core/theme/text_style.dart';
import 'package:b2b_partenership/core/theme/themes.dart';
import 'package:b2b_partenership/widgets/language_widget.dart';
import 'package:b2b_partenership/widgets/settings/settings_widgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cached_pdfview/flutter_cached_pdfview.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
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
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                SizedBox(
                                  width: 70,
                                ),
                                Column(
                                  children: [
                                    CustomNetworkImage(
                                      shape: BoxShape.circle,
                                      imageUrl:
                                          controller.menuModel?.data?.image ??
                                              '',
                                      fit: BoxFit.cover,
                                      height: 100.r,
                                    ),
                                    Gap(10),
                                    Text(
                                      controller.menuModel?.data?.name ?? '',
                                      style: getMediumStyle(context).copyWith(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    InkWell(
                                      onTap: () {
                                        Get.toNamed(AppRoutes.save);
                                      },
                                      child: Container(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 4, vertical: 8),
                                        decoration: BoxDecoration(
                                            borderRadius: customBorderRadius,
                                            border: Border.all(
                                              color: Colors.grey[300]!,
                                            )),
                                        child: Icon(Icons.bookmark,
                                            color: primaryColor, size: 26.r),
                                      ),
                                    ),
                                    Gap(8),
                                    InkWell(
                                      onTap: () {
                                        Get.toNamed(AppRoutes.notification);
                                      },
                                      child: Container(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 4, vertical: 8),
                                        decoration: BoxDecoration(
                                            borderRadius: customBorderRadius,
                                            border: Border.all(
                                              color: Colors.grey[300]!,
                                            )),
                                        child: Icon(Icons.notifications,
                                            color: primaryColor, size: 26.r),
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            ),
                            Gap(8.h),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 20.0),
                              child: InkWell(
                                onTap: () {
                                  controller.switchAccount();
                                },
                                child: Container(
                                  padding: EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                      borderRadius: customBorderRadius,
                                      color: lightPrimaryColor.withAlpha(180)),
                                  width: double.infinity,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        "Switch to Client Account".tr,
                                        textAlign: TextAlign.center,
                                        style:
                                            getRegularStyle(context).copyWith(
                                          color: primaryColor,
                                          fontWeight: FontWeight.w600,
                                          fontSize: 16.r,
                                        ),
                                      ),
                                      Gap(10),
                                      Icon(
                                        Icons.restart_alt_rounded,
                                        size: 24.r,
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
                                    "Jobs".tr, () {
                                  Get.toNamed(AppRoutes.clientJobApplications);
                                }),
                                boxWidget(
                                    Icons.my_library_books_outlined,
                                    Colors.blue,
                                    controller.menuModel!.shoppingCount
                                        .toString(),
                                    "My Posts".tr, () {
                                  Get.toNamed(AppRoutes.getRequestServices);
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
                                Gap(20),
                                rowWidget(
                                    "(+${controller.menuModel!.data!.countryCode}) ${controller.menuModel!.data!.phone}",
                                    icon: Icons.phone_in_talk),
                                Gap(8),
                                rowWidget(controller.menuModel!.data!.email,
                                    icon: Icons.email),
                                Gap(8),
                                rowWidget(
                                    translateDatabase(
                                        arabic: controller
                                            .menuModel!.data!.countryNameAr,
                                        english: controller
                                            .menuModel!.data!.countryNameEn),
                                    icon: FontAwesomeIcons.locationArrow),
                                Gap(8),
                                rowWidget(
                                    translateDatabase(
                                        arabic: controller
                                            .menuModel!.data!.governmentNameAr,
                                        english: controller
                                            .menuModel!.data!.governmentNameEn),
                                    icon: Icons.location_on),
                                Gap(16),
                                Text(
                                  "Bio".tr,
                                  style: getRegularStyle(Get.context!).copyWith(
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                                Gap(10),
                                Container(
                                    padding: const EdgeInsets.all(10.0),
                                    decoration: BoxDecoration(
                                      border:
                                          Border.all(color: Colors.grey[300]!),
                                      borderRadius: BorderRadius.circular(10.r),
                                    ),
                                    child: Directionality(
                                      textDirection: containsArabic(
                                              controller.menuModel!.data!.bio)
                                          ? TextDirection.rtl
                                          : TextDirection.ltr,
                                      child: Text(
                                        controller.menuModel!.data!.bio,
                                        style: TextStyle(
                                          fontWeight: FontWeight.w500,
                                          fontSize:
                                              context.isTablet ? 8.sp : 14.sp,
                                          color: Colors.black54,
                                        ),
                                      ),
                                    )),
                                Gap(10.h),
                                if (controller
                                        .menuModel!.data!.commercialRegister !=
                                    "") ...[
                                  Gap(15),
                                  Text(
                                    "Business Information".tr,
                                    style: getMediumStyle(context).copyWith(
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  Gap(15.h),
                                  rowWidget(
                                    translateDatabase(
                                        arabic: controller.menuModel!.data!
                                            .providerTypeNameAr,
                                        english: controller.menuModel!.data!
                                            .providerTypeNameEn),
                                    title: "Company Type".tr,
                                  ),
                                  Gap(10),
                                  rowWidget(
                                    controller.menuModel!.data!
                                        .commercialRegisterNumber,
                                    title: "Commercial No.".tr,
                                  ),
                                  Gap(10),
                                  rowWidget(
                                      controller.menuModel!.data!.taxCardNumber,
                                      title: "tax No.".tr),
                                  Gap(10),
                                  rowWidget(controller.menuModel!.data!.vat,
                                      title: "VAT No.".tr),
                                  Gap(16),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        "Commercial Papers".tr,
                                        style: getRegularStyle(context),
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
                                          Icons.arrow_forward_ios,
                                          color: primaryColor,
                                          size: 15.r,
                                        ),
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
                                        style: getRegularStyle(context),
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
                                          Icons.arrow_forward_ios,
                                          color: primaryColor,
                                          size: 15.r,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Gap(30),
                                ],
                                Gap(16),
                                Text(
                                  "Other Services".tr,
                                  style: getMediumStyle(context)
                                      .copyWith(fontWeight: FontWeight.w500),
                                ),
                                Gap(20),
                                rowWithArrow(
                                  CupertinoIcons.person_fill,
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
                                rowWithArrow(
                                  Icons.file_copy,
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
                                rowWithArrow(
                                  CupertinoIcons.book_fill,
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
                                rowWithArrow(
                                  CupertinoIcons.creditcard_fill,
                                  "Payment History".tr,
                                  () {
                                    Get.toNamed(AppRoutes.paymentHistory);
                                  },
                                ),
                                Gap(8),
                                rowWithArrow(
                                  CupertinoIcons.phone_fill,
                                  "Mange your Contacts".tr,
                                  () {
                                    Get.toNamed(AppRoutes.providerContacts);
                                  },
                                ),
                                Gap(8),
                                rowWithArrow(
                                  CupertinoIcons.padlock_solid,
                                  "Change Password".tr,
                                  () {
                                    Get.toNamed(AppRoutes.changePassword);
                                  },
                                ),
                                Gap(8),
                                rowWithArrow(
                                  CupertinoIcons.delete_solid,
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
                                  Icons.report,
                                  "About us".tr,
                                  () {
                                    Get.toNamed(AppRoutes.aboutUs);
                                  },
                                ),
                                Gap(8),
                                rowWithArrow(
                                  Icons.safety_check_sharp,
                                  "Terms & Conditions".tr,
                                  () {
                                    Get.toNamed(AppRoutes.termsAndConditions);
                                  },
                                ),
                                Gap(8),
                                LanguageWidget(),
                                Gap(16),
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

  // Widget boxWidget(IconData icon, Color color, String title, String subTitle,
  //     void Function() onTap) {
  //   return InkWell(
  //     onTap: onTap,
  //     child: Container(
  //       alignment: Alignment.center,
  //       decoration: BoxDecoration(
  //           color: primaryColor.withAlpha(30),
  //           borderRadius: customBorderRadius),
  //       child: Row(
  //         mainAxisAlignment: MainAxisAlignment.center,
  //         children: [
  //           Icon(
  //             icon,
  //             color: primaryColor,
  //             size: 27.r,
  //           ),
  //           Gap(10),
  //           Column(
  //             mainAxisAlignment: MainAxisAlignment.center,
  //             crossAxisAlignment: CrossAxisAlignment.center,
  //             children: [
  //               Text(
  //                 subTitle,
  //                 style: getMediumStyle(Get.context!)
  //                     .copyWith(fontWeight: FontWeight.w600, fontSize: 13.r),
  //               ),
  //               Text(
  //                 title,
  //                 style: getRegularStyle(Get.context!).copyWith(
  //                   color: blackColor,
  //                 ),
  //               ),
  //             ],
  //           )
  //         ],
  //       ),
  //     ),
  //   );
  // }

  // Widget rowWidget(
  //   String data, {
  //   IconData? icon,
  //   String? title,
  // }) {
  //   return Container(
  //     padding: const EdgeInsets.all(10.0),
  //     decoration: BoxDecoration(
  //       borderRadius: BorderRadius.circular(10.r),
  //       border: Border.all(
  //         color: Colors.black12,
  //       ),
  //     ),
  //     child: Row(
  //       children: [
  //         icon == null
  //             ? Text(
  //                 "${title!}: ",
  //                 style: getRegularStyle(Get.context!).copyWith(
  //                   fontWeight: FontWeight.w400,
  //                   fontSize: 14.r,
  //                 ),
  //               )
  //             : Icon(icon, color: primaryColor, size: 20.r),
  //         Gap(12),
  //         Expanded(
  //             flex: 2,
  //             child: Text(
  //               data,
  //               style: getRegularStyle(Get.context!).copyWith(
  //                   // fontWeight: FontWeight.w500,
  //                   color: blackColor),
  //             ))
  //       ],
  //     ),
  //   );
  // }

  // Widget rowWithArrow(IconData icon, String title, void Function() onPressed) {
  //   return Container(
  //     padding: const EdgeInsets.all(10.0),
  //     decoration: BoxDecoration(
  //       borderRadius: BorderRadius.circular(10.r),
  //       border: Border.all(
  //         color: Colors.black12,
  //       ),
  //     ),
  //     child: InkWell(
  //       onTap: onPressed,
  //       child: Row(
  //         children: [
  //           Icon(
  //             icon,
  //             color: primaryColor,
  //             size: 20.r,
  //           ),
  //           Gap(15),
  //           Text(
  //             title,
  //             style: getRegularStyle(Get.context!).copyWith(
  //               fontWeight: FontWeight.w400,
  //             ),
  //           ),
  //           Spacer(),
  //           InkWell(
  //               onTap: onPressed,
  //               child: Icon(
  //                 Icons.arrow_forward_ios_rounded,
  //                 size: 15.r,
  //                 color: primaryColor,
  //               ))
  //         ],
  //       ),
  //     ),
  //   );
  // }
}
