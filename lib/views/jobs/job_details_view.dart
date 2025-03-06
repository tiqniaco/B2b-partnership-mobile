import 'package:b2b_partenership/app_routes.dart';

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
          floatingActionButton: FloatingActionButton.extended(
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
          ),
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
                    title: Text(
                      controller.jobDetailsModel?.name ?? "",
                      style: getRegularStyle.copyWith(
                        color: whiteColor,
                        fontWeight: FontManager.mediumFontWeight,
                      ),
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
                            if (await canLaunchUrlString(
                              "tel:+${controller.jobDetailsModel?.countryCode ?? ""} ${controller.jobDetailsModel?.phone ?? ""}",
                            )) {
                              launchUrlString(
                                "tel:+${controller.jobDetailsModel?.countryCode ?? ""} ${controller.jobDetailsModel?.phone ?? ""}",
                              );
                            }
                          },
                        ),
                        _buildCard(
                          icon: FontAwesomeIcons.envelope,
                          title: "Email",
                          value: controller.jobDetailsModel?.email ?? "",
                          isShowArrow: true,
                          arrowIcon: FontAwesomeIcons.envelope,
                          onTap: () async {
                            if (await canLaunchUrlString(
                              "mailto:${controller.jobDetailsModel?.email ?? ""}",
                            )) {
                              launchUrlString(
                                "mailto:${controller.jobDetailsModel?.email ?? ""}",
                              );
                            }
                          },
                        ),
                        _buildCard(
                          icon: FontAwesomeIcons.globe,
                          title: "Website",
                          value:
                              controller.jobDetailsModel?.contactWebsite ?? "",
                          isShowArrow: true,
                          arrowIcon: FontAwesomeIcons.globe,
                          onTap: () async {
                            if (await canLaunchUrlString(
                              controller.jobDetailsModel?.contactWebsite ?? "",
                            )) {
                              launchUrlString(
                                controller.jobDetailsModel?.contactWebsite ??
                                    "",
                              );
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
          trimCollapsedText: 'Show more'.tr,
          trimExpandedText: 'Show less'.tr,
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
