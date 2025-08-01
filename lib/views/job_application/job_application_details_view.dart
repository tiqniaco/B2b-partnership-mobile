import 'package:b2b_partenership/controller/job_application/job_application_details_controller.dart';
import 'package:b2b_partenership/core/enums/job_application_status_enum.dart';
import 'package:b2b_partenership/core/enums/job_gender_enum.dart';
import 'package:b2b_partenership/core/enums/jobs_contract_type_enum.dart';
import 'package:b2b_partenership/core/services/app_prefs.dart';
import 'package:b2b_partenership/core/theme/app_color.dart';
import 'package:b2b_partenership/core/theme/text_style.dart';
import 'package:b2b_partenership/core/theme/themes.dart';
import 'package:b2b_partenership/core/utils/app_snack_bars.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:readmore/readmore.dart';
import 'package:url_launcher/url_launcher_string.dart';

class JobApplicationDetailsView extends StatelessWidget {
  const JobApplicationDetailsView({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<JobApplicationDetailsController>(
      init: JobApplicationDetailsController(),
      builder: (JobApplicationDetailsController controller) {
        return Scaffold(
          appBar: AppBar(
            // backgroundColor: primaryColor,
            // iconTheme: IconThemeData(color: whiteColor),
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  controller.model?.jobTitle ?? "",
                  style: TextStyle(
                    color: blackColor,
                  ),
                ),
                if (controller.showStatus)
                  _buildStatusBadge(
                    controller.model?.applicationStatus ??
                        JobApplicationStatusEnum.pending,
                  ),
              ],
            ),
          ),
          body: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 16.w,
              vertical: 10.h,
            ),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildJobInfo(controller, context),
                  SizedBox(height: 8.h),
                  _buildApplicantInfo(controller, context),
                  SizedBox(height: 8.h),
                  Get.find<AppPreferences>().getUserId() ==
                          controller.model?.clientUserId
                      ? _buildProviderInfo(controller, context)
                      : _buildClientInfo(controller, context),
                  SizedBox(height: 10.h),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildJobInfo(
    JobApplicationDetailsController controller,
    BuildContext context,
  ) {
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              controller.model?.jobTitle ?? "",
              style: getSemiBoldStyle(context).copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 5.h),
            Text(
              "${controller.model?.jobContractType.text} | ${"Gender".tr}: ${controller.model?.jobGender.text}",
              style: getLightStyle(context).copyWith(
                color: darkGreyColor,
                fontWeight: FontWeight.w400,
              ),
            ),
            SizedBox(height: 10.h),
            ReadMoreText(
              controller.model?.jobDescription ?? "",
              style: getLightStyle(context).copyWith(
                color: blackColor,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildApplicantInfo(
      JobApplicationDetailsController controller, BuildContext context) {
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Applicant Info".tr,
              style: getRegularStyle(context).copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 5.h),
            _buildInfoRow(
              "Years of Experience".tr,
              controller.model?.yearsOfExperience ?? "",
              context: context,
            ),
            Divider(),
            _buildInfoRow(
              "Expected Salary".tr,
              "\$${controller.model!.expectedSalary}",
              context: context,
            ),
            Divider(),
            _buildInfoRow(
              "Available Start Date".tr,
              controller.model?.availableToStartDate ?? "",
              context: context,
            ),
            Divider(),
            _buildInfoRow(
              "Skills".tr,
              controller.model?.jobSkills ?? "",
              context: context,
            ),
            Divider(),
            _buildInfoRow(
              "Why Ideal?".tr,
              controller.model?.whyIdealCandidate ?? "",
              context: context,
            ),
            Divider(),
            _buildInfoRow(
              "Cover Letter".tr,
              controller.model?.coverLetter ?? "",
              context: context,
            ),
            Divider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Resume".tr,
                  style: getLightStyle(context).copyWith(
                    fontWeight: FontWeight.w500,
                  ),
                ),
                TextButton.icon(
                  onPressed: () async {
                    if (await canLaunchUrlString(
                        controller.model?.resume ?? "")) {
                      launchUrlString(controller.model?.resume ?? "");
                    } else {
                      AppSnackBars.warning(message: "Resume not found".tr);
                    }
                  },
                  label: Text("Preview".tr),
                  icon: Icon(
                    FontAwesomeIcons.eye,
                    size: 13.sp,
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProviderInfo(
      JobApplicationDetailsController controller, BuildContext context) {
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CircleAvatar(
                  backgroundImage: NetworkImage(
                    controller.model?.providerImage ?? "",
                  ),
                  radius: 28.r,
                ),
                SizedBox(width: 10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      controller.model?.providerName ?? "",
                      style: getMediumStyle(context).copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      controller.model?.providerEmail ?? "",
                      style: TextStyle(
                        color: darkGreyColor,
                      ),
                    ),
                  ],
                )
              ],
            ),
            SizedBox(height: 10.h),
            _buildInfoRow(
              "Phone".tr,
              "+${controller.model?.providerCountryCode ?? ""} ${controller.model?.providerPhone ?? ""}",
              context: context,
            ),
            _buildInfoRow(
                "Rating".tr, "⭐ ${controller.model?.providerRating ?? "0.0"}",
                context: context),
          ],
        ),
      ),
    );
  }

  Widget _buildClientInfo(
      JobApplicationDetailsController controller, BuildContext context) {
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "More Info".tr,
              style: getRegularStyle(context).copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            Row(
              children: [
                CircleAvatar(
                  backgroundImage: NetworkImage(
                    controller.model?.clientImage ?? "",
                  ),
                  radius: 35.r,
                ),
                SizedBox(width: 12.w),
                Expanded(
                  child: Column(
                    children: [
                      SizedBox(height: 5.h),
                      _buildClientInfoRow(
                          "Name".tr, controller.model?.clientName ?? "",
                          context: context),
                      Divider(),
                      _buildClientInfoRow(
                        "Email".tr,
                        controller.model?.clientEmail ?? "",
                        icon: FontAwesomeIcons.envelope,
                        context: context,
                        onTap: () {
                          if (controller.model?.clientEmail != null) {
                            launchUrlString(
                              "mailto:${controller.model?.clientEmail}",
                            );
                          }
                        },
                      ),
                      Divider(),
                      _buildClientInfoRow(
                        "Phone".tr,
                        "+${controller.model?.clientCountryCode ?? ""} ${controller.model?.clientPhone ?? ""}",
                        icon: FontAwesomeIcons.phone,
                        context: context,
                        onTap: () {
                          if (controller.model?.clientPhone != null) {
                            launchUrlString(
                              "tel:+${controller.model?.clientCountryCode}${controller.model?.clientPhone}",
                            );
                          }
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(
    String title,
    String value, {
    required BuildContext context,
  }) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 4.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: getLightStyle(context).copyWith(
              fontWeight: FontWeight.w500,
            ),
          ),
          Gap(10.w),
          Expanded(
            child: ReadMoreText(
              value,
              trimLines: 1,
              style: getLightStyle(context).copyWith(
                fontWeight: FontWeight.w400,
                color: Colors.black87,
                fontSize: 10.sp,
              ),
              textAlign: TextAlign.end,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatusBadge(JobApplicationStatusEnum status) {
    return Center(
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 8.h, horizontal: 16.w),
        margin: EdgeInsets.only(bottom: 12.h),
        decoration: BoxDecoration(
          color: primaryColor,
          borderRadius: customBorderRadius,
        ),
        child: Text(
          status.name.tr,
          style: getLightStyle(Get.context!).copyWith(
            color: whiteColor,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  Widget _buildClientInfoRow(
    String title,
    String value, {
    void Function()? onTap,
    IconData? icon,
    required BuildContext context,
  }) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 4.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: getLightStyle(context).copyWith(
              fontWeight: FontWeight.w500,
            ),
          ),
          Gap(10.w),
          Expanded(
            child: ReadMoreText(
              value,
              trimLines: 1,
              style: getLightStyle(context).copyWith(
                fontWeight: FontWeight.w400,
                color: Colors.black87,
                fontSize: 10.sp,
              ),
              textAlign: TextAlign.end,
            ),
          ),
          if (onTap != null) ...[
            Gap(10.w),
            InkWell(
              onTap: onTap,
              child: Icon(
                icon ?? Icons.arrow_forward_ios,
                color: Colors.black54,
                size: 15.sp,
              ),
            )
          ],
        ],
      ),
    );
  }
}
