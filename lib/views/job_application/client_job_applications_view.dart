import 'package:b2b_partenership/app_routes.dart';
import 'package:b2b_partenership/controller/job_application/client_job_applications_controller.dart';
import 'package:b2b_partenership/core/enums/job_application_status_enum.dart';
import 'package:b2b_partenership/core/enums/jobs_contract_type_enum.dart';
import 'package:b2b_partenership/core/global/widgets/custom_network_image.dart';
import 'package:b2b_partenership/core/global/widgets/custom_sliver_server_status_widget.dart';
import 'package:b2b_partenership/core/theme/app_color.dart';
import 'package:b2b_partenership/core/theme/text_style.dart';
import 'package:b2b_partenership/core/utils/font_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

class ClientJobApplicationsView extends StatelessWidget {
  const ClientJobApplicationsView({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ClientJobApplicationsController>(
      init: ClientJobApplicationsController(),
      builder: (ClientJobApplicationsController controller) {
        return Scaffold(
          appBar: AppBar(
            backgroundColor: primaryColor,
            titleSpacing: 0.0,
            iconTheme: IconThemeData(color: whiteColor),
            title: Row(
              children: [
                Text(
                  "My Job Applications".tr,
                  style: TextStyle(
                    color: whiteColor,
                  ),
                ),
                Spacer(),
                InkWell(
                  onTap: () => Get.toNamed(AppRoutes.providerJobs),
                  child: Text(
                    "My Jobs".tr,
                    style: TextStyle(
                      color: whiteColor,
                    ),
                  ),
                ),
                Gap(10.w)
              ],
            ),
          ),
          body: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 16.w,
              vertical: 10.h,
            ),
            child: RefreshIndicator(
              onRefresh: () => controller.getJobApplications(),
              child: CustomScrollView(
                slivers: [
                  SliverToBoxAdapter(
                    child: Container(
                      margin: EdgeInsets.only(bottom: 10.h),
                      child: SizedBox(
                        height: 35.h,
                        child: ListView(
                          scrollDirection: Axis.horizontal,
                          shrinkWrap: true,
                          children: [
                            ...JobApplicationStatusEnum.values.map(
                              (e) => InkWell(
                                onTap: () {
                                  controller.jobApplicationStatus = e;
                                  controller.getJobApplications();
                                },
                                child: Container(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 16.w,
                                    vertical: 8.h,
                                  ),
                                  margin: EdgeInsetsDirectional.only(
                                    end: 10.w,
                                  ),
                                  decoration: BoxDecoration(
                                    color: controller.jobApplicationStatus == e
                                        ? primaryColor
                                        : whiteColor,
                                    border: Border.all(color: borderColor),
                                    borderRadius: BorderRadius.circular(8.r),
                                  ),
                                  child: Text(
                                    e.name.capitalizeFirst!.tr,
                                    style: getRegularStyle(context).copyWith(
                                      fontWeight: FontWeight.w500,
                                      color:
                                          controller.jobApplicationStatus == e
                                              ? whiteColor
                                              : blackColor,
                                    ),
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  CustomSliverServerStatusWidget(
                    statusRequest: controller.statusRequest,
                    child: SliverList.separated(
                      itemCount: controller.jobApplications.length,
                      itemBuilder: (context, index) {
                        final model = controller.jobApplications[index];
                        return InkWell(
                          onTap: () {
                            Get.toNamed(
                              AppRoutes.jobApplicationDetails,
                              arguments: {
                                "model": model,
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
                                    imageUrl: model.providerImage,
                                    fit: BoxFit.contain,
                                    shape: BoxShape.circle,
                                  ),
                                ),
                                Gap(12.w),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text.rich(
                                        TextSpan(children: [
                                          TextSpan(
                                            text: "${"Status".tr}: ",
                                            style: getRegularStyle(context)
                                                .copyWith(
                                              fontWeight:
                                                  FontManager.mediumFontWeight,
                                            ),
                                          ),
                                          TextSpan(
                                            text: model.applicationStatus.name
                                                .tr.capitalizeFirst,
                                            style: getRegularStyle(context)
                                                .copyWith(
                                              fontWeight:
                                                  FontManager.mediumFontWeight,
                                              color: primaryColor,
                                            ),
                                          ),
                                        ]),
                                      ),
                                      Gap(5.h),
                                      Text(
                                        "${"Company".tr}: ${model.providerName}",
                                        style:
                                            getRegularStyle(context).copyWith(
                                          fontWeight:
                                              FontManager.mediumFontWeight,
                                        ),
                                      ),
                                      Gap(5.h),
                                      Text(
                                        "${"Job Title".tr}: ${model.jobTitle}",
                                        style:
                                            getRegularStyle(context).copyWith(
                                          fontWeight:
                                              FontManager.mediumFontWeight,
                                        ),
                                      ),
                                      Gap(5.h),
                                      Text(
                                        "${"Contract Type".tr}: ${model.jobContractType.text}",
                                        style: getLightStyle(context),
                                      ),
                                      Gap(5.h),
                                      Text(
                                        "${"Expiry Date".tr}: ${model.jobExpirationDate}",
                                        style: getLightStyle(context),
                                      ),
                                      if (model.jobSalary != "null") ...[
                                        Gap(5.h),
                                        Text(
                                          "${"Salary".tr}: ${model.jobSalary}",
                                          style: getLightStyle(context),
                                        )
                                      ],
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                      separatorBuilder: (context, index) => const Divider(),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
