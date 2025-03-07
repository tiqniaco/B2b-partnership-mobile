import 'package:b2b_partenership/core/enums/jobs_contract_type_enum.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '/app_routes.dart';
import '/core/global/widgets/custom_network_image.dart';
import '/core/theme/app_color.dart';
import '/core/theme/text_style.dart';
import '/core/utils/font_manager.dart';
import '/models/job_details_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

class JobWidget extends StatelessWidget {
  const JobWidget({
    super.key,
    required this.model,
    this.onTapDelete,
    this.hasDelete = false,
  });
  final JobDetailsModel model;
  final bool hasDelete;
  final void Function()? onTapDelete;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Get.toNamed(
          AppRoutes.jobDetails,
          arguments: {
            "job": model,
          },
        );
      },
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: 16.w,
          vertical: 10.h,
        ),
        decoration: BoxDecoration(
          color: whiteColor,
          border: Border.all(color: borderColor),
          borderRadius: BorderRadius.circular(8.r),
        ),
        child: Row(
          children: [
            CircleAvatar(
              backgroundColor: whiteColor,
              radius: 35.r,
              child: CustomNetworkImage(
                imageUrl: model.image,
                fit: BoxFit.contain,
                shape: BoxShape.circle,
              ),
            ),
            Gap(12.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Company: ${model.name}",
                        style: getRegularStyle.copyWith(
                          fontWeight: FontManager.mediumFontWeight,
                        ),
                      ),
                      if (hasDelete)
                        InkWell(
                          onTap: () {
                            if (onTapDelete != null) {
                              onTapDelete!();
                            }
                          },
                          child: Container(
                            padding: const EdgeInsets.all(5),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: primaryColor,
                            ),
                            child: Icon(
                              FontAwesomeIcons.xmark,
                              size: 16.sp,
                              color: whiteColor,
                            ),
                          ),
                        ),
                    ],
                  ),
                  Gap(5.h),
                  Text(
                    "Job Title: ${model.title}",
                    style: getRegularStyle.copyWith(
                      fontWeight: FontManager.mediumFontWeight,
                    ),
                  ),
                  Gap(5.h),
                  Text(
                    "Contract Type: ${model.contractType.text}",
                    style: getLightStyle,
                  ),
                  Gap(5.h),
                  Text(
                    "Expiry Date: ${model.expiryDate}",
                    style: getLightStyle,
                  ),
                  if (model.salary != "null") ...[
                    Gap(5.h),
                    Text(
                      "Salary: ${model.salary}",
                      style: getLightStyle,
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
}
