import 'package:b2b_partenership/app_routes.dart';
import 'package:b2b_partenership/controller/jobs/provider_job_applications_controller.dart';
import 'package:b2b_partenership/core/enums/job_application_status_enum.dart';
import 'package:b2b_partenership/core/global/widgets/custom_loading_button.dart';
import 'package:b2b_partenership/core/global/widgets/custom_network_image.dart';
import 'package:b2b_partenership/core/global/widgets/custom_sliver_server_status_widget.dart';
import 'package:b2b_partenership/core/services/date_time_convertor.dart';
import 'package:b2b_partenership/core/theme/app_color.dart';
import 'package:b2b_partenership/core/theme/text_style.dart';
import 'package:b2b_partenership/core/utils/font_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:widget_zoom/widget_zoom.dart';

class ProviderJobApplicationsView extends StatelessWidget {
  const ProviderJobApplicationsView({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProviderJobApplicationsController>(
      init: ProviderJobApplicationsController(),
      builder: (ProviderJobApplicationsController controller) {
        return Scaffold(
          appBar: AppBar(
            backgroundColor: primaryColor,
            iconTheme: IconThemeData(color: whiteColor),
            title: Text(
              'Job Applications'.tr,
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
                                    style: getRegularStyle.copyWith(
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
                  SliverToBoxAdapter(
                    child: Container(
                      margin: EdgeInsets.only(bottom: 10.h),
                      child: Text(
                        '${controller.jobApplications.length} applications found',
                        style: getLightStyle.copyWith(
                          fontWeight: FontManager.mediumFontWeight,
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
                                SizedBox(
                                  width: 0.25.sw,
                                  child: Column(
                                    children: [
                                      WidgetZoom(
                                        heroAnimationTag: "clientImage",
                                        zoomWidget: CustomNetworkImage(
                                          imageUrl: model.clientImage,
                                          fit: BoxFit.fitWidth,
                                          width: 0.25.sw,
                                        ),
                                      ),
                                      Gap(8.h),
                                      CustomLoadingButton(
                                        onPressed: () {
                                          return controller
                                              .changeJobApplicationStatus(
                                            applicationId:
                                                model.jobApplicationId,
                                            status: JobApplicationStatusEnum
                                                .accepted,
                                          );
                                        },
                                        borderRadius: 5.r,
                                        height: 0.045.sh,
                                        backgroundColor: greenColor,
                                        text: "Accept",
                                      ),
                                      Gap(2.h),
                                      CustomLoadingButton(
                                        onPressed: () {
                                          return controller
                                              .changeJobApplicationStatus(
                                            applicationId:
                                                model.jobApplicationId,
                                            status: JobApplicationStatusEnum
                                                .rejected,
                                          );
                                        },
                                        borderRadius: 5.r,
                                        height: 0.045.sh,
                                        backgroundColor: redColor,
                                        text: "Reject",
                                      ),
                                    ],
                                  ),
                                ),
                                Gap(12.w),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text.rich(
                                            TextSpan(children: [
                                              TextSpan(
                                                text: "Status: ",
                                                style: getRegularStyle.copyWith(
                                                  fontWeight: FontManager
                                                      .mediumFontWeight,
                                                ),
                                              ),
                                              TextSpan(
                                                text: model.applicationStatus
                                                    .name.capitalizeFirst,
                                                style: getRegularStyle.copyWith(
                                                  fontWeight: FontManager
                                                      .mediumFontWeight,
                                                  color: model
                                                      .applicationStatus.color,
                                                ),
                                              ),
                                            ]),
                                          ),
                                          Gap(8.w),
                                          Text(
                                            DateTimeConvertor.timeAgo(
                                              model.createdAt,
                                            ),
                                            style: getLightStyle.copyWith(
                                              fontWeight:
                                                  FontManager.mediumFontWeight,
                                              color: greyColor,
                                              fontSize: 10.sp,
                                            ),
                                          ),
                                        ],
                                      ),
                                      Gap(5.h),
                                      Text(
                                        "Name: ${model.clientName}",
                                        style: getRegularStyle.copyWith(
                                          fontWeight:
                                              FontManager.mediumFontWeight,
                                        ),
                                      ),
                                      Gap(5.h),
                                      Text(
                                        "Expected Salary: ${model.expectedSalary}\$",
                                        style: getRegularStyle.copyWith(
                                          fontWeight:
                                              FontManager.mediumFontWeight,
                                        ),
                                      ),
                                      Gap(5.h),
                                      Text(
                                        "Years of experience: ${model.yearsOfExperience}",
                                        style: getLightStyle,
                                      ),
                                      Gap(5.h),
                                      Text(
                                        "Available to start: ${model.availableToStartDate}",
                                        style: getLightStyle,
                                      ),
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
