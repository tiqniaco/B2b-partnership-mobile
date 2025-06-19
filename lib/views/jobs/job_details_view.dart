import 'package:b2b_partenership/app_routes.dart';
import 'package:b2b_partenership/core/services/app_prefs.dart';
import 'package:b2b_partenership/core/theme/themes.dart';
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

class JobDetailsView extends StatefulWidget {
  const JobDetailsView({super.key});

  @override
  State<JobDetailsView> createState() => _JobDetailsViewState();
}

class _JobDetailsViewState extends State<JobDetailsView> {
  final ScrollController _scrollController = ScrollController();
  bool _isExpanded = true;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_scrollListener);
  }

  void _scrollListener() {
    // height اللي بيحصل فيه التغيير ما بين expanded و collapsed
    if (_scrollController.hasClients) {
      bool isNowExpanded = _scrollController.offset < 200;
      if (isNowExpanded != _isExpanded) {
        setState(() {
          _isExpanded = isNowExpanded;
        });
      }
    }
  }

  @override
  void dispose() {
    _scrollController.removeListener(_scrollListener);
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<JobDetailsController>(
      init: JobDetailsController(),
      builder: (JobDetailsController controller) {
        return Scaffold(
          floatingActionButton: Get.find<AppPreferences>().getUserId() !=
                  controller.jobDetailsModel?.employerId
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
                    style: getLightStyle(context).copyWith(
                      color: whiteColor,
                      fontWeight: FontManager.semiBoldFontWeight,
                    ),
                  ),
                )
              : SizedBox(
                  width: 200,
                  height: 50,
                  child: Container(
                    alignment: Alignment.center,
                    padding: EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 8,
                    ),
                    decoration: BoxDecoration(
                      color: primaryColor,

                      //border: Border.all(color: primaryColor),
                      borderRadius: customBorderRadius,
                    ),
                    margin: EdgeInsetsDirectional.only(end: 10.w),
                    child: InkWell(
                      onTap: () {
                        Get.toNamed(
                          AppRoutes.providerJobApplications,
                          arguments: {
                            "jobId": controller.jobDetailsModel?.id.toString(),
                          },
                        );
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Show Applications".tr,
                            style: getLightStyle(context).copyWith(
                              fontSize: 12.r,
                              color: whiteColor,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Gap(5),
                          SvgPicture.asset(
                            AssetsData.jobApplicationSVG,
                            height: 20,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
          body: SafeArea(
            top: false,
            child: CustomScrollView(
              controller: _scrollController,
              slivers: [
                SliverAppBar(
                  expandedHeight: context.isTablet ? 300.h : 250.h,
                  floating: false,
                  pinned: true,
                  centerTitle: true,
                  iconTheme: IconThemeData(
                    color: _isExpanded ? whiteColor : Colors.black,
                  ),
                  backgroundColor: Colors.white,
                  flexibleSpace: FlexibleSpaceBar(
                    collapseMode: CollapseMode.pin,
                    centerTitle: true,
                    title: Text(
                      controller.jobDetailsModel?.name ?? "",
                      style: getRegularStyle(context).copyWith(
                        color: _isExpanded ? whiteColor : Colors.black,
                        fontWeight: FontManager.mediumFontWeight,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    background: Stack(
                      fit: StackFit.expand,
                      children: [
                        Image.network(
                          controller.jobDetailsModel?.image ?? "",
                          fit: BoxFit.fitWidth,
                        ),
                        Container(
                          color: Colors.black.withAlpha(70),
                        ),
                      ],
                    ),
                  ),
                ),
                // باقي السليفر ليست زي ما هي...
                SliverPadding(
                  padding: const EdgeInsets.all(16.0),
                  sliver: SliverList(
                    delegate: SliverChildListDelegate(
                      [
                        _buildCard(
                          context: context,
                          icon: FontAwesomeIcons.briefcase,
                          title: "Position".tr,
                          value: controller.jobDetailsModel?.title ?? "",
                        ),
                        _buildCard(
                          context: context,
                          icon: FontAwesomeIcons.graduationCap,
                          title: "Specialization".tr,
                          value:
                              "${translateDatabase(arabic: controller.jobDetailsModel?.specializationNameAr ?? "", english: controller.jobDetailsModel?.specializationNameEn ?? "")}, ${translateDatabase(arabic: controller.jobDetailsModel?.subSpecializationNameAr ?? "", english: controller.jobDetailsModel?.subSpecializationNameEn ?? "")}",
                        ),
                        _buildCard(
                          context: context,
                          icon: FontAwesomeIcons.fileLines,
                          title: "Description".tr,
                          value: controller.jobDetailsModel?.description ?? "",
                        ),
                        _buildCard(
                          context: context,
                          icon: FontAwesomeIcons.briefcase,
                          title: "Contract Type".tr,
                          value:
                              controller.jobDetailsModel?.contractType.value ??
                                  "",
                        ),
                        _buildCard(
                          context: context,
                          icon: FontAwesomeIcons.venusMars,
                          title: "Gender".tr,
                          value: controller.jobDetailsModel?.gender ?? "",
                        ),
                        _buildCard(
                          context: context,
                          icon: FontAwesomeIcons.code,
                          title: "Skills Required".tr,
                          value: controller.jobDetailsModel?.skills ?? "",
                        ),
                        _buildCard(
                          context: context,
                          icon: FontAwesomeIcons.userClock,
                          title: "Experience".tr,
                          value: controller.jobDetailsModel?.experience ?? "",
                        ),
                        _buildCard(
                          context: context,
                          icon: FontAwesomeIcons.dollarSign,
                          title: "Salary".tr,
                          value: controller.jobDetailsModel!.salary == "null"
                              ? "N/A"
                              : controller.jobDetailsModel!.salary,
                        ),
                        _buildCard(
                          context: context,
                          icon: FontAwesomeIcons.calendarDays,
                          title: "Expiry Date".tr,
                          value: controller.jobDetailsModel?.expiryDate ?? "",
                        ),
                        _buildCard(
                          context: context,
                          icon: FontAwesomeIcons.locationDot,
                          title: "Address".tr,
                          value:
                              "${translateDatabase(arabic: controller.jobDetailsModel?.countryNameAr ?? "", english: controller.jobDetailsModel?.countryNameEn ?? "")}, ${translateDatabase(arabic: controller.jobDetailsModel?.governmentNameAr ?? "", english: controller.jobDetailsModel?.governmentNameEn ?? "")}",
                        ),
                        _buildCard(
                          context: context,
                          icon: FontAwesomeIcons.building,
                          title: "Company".tr,
                          value: controller.jobDetailsModel?.name ?? "",
                        ),
                        _buildCard(
                          context: context,
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
                          context: context,
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

  Widget _buildCard({
    required BuildContext context,
    required IconData icon,
    required String title,
    required String value,
    void Function()? onTap,
    bool isShowArrow = false,
    IconData? arrowIcon,
    Color? arrowColor,
  }) {
    return Card(
      elevation: 0.5,
      margin: EdgeInsets.symmetric(vertical: 6),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ListTile(
        leading: Icon(
          icon,
          color: primaryColor,
          size: 20.r,
        ),
        title: Text(
          title,
          style: getRegularStyle(context).copyWith(
            fontWeight: FontManager.boldFontWeight,
          ),
        ),
        subtitle: ReadMoreText(
          value,
          style: getRegularStyle(context),
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
                  size: 16.r,
                ),
              )
            : null,
      ),
    );
  }
}

class JobetailsView extends StatelessWidget {
  const JobetailsView({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<JobDetailsController>(
      init: JobDetailsController(),
      builder: (JobDetailsController controller) {
        return Scaffold(
          floatingActionButton: Get.find<AppPreferences>().getUserId() !=
                  controller.jobDetailsModel?.employerId
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
                    style: getLightStyle(context).copyWith(
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
                  expandedHeight: context.isTablet ? 300.h : 250.h,
                  floating: false,
                  pinned: true,
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
                            style: getRegularStyle(context).copyWith(
                              color: whiteColor,
                              fontWeight: FontManager.mediumFontWeight,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        if (Get.find<AppPreferences>().getUserId() ==
                            controller.jobDetailsModel?.employerId)
                          Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: 5.w,
                              vertical: 5.h,
                            ),
                            decoration: BoxDecoration(
                              color: whiteColor,
                              borderRadius: BorderRadius.circular(8),
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
                                    style: getLightStyle(context).copyWith(
                                      fontSize: context.isTablet ? 4.sp : 8.sp,
                                      color: primaryColor,
                                      fontWeight: FontManager.mediumFontWeight,
                                    ),
                                  ),
                                  SvgPicture.asset(
                                    AssetsData.jobApplicationSVG,
                                    height: 15.w,
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
                          fit: BoxFit.fitWidth,
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
                          context: context,
                          icon: FontAwesomeIcons.briefcase,
                          title: "Position".tr,
                          value: controller.jobDetailsModel?.title ?? "",
                        ),
                        _buildCard(
                          context: context,
                          icon: FontAwesomeIcons.graduationCap,
                          title: "Specialization".tr,
                          value:
                              "${translateDatabase(arabic: controller.jobDetailsModel?.specializationNameAr ?? "", english: controller.jobDetailsModel?.specializationNameEn ?? "")}, ${translateDatabase(arabic: controller.jobDetailsModel?.subSpecializationNameAr ?? "", english: controller.jobDetailsModel?.subSpecializationNameEn ?? "")}",
                        ),
                        _buildCard(
                          context: context,
                          icon: FontAwesomeIcons.fileLines,
                          title: "Description".tr,
                          value: controller.jobDetailsModel?.description ?? "",
                        ),
                        _buildCard(
                          context: context,
                          icon: FontAwesomeIcons.briefcase,
                          title: "Contract Type".tr,
                          value:
                              controller.jobDetailsModel?.contractType.value ??
                                  "",
                        ),
                        _buildCard(
                          context: context,
                          icon: FontAwesomeIcons.venusMars,
                          title: "Gender".tr,
                          value: controller.jobDetailsModel?.gender ?? "",
                        ),
                        _buildCard(
                          context: context,
                          icon: FontAwesomeIcons.code,
                          title: "Skills Required".tr,
                          value: controller.jobDetailsModel?.skills ?? "",
                        ),
                        _buildCard(
                          context: context,
                          icon: FontAwesomeIcons.userClock,
                          title: "Experience".tr,
                          value: controller.jobDetailsModel?.experience ?? "",
                        ),
                        _buildCard(
                          context: context,
                          icon: FontAwesomeIcons.dollarSign,
                          title: "Salary".tr,
                          value: controller.jobDetailsModel!.salary == "null"
                              ? "N/A"
                              : controller.jobDetailsModel!.salary,
                        ),
                        _buildCard(
                          context: context,
                          icon: FontAwesomeIcons.calendarDays,
                          title: "Expiry Date".tr,
                          value: controller.jobDetailsModel?.expiryDate ?? "",
                        ),
                        _buildCard(
                          context: context,
                          icon: FontAwesomeIcons.locationDot,
                          title: "Address".tr,
                          value:
                              "${translateDatabase(arabic: controller.jobDetailsModel?.countryNameAr ?? "", english: controller.jobDetailsModel?.countryNameEn ?? "")}, ${translateDatabase(arabic: controller.jobDetailsModel?.governmentNameAr ?? "", english: controller.jobDetailsModel?.governmentNameEn ?? "")}",
                        ),
                        _buildCard(
                          context: context,
                          icon: FontAwesomeIcons.building,
                          title: "Company".tr,
                          value: controller.jobDetailsModel?.name ?? "",
                        ),
                        _buildCard(
                          context: context,
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
                          context: context,
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

  Widget _buildCard({
    required BuildContext context,
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
          size: 20.r,
        ),
        title: Text(
          title,
          style: getRegularStyle(context).copyWith(
            fontWeight: FontManager.boldFontWeight,
          ),
        ),
        subtitle: ReadMoreText(
          value,
          style: getRegularStyle(context),
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
                  size: 16.r,
                ),
              )
            : null,
      ),
    );
  }
}
