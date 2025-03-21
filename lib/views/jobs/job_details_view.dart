import 'package:b2b_partenership/app_routes.dart';
import 'package:b2b_partenership/core/services/app_prefs.dart';
import 'package:b2b_partenership/core/utils/assets_data.dart';
import 'package:flutter_svg/svg.dart';

import '/controller/jobs/job_details_controller.dart';
import '/core/enums/jobs_contract_type_enum.dart';
import '/core/functions/translate_database.dart';
import '/core/theme/app_color.dart';
import '/core/theme/text_style.dart';
import '/core/utils/font_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:readmore/readmore.dart';
import 'package:url_launcher/url_launcher_string.dart';

class JobDetailsView extends StatelessWidget {
  const JobDetailsView({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<JobDetailsController>(
      init: JobDetailsController(),
      builder: (JobDetailsController controller) {
        return Scaffold(
          floatingActionButton:
              Get.find<AppPreferences>().getUserRole() == "client"
                  ? FloatingActionButton.extended(
                      onPressed: () {
                        Get.toNamed(AppRoutes.jobApplication, arguments: {
                          "jobId": controller.jobDetailsModel?.id,
                        });
                      },
                      icon: Icon(
                        FontAwesomeIcons.briefcase,
                        color: whiteColor,
                      ),
                      label: Text(
                        "Apply Now".tr,
                        style: getLightStyle.copyWith(
                          color: whiteColor,
                          fontWeight: FontManager.semiBoldFontWeight,
                        ),
                      ),
                    )
                  : null,
          body: SafeArea(
            top: false,
            child: CustomScrollView(
              slivers: [
                SliverAppBar(
                  expandedHeight: 250.h,
                  floating: false,
                  pinned: true,
                  backgroundColor: primaryColor,
                  centerTitle: true,
                  iconTheme: const IconThemeData(color: whiteColor),
                  flexibleSpace: FlexibleSpaceBar(
                    collapseMode: CollapseMode.pin,
                    centerTitle: true,
                    title: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(
                          child: Text(
                            controller.jobDetailsModel?.name ?? "",
                            style: getRegularStyle.copyWith(
                              color: whiteColor,
                              fontWeight: FontManager.mediumFontWeight,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        if (Get.find<AppPreferences>().getUserRole() ==
                            "provider")
                          Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: 5.w,
                              vertical: 5.h,
                            ),
                            decoration: BoxDecoration(
                              color: whiteColor,
                              borderRadius: BorderRadius.circular(8),
                              // shape: BoxShape.circle,
                            ),
                            margin: EdgeInsetsDirectional.only(end: 10.w),
                            child: InkWell(
                              onTap: () {
                                Get.toNamed(
                                  AppRoutes.providerJobApplications,
                                  arguments: {
                                    "jobId": controller.jobDetailsModel?.id
                                        .toString(),
                                  },
                                );
                              },
                              child: Row(
                                children: [
                                  Text(
                                    "Show Applications".tr,
                                    style: getLightStyle.copyWith(
                                      fontSize: 8.sp,
                                      color: primaryColor,
                                      fontWeight: FontManager.mediumFontWeight,
                                    ),
                                  ),
                                  SvgPicture.asset(
                                    AssetsData.jobApplicationSVG,
                                    height: 15.sp,
                                  ),
                                ],
                              ),
                            ),
                          ),
                      ],
                    ),
                    background: Stack(
                      fit: StackFit.expand,
                      children: [
                        Image.network(
                          controller.jobDetailsModel?.image ?? "",
                          fit: BoxFit.cover,
                        ),
                        Container(
                          color: Colors.black.withAlpha(70),
                        ),
                      ],
                    ),
                  ),
                ),
                SliverPadding(
                  padding: const EdgeInsets.all(16.0),
                  sliver: SliverList(
                    delegate: SliverChildListDelegate(
                      [
                        _buildCard(
                          icon: FontAwesomeIcons.briefcase,
                          title: "Position".tr,
                          value: controller.jobDetailsModel?.title ?? "",
                        ),
                        _buildCard(
                          icon: FontAwesomeIcons.graduationCap,
                          title: "Specialization".tr,
                          value:
                              "${translateDatabase(arabic: controller.jobDetailsModel?.specializationNameAr ?? "", english: controller.jobDetailsModel?.specializationNameEn ?? "")}, ${translateDatabase(arabic: controller.jobDetailsModel?.subSpecializationNameAr ?? "", english: controller.jobDetailsModel?.subSpecializationNameEn ?? "")}",
                        ),
                        _buildCard(
                          icon: FontAwesomeIcons.fileLines,
                          title: "Description".tr,
                          value: controller.jobDetailsModel?.description ?? "",
                        ),
                        _buildCard(
                          icon: FontAwesomeIcons.briefcase,
                          title: "Contract Type".tr,
                          value:
                              controller.jobDetailsModel?.contractType.text ??
                                  "",
                        ),
                        _buildCard(
                          icon: FontAwesomeIcons.venusMars,
                          title: "Gender".tr,
                          value: controller.jobDetailsModel?.gender ?? "",
                        ),
                        _buildCard(
                          icon: FontAwesomeIcons.code,
                          title: "Skills Required".tr,
                          value: controller.jobDetailsModel?.skills ?? "",
                        ),
                        _buildCard(
                          icon: FontAwesomeIcons.userClock,
                          title: "Experience".tr,
                          value: controller.jobDetailsModel?.experience ?? "",
                        ),
                        _buildCard(
                          icon: FontAwesomeIcons.dollarSign,
                          title: "Salary".tr,
                          value: controller.jobDetailsModel!.salary == "null"
                              ? "N/A"
                              : controller.jobDetailsModel!.salary,
                        ),
                        _buildCard(
                          icon: FontAwesomeIcons.calendarDays,
                          title: "Expiry Date".tr,
                          value: controller.jobDetailsModel?.expiryDate ?? "",
                        ),
                        _buildCard(
                          icon: FontAwesomeIcons.locationDot,
                          title: "Address".tr,
                          value:
                              "${translateDatabase(arabic: controller.jobDetailsModel?.countryNameAr ?? "", english: controller.jobDetailsModel?.countryNameEn ?? "")}, ${translateDatabase(arabic: controller.jobDetailsModel?.governmentNameAr ?? "", english: controller.jobDetailsModel?.governmentNameEn ?? "")}",
                        ),
                        _buildCard(
                          icon: FontAwesomeIcons.building,
                          title: "Company".tr,
                          value: controller.jobDetailsModel?.name ?? "",
                        ),
                        _buildCard(
                          icon: FontAwesomeIcons.phone,
                          title: "Phone".tr,
                          value:
                              "+${controller.jobDetailsModel?.countryCode ?? ""} ${controller.jobDetailsModel?.phone ?? ""}",
                          isShowArrow: true,
                          arrowIcon: FontAwesomeIcons.phone,
                          onTap: () async {
                            try {
                              launchUrlString(
                                "tel:+${controller.jobDetailsModel?.countryCode ?? ""} ${controller.jobDetailsModel?.phone ?? ""}",
                              );
                            } catch (e) {
                              debugPrint(e.toString());
                            }
                          },
                        ),
                        _buildCard(
                          icon: FontAwesomeIcons.envelope,
                          title: "Email".tr,
                          value: controller.jobDetailsModel?.email ?? "",
                          isShowArrow: true,
                          arrowIcon: FontAwesomeIcons.envelope,
                          onTap: () async {
                            try {
                              await launchUrlString(
                                "mailto:${controller.jobDetailsModel?.email ?? ""}",
                              );
                            } catch (e) {
                              debugPrint(e.toString());
                            }
                          },
                        ),
                        _buildCard(
                          icon: FontAwesomeIcons.globe,
                          title: "Website".tr,
                          value:
                              controller.jobDetailsModel?.contactWebsite ?? "",
                          isShowArrow: true,
                          arrowIcon: FontAwesomeIcons.globe,
                          onTap: () async {
                            try {
                              launchUrlString(
                                controller.jobDetailsModel?.contactWebsite ??
                                    "",
                              );
                            } catch (e) {
                              debugPrint(e.toString());
                            }
                          },
                        ),
                        Gap(40.h),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  /// 🔷 **Reusable Card UI**
  Widget _buildCard({
    required IconData icon,
    required String title,
    required String value,
    void Function()? onTap,
    bool isShowArrow = false,
    IconData? arrowIcon,
    Color? arrowColor,
  }) {
    return Card(
      elevation: 4,
      margin: EdgeInsets.symmetric(vertical: 8.h),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ListTile(
        leading: Icon(
          icon,
          color: primaryColor,
          size: 20.sp,
        ),
        title: Text(
          title,
          style: getRegularStyle.copyWith(
            fontWeight: FontManager.boldFontWeight,
          ),
        ),
        subtitle: ReadMoreText(
          value,
          style: getRegularStyle,
          trimLines: 4,
          colorClickableText: primaryColor,
          trimMode: TrimMode.Line,
          trimCollapsedText: 'See more'.tr,
          trimExpandedText: 'See less'.tr,
        ),
        trailing: isShowArrow
            ? IconButton(
                onPressed: onTap,
                icon: Icon(
                  arrowIcon ?? Icons.arrow_forward_ios_rounded,
                  color: arrowColor ?? primaryColor,
                  size: 16.sp,
                ),
              )
            : null,
      ),
    );
  }
}
