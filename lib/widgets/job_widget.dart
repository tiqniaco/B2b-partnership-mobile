import 'package:b2b_partenership/core/enums/jobs_contract_type_enum.dart';
import 'package:b2b_partenership/core/functions/please_login_dialog.dart';
import 'package:b2b_partenership/core/services/app_prefs.dart';
import 'package:b2b_partenership/core/theme/themes.dart';
import 'package:flutter/cupertino.dart';

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
    this.hasEdit = false,
  });
  final JobDetailsModel model;
  final bool hasDelete;
  final void Function()? onTapDelete;
  final bool hasEdit;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: Get.find<AppPreferences>().getToken() == ''
          ? () {
              pleaseLoginDialog();
            }
          : () {
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
          color: lightPrimaryColor.withAlpha(130),
          border: Border.all(color: borderColor.withAlpha(50)),
          borderRadius: BorderRadius.circular(20.r),
        ),
        child: Row(
          children: [
            Column(
              children: [
                Container(
                  decoration:
                      BoxDecoration(color: whiteColor, shape: BoxShape.circle),
                  child: CustomNetworkImage(
                    imageUrl: model.image,
                    height: 90.r,
                    fit: BoxFit.cover,
                    shape: BoxShape.circle,
                  ),
                ),
                Gap(4),
                Text(
                  model.name,
                  style: getBoldStyle(context).copyWith(
                      fontWeight: FontManager.boldFontWeight, fontSize: 14.r),
                ),
              ],
            ),
            Gap(12.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  rowWidget("Job Title".tr, model.title, context),
                  Gap(5),
                  rowWidget(
                      "Contract Type".tr, model.contractType.text, context),
                  Gap(5),
                  rowWidget("Expiry Date".tr, model.expiryDate, context),
                  if (model.salary != "null") ...[
                    Gap(5),
                    rowWidget("Salary:".tr, model.salary, context),
                  ],
                  Gap(10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                        decoration: BoxDecoration(
                          color: primaryColor,
                          borderRadius: customBorderRadius,
                        ),
                        child: Text(
                          "View Now".tr,
                          style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 12.r,
                              color: Colors.white),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (hasDelete)
                  InkWell(
                    onTap: () {
                      if (onTapDelete != null) {
                        onTapDelete!();
                      }
                    },
                    child: Container(
                      padding: EdgeInsets.all(4.w),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: whiteColor,
                      ),
                      child: Icon(
                        CupertinoIcons.delete,
                        size: 16.r,
                        color: primaryColor,
                      ),
                    ),
                  ),
                if (hasEdit) ...[
                  Gap(16),
                  InkWell(
                    onTap: () {
                      Get.toNamed(
                        AppRoutes.addNewJob,
                        arguments: {
                          "model": model,
                        },
                      );
                    },
                    child: Container(
                      padding: EdgeInsets.all(4.w),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: whiteColor,
                      ),
                      child: Icon(
                        Icons.edit_outlined,
                        size: 16.r,
                        color: primaryColor,
                      ),
                    ),
                  ),
                  Gap(32),
                ]
              ],
            ),
          ],
        ),
      ),
    );
  }
}

Widget rowWidget(String title, String value, BuildContext context) {
  return Row(
    children: [
      Text(
        "$title:",
        style: TextStyle(fontSize: 12.r),
      ),
      Gap(8),
      Expanded(
        child: Text(
          value,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 12.r,
          ),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
      ),
    ],
  );
}
