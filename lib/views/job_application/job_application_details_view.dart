import 'package:b2b_partenership/controller/job_application/job_application_details_controller.dart';
import 'package:b2b_partenership/core/enums/jobs_contract_type_enum.dart';
import 'package:b2b_partenership/core/theme/app_color.dart';
import 'package:b2b_partenership/core/theme/text_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:readmore/readmore.dart';

class JobApplicationDetailsView extends StatelessWidget {
  const JobApplicationDetailsView({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<JobApplicationDetailsController>(
      init: JobApplicationDetailsController(),
      builder: (JobApplicationDetailsController controller) {
        return Scaffold(
          appBar: AppBar(
            backgroundColor: primaryColor,
            iconTheme: IconThemeData(color: whiteColor),
            title: Text(
              controller.model?.jobTitle ?? "",
              style: TextStyle(
                color: whiteColor,
              ),
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
                  _buildJobInfo(controller),
                  SizedBox(height: 20),
                  _buildApplicantInfo(controller),
                  SizedBox(height: 20),
                  _buildProviderInfo(controller),
                  SizedBox(height: 30),
                  _buildStatusBadge(controller.model?.applicationStatus ?? ""),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildJobInfo(JobApplicationDetailsController controller) {
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
              style: getSemiBoldStyle.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 5.h),
            Text(
              "${controller.model?.jobContractType.text} | Gender: ${controller.model?.jobGender}",
              style: getLightStyle.copyWith(
                color: darkGreyColor,
                fontWeight: FontWeight.w400,
              ),
            ),
            SizedBox(height: 10.h),
            ReadMoreText(
              controller.model?.jobDescription ?? "",
              style: getLightStyle.copyWith(
                color: blackColor,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildApplicantInfo(JobApplicationDetailsController controller) {
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Applicant Info",
              style: getRegularStyle.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 5.h),
            _buildInfoRow(
              "Years of Experience",
              controller.model?.yearsOfExperience ?? "",
            ),
            Divider(),
            _buildInfoRow(
              "Expected Salary",
              "\$${controller.model!.expectedSalary}",
            ),
            Divider(),
            _buildInfoRow(
              "Available Start Date",
              controller.model?.availableToStartDate ?? "",
            ),
            Divider(),
            _buildInfoRow(
              "Skills",
              controller.model?.jobSkills ?? "",
            ),
            Divider(),
            _buildInfoRow(
              "Why Ideal?",
              controller.model?.whyIdealCandidate ?? "",
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProviderInfo(JobApplicationDetailsController controller) {
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
                      style: getMediumStyle.copyWith(
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
              "Phone",
              "+${controller.model?.providerCountryCode ?? ""} ${controller.model?.providerPhone ?? ""}",
            ),
            _buildInfoRow(
              "Rating",
              "⭐ ${double.parse(controller.model?.providerRating ?? "0")}",
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(String title, String value) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 4.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: getLightStyle.copyWith(
              fontWeight: FontWeight.w500,
            ),
          ),
          Gap(10.w),
          Expanded(
            child: ReadMoreText(
              value,
              trimLines: 1,
              style: getLightStyle.copyWith(
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

  Widget _buildStatusBadge(String status) {
    Color statusColor;
    if (status == "pending") {
      statusColor = orangColor;
    } else if (status == "approved") {
      statusColor = greenColor;
    } else {
      statusColor = redColor;
    }

    return Center(
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 8.h, horizontal: 16.w),
        margin: EdgeInsets.only(bottom: 12.h),
        decoration: BoxDecoration(
          color: statusColor.withAlpha(20),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Text(
          status.toUpperCase(),
          style: getLightStyle.copyWith(
            color: statusColor,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
