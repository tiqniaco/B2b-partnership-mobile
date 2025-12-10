import 'package:b2b_partenership/app_routes.dart';
import 'package:b2b_partenership/controller/jobs/job_applications_controller.dart';
import 'package:b2b_partenership/core/enums/job_application_status_enum.dart';
import 'package:b2b_partenership/core/global/widgets/custom_network_image.dart';
import 'package:b2b_partenership/core/global/widgets/custom_sliver_server_status_widget.dart';
import 'package:b2b_partenership/core/theme/app_color.dart';
import 'package:b2b_partenership/core/theme/text_style.dart';
import 'package:b2b_partenership/core/theme/themes.dart';
import 'package:b2b_partenership/core/utils/font_manager.dart';
import 'package:b2b_partenership/widgets/jobs/job_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:widget_zoom/widget_zoom.dart';

class JobApplicationsView extends StatelessWidget {
  const JobApplicationsView({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<JobApplicationsController>(
      init: JobApplicationsController(),
      builder: (JobApplicationsController controller) {
        return Scaffold(
          appBar: AppBar(
            title: Text(
              'Show Applications'.tr,
              style: TextStyle(),
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
                        height: 44,
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
                                    horizontal: 16,
                                    vertical: 8,
                                  ),
                                  margin: EdgeInsetsDirectional.only(
                                    end: 10.w,
                                  ),
                                  decoration: BoxDecoration(
                                    color: controller.jobApplicationStatus == e
                                        ? primaryColor
                                        : transparentColor,
                                    border: Border.all(color: primaryColor),
                                    borderRadius: customBorderRadius,
                                  ),
                                  child: Text(
                                    e.name.capitalizeFirst!.tr,
                                    style: getRegularStyle(context).copyWith(
                                      fontWeight: FontWeight.w500,
                                      color:
                                          controller.jobApplicationStatus == e
                                              ? whiteColor
                                              : primaryColor,
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
                  SliverToBoxAdapter(child: Gap(16)),
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
                            padding: EdgeInsets.only(
                              right: 16,
                              top: 8,
                              bottom: 8,
                              left: 0,
                            ),
                            decoration: BoxDecoration(
                              color: lightPrimaryColor.withAlpha(100),
                              border:
                                  Border.all(color: greyColor.withAlpha(100)),
                              borderRadius: BorderRadius.circular(12.r),
                            ),
                            child: Row(
                              children: [
                                SizedBox(
                                  width: 120.r,
                                  child: Column(
                                    children: [
                                      WidgetZoom(
                                        heroAnimationTag: index.toString(),
                                        zoomWidget: CustomNetworkImage(
                                          borderRadius: 100,
                                          imageUrl: model.clientImage,
                                          fit: BoxFit.cover,
                                          height: 120,
                                          width: 120,
                                        ),
                                      ),
                                      Gap(8),
                                      Text(
                                        model.clientName,
                                        style:
                                            getRegularStyle(context).copyWith(
                                          fontWeight:
                                              FontManager.mediumFontWeight,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          if (model.applicationStatus ==
                                              JobApplicationStatusEnum
                                                  .pending) ...[
                                            InkWell(
                                              onTap: () {
                                                controller
                                                    .changeJobApplicationStatus(
                                                  applicationId:
                                                      model.jobApplicationId,
                                                  status:
                                                      JobApplicationStatusEnum
                                                          .accepted,
                                                );
                                              },
                                              child: Container(
                                                alignment: Alignment.center,
                                                width: 100,
                                                padding: EdgeInsets.symmetric(
                                                  horizontal: 8,
                                                  vertical: 4,
                                                ),
                                                decoration: BoxDecoration(
                                                  border: Border.all(
                                                      color: primaryColor),
                                                  borderRadius:
                                                      customBorderRadius,
                                                ),
                                                child: Text(
                                                  "Accept".tr,
                                                  style:
                                                      getRegularStyle(context)
                                                          .copyWith(
                                                    fontWeight: FontWeight.w500,
                                                    color: primaryColor,
                                                  ),
                                                ),
                                              ),
                                            ),
                                            Gap(8),
                                            InkWell(
                                              onTap: () {
                                                controller
                                                    .changeJobApplicationStatus(
                                                  applicationId:
                                                      model.jobApplicationId,
                                                  status:
                                                      JobApplicationStatusEnum
                                                          .rejected,
                                                );
                                              },
                                              child: Container(
                                                  width: 100,
                                                  alignment: Alignment.center,
                                                  padding: EdgeInsets.symmetric(
                                                    horizontal: 8,
                                                    vertical: 4,
                                                  ),
                                                  decoration: BoxDecoration(
                                                    border: Border.all(
                                                      color: primaryColor,
                                                    ),
                                                    borderRadius:
                                                        customBorderRadius,
                                                  ),
                                                  child: Text(
                                                    "Reject".tr,
                                                    style:
                                                        getRegularStyle(context)
                                                            .copyWith(
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      color: primaryColor,
                                                    ),
                                                  )),
                                            ),

                                          
                                          ]
                                        ],
                                      ),
                                      Gap(8),
                                      rowWidget("Job Title:".tr, model.jobTitle,
                                          context),
                                      rowWidget("Contract Type:".tr,
                                          model.jobContractType.name, context),
                                      rowWidget("Expire Date:".tr,
                                          model.jobExpirationDate, context),
                                      if (model.jobSalary != "null")
                                        rowWidget("Salary:".tr, model.jobSalary,
                                            context),
                                      Gap(8),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: [
                                          Container(
                                            padding: EdgeInsets.symmetric(
                                              horizontal: 16,
                                              vertical: 6,
                                            ),
                                            decoration: BoxDecoration(
                                              color: primaryColor,
                                              borderRadius: customBorderRadius,
                                            ),
                                            child: Text(
                                              model.applicationStatus.name
                                                  .capitalizeFirst!,
                                              style: getRegularStyle(context)
                                                  .copyWith(
                                                fontWeight: FontWeight.bold,
                                                color: whiteColor,
                                              ),
                                            ),
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                      separatorBuilder: (context, index) => Gap(10.h),
                    ),
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
