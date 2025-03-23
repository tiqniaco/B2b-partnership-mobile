import 'package:b2b_partenership/app_routes.dart';
import 'package:b2b_partenership/controller/job_application/search_job_applications_controller.dart';
import 'package:b2b_partenership/core/global/widgets/custom_network_image.dart';
import 'package:b2b_partenership/core/global/widgets/custom_sliver_server_status_widget.dart';
import 'package:b2b_partenership/core/theme/app_color.dart';
import 'package:b2b_partenership/core/theme/text_style.dart';
import 'package:b2b_partenership/core/utils/font_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

class SearchJobApplicationsView extends StatelessWidget {
  const SearchJobApplicationsView({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SearchJobApplicationsController>(
      init: SearchJobApplicationsController(),
      builder: (SearchJobApplicationsController controller) {
        return Scaffold(
          appBar: AppBar(
            backgroundColor: primaryColor,
            iconTheme: IconThemeData(color: whiteColor),
            title: Text(
              'Search Applications'.tr,
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
            child: CustomScrollView(
              controller: controller.scrollController,
              slivers: [
                SliverToBoxAdapter(
                  child: Container(
                    margin: EdgeInsets.only(bottom: 10.h),
                    child: TextFormField(
                      controller: controller.searchController,
                      decoration: InputDecoration(
                        labelText: 'Search'.tr,
                        hintText: 'Search about job applications'.tr,
                        suffixIcon: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              icon: Icon(
                                FontAwesomeIcons.arrowsRotate,
                                color: primaryColor,
                                size: 15.sp,
                              ),
                              onPressed: () {
                                controller.searchController.clear();
                                controller.getJobApplications();
                              },
                            ),
                            IconButton(
                              icon: Icon(
                                FontAwesomeIcons.magnifyingGlass,
                                color: primaryColor,
                                size: 15.sp,
                              ),
                              onPressed: () {
                                if (controller
                                    .searchController.text.isNotEmpty) {
                                  controller.getJobApplications();
                                }
                              },
                            ),
                          ],
                        ),
                      ),
                      onFieldSubmitted: (value) {
                        if (value.isEmpty) return;
                        controller.getJobApplications();
                      },
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
                              "showStatus": false,
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
                              CustomNetworkImage(
                                imageUrl: model.clientImage,
                                fit: BoxFit.fitWidth,
                                width: 0.22.sw,
                              ),
                              Gap(12.w),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Name: ${model.clientName}",
                                      style: getRegularStyle(context).copyWith(
                                        fontWeight:
                                            FontManager.mediumFontWeight,
                                      ),
                                    ),
                                    Gap(5.h),
                                    Text(
                                      "Expected Salary: ${model.expectedSalary}\$",
                                      style: getRegularStyle(context).copyWith(
                                        fontWeight:
                                            FontManager.mediumFontWeight,
                                      ),
                                    ),
                                    Gap(5.h),
                                    Text(
                                      "Years of experience: ${model.yearsOfExperience}",
                                      style: getLightStyle(context),
                                    ),
                                    Gap(5.h),
                                    Text(
                                      "Available to start: ${model.availableToStartDate}",
                                      style: getLightStyle(context),
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
        );
      },
    );
  }
}
