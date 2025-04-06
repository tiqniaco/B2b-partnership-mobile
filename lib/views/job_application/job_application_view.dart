import 'package:b2b_partenership/controller/job_application/job_application_controller.dart';
import 'package:b2b_partenership/core/global/widgets/custom_loading_button.dart';
import 'package:b2b_partenership/core/theme/app_color.dart';
import 'package:b2b_partenership/core/theme/text_style.dart';
import 'package:b2b_partenership/core/utils/font_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class JobApplicationView extends StatelessWidget {
  const JobApplicationView({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<JobApplicationController>(
      init: JobApplicationController(),
      builder: (JobApplicationController controller) {
        return Scaffold(
          appBar: AppBar(
            titleSpacing: 0,
            iconTheme: IconThemeData(color: whiteColor),
            // leading: IconButton(
            //   icon: Icon(
            //     Icons.arrow_back_ios_new,
            //     size: 20.r,
            //   ),
            //   onPressed: () {
            //     Get.back();
            //   },
            // ),
            backgroundColor: primaryColor,
            title: Text(
              'Job Application'.tr,
              style: TextStyle(
                color: whiteColor,
              ),
            ),
          ),
          body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              key: controller.formKey,
              child: ListView(
                children: [
                  _buildTextField(
                    context: context,
                    label: "Years of Experience".tr,
                    hint: "ex: 2".tr,
                    maxLines: 1,
                    formatter: FilteringTextInputFormatter.digitsOnly,
                    controller: controller.yearsOfExperienceController,
                    keyboardType: TextInputType.number,
                  ),
                  _buildTextField(
                    context: context,
                    label: "Cover Letter".tr,
                    hint: "enter your cover letter".tr,
                    formatter: FilteringTextInputFormatter.allow(
                      RegExp(
                        r"^[\u0600-\u06FF\u0750-\u077F\u08A0-\u08FF\uFB50-\uFDFF\uFE70-\uFEFFa-zA-Z0-9.,!?()'\"
                        r"\s\n-]{0,1000}$",
                        unicode: false,
                      ),
                    ),
                    controller: controller.coverLetterController,
                    keyboardType: TextInputType.multiline,
                    maxLines: null,
                  ),
                  _buildTextField(
                    context: context,
                    label: "Skills".tr,
                    hint: "enter your skills".tr,
                    formatter: FilteringTextInputFormatter.allow(
                      RegExp(
                        r"^[\u0600-\u06FF\u0750-\u077F\u08A0-\u08FF\uFB50-\uFDFF\uFE70-\uFEFFa-zA-Z0-9\s,-]{0,1000}$",
                      ),
                    ),
                    controller: controller.skillsController,
                    keyboardType: TextInputType.text,
                  ),
                  _buildTextField(
                    context: context,
                    label: "Available to Start Date".tr,
                    hint: "enter your available to start date".tr,
                    controller: controller.availableToStartDateController,
                    keyboardType: TextInputType.text,
                    maxLines: 1,
                    readOnly: true,
                    onTap: () async {
                      await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(2000),
                        lastDate: DateTime(2050),
                      ).then((value) {
                        if (value != null) {
                          controller.availableToStartDateController.text =
                              DateFormat("yyyy-MM-dd").format(value);
                        }
                      });
                    },
                  ),
                  _buildTextField(
                    context: context,
                    label: "Expected Salary".tr,
                    formatter: FilteringTextInputFormatter.digitsOnly,
                    hint: "enter your expected salary (numbers only)".tr,
                    controller: controller.expectedSalaryController,
                    keyboardType: TextInputType.number,
                  ),
                  _buildTextField(
                    context: context,
                    label:
                        "What makes you the ideal candidate for this position?"
                            .tr,
                    hint: "enter your answer".tr,
                    formatter: FilteringTextInputFormatter.allow(
                      RegExp(
                        r"^[\u0600-\u06FF\u0750-\u077F\u08A0-\u08FF\uFB50-\uFDFF\uFE70-\uFEFFa-zA-Z0-9.,!?()'\"
                        r"\s\n-]{0,1000}$",
                        unicode: true,
                      ),
                    ),
                    controller: controller.whyIdealCandidateController,
                    keyboardType: TextInputType.multiline,
                    maxLines: null,
                  ),
                  _buildResumeUpload(controller, context),
                  Gap(20.h),
                  CustomLoadingButton(
                    text: 'Submit Application'.tr,
                    onPressed: () {
                      return controller.submit();
                    },
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildTextField({
    required BuildContext context,
    required String label,
    required String hint,
    required TextEditingController controller,
    required TextInputType keyboardType,
    TextInputFormatter? formatter,
    int? maxLines = 1,
    bool enabled = true,
    bool readOnly = false,
    Function()? onTap,
  }) {
    return Container(
      margin: EdgeInsets.only(bottom: 14.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: getLightStyle(context).copyWith(
              fontWeight: FontManager.semiBoldFontWeight,
            ),
          ),
          Gap(2.h),
          TextFormField(
            enabled: enabled,
            readOnly: readOnly,
            inputFormatters: [if (formatter != null) formatter],
            controller: controller,
            keyboardType: keyboardType,
            maxLines: maxLines,
            decoration: InputDecoration(
              hintText: hint,
              hintStyle: getLightStyle(context).copyWith(
                color: greyColor,
              ),
            ),
            onTap: onTap,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter $label';
              }
              return null;
            },
          ),
        ],
      ),
    );
  }

  Widget _buildResumeUpload(
      JobApplicationController controller, BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Upload Resume".tr,
            style: getLightStyle(context).copyWith(
              fontWeight: FontManager.semiBoldFontWeight,
            ),
          ),
          SizedBox(height: 10),
          Row(
            children: [
              ElevatedButton(
                onPressed: () {
                  controller.pickResume();
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: primaryColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                  fixedSize: Size(120.w, 35.h),
                ),
                child: Text(
                  "Choose File".tr,
                  style: getRegularStyle(context).copyWith(
                    color: whiteColor,
                  ),
                ),
              ),
              Gap(10.w),
              if (controller.resumeFile != null)
                Text(
                  controller.resumeFile?.path.split('/').last ?? '',
                  style: getLightStyle(context).copyWith(
                    color: primaryColor,
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }
}
