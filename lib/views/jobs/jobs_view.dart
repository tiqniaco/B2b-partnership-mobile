import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gap/gap.dart';

import '/controller/jobs/jobs_controller.dart';
import '/core/global/widgets/custom_sliver_server_status_widget.dart';
import '/core/theme/app_color.dart';
import '/core/theme/text_style.dart';
import '/widgets/job_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class JobsView extends StatelessWidget {
  const JobsView({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<JobsController>(
      init: JobsController(),
      builder: (JobsController controller) {
        return Scaffold(
          appBar: AppBar(
            backgroundColor: primaryColor,
            iconTheme: IconThemeData(
              color: whiteColor,
            ),
            leading: IconButton(
              icon: Icon(
                Icons.arrow_back_ios_new,
                size: 20.sp,
              ),
              onPressed: () {
                Get.back();
              },
            ),
            titleSpacing: 0,
            title: Text(
              "Jobs".toUpperCase(),
              style: getSemiBoldStyle.copyWith(
                letterSpacing: 1.5.w,
                color: whiteColor,
              ),
            ),
          ),
          body: SafeArea(
            child: CustomScrollView(
              controller: controller.scrollController,
              slivers: [
                SliverToBoxAdapter(
                  child: Container(
                    margin: EdgeInsetsDirectional.only(
                      start: 16.w,
                      end: 16.w,
                      bottom: 6.h,
                      top: 16.h,
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: TextFormField(
                            controller: controller.searchController,
                            decoration: InputDecoration(
                              labelText: "Search".tr,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              suffixIcon: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  IconButton(
                                    icon: Icon(
                                      FontAwesomeIcons.sliders,
                                      color: primaryColor,
                                      size: 16.sp,
                                    ),
                                    onPressed: () {
                                      controller.showFilterDialog();
                                    },
                                  ),
                                  IconButton(
                                    icon: Icon(
                                      FontAwesomeIcons.magnifyingGlass,
                                      color: primaryColor,
                                      size: 16.sp,
                                    ),
                                    onPressed: () {
                                      controller.getJobs(refresh: true);
                                    },
                                  ),
                                ],
                              ),
                            ),
                            onFieldSubmitted: (value) {
                              controller.getJobs(refresh: true);
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SliverPadding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 16.w,
                    vertical: 10.h,
                  ),
                  sliver: CustomSliverServerStatusWidget(
                    statusRequest: controller.statusRequest,
                    child: SliverList.separated(
                      itemCount: controller.jobs.length,
                      itemBuilder: (context, index) {
                        return JobWidget(
                          model: controller.jobs[index],
                        );
                      },
                      separatorBuilder: (context, index) => Gap(10.h),
                    ),
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
