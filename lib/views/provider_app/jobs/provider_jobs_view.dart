import 'package:b2b_partenership/app_routes.dart';
import 'package:b2b_partenership/controller/provider/jobs/provider_jobs_controller.dart';
import 'package:b2b_partenership/core/global/widgets/custom_sliver_server_status_widget.dart';
import 'package:b2b_partenership/core/theme/app_color.dart';
import 'package:b2b_partenership/core/theme/text_style.dart';
import 'package:b2b_partenership/widgets/job_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

class ProviderJobsView extends StatelessWidget {
  const ProviderJobsView({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProviderJobsController>(
      init: ProviderJobsController(),
      builder: (ProviderJobsController controller) {
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
              "Your Jobs".toUpperCase(),
              style: getSemiBoldStyle.copyWith(
                letterSpacing: 1.5.w,
                color: whiteColor,
              ),
            ),
          ),
          floatingActionButton: FloatingActionButton(
            backgroundColor: primaryColor,
            onPressed: () {
              controller.addNewJob();
            },
            child: Icon(
              Icons.add,
              color: whiteColor,
            ),
          ),
          body: SafeArea(
            child: Stack(
              children: [
                RefreshIndicator(
                  onRefresh: () => controller.getJobs(),
                  child: CustomScrollView(
                    slivers: [
                      SliverToBoxAdapter(
                        child: InkWell(
                          onTap: () {
                            Get.toNamed(AppRoutes.searchJobApplications);
                          },
                          child: Container(
                            margin: EdgeInsetsDirectional.only(
                              start: 16.w,
                              end: 16.w,
                              top: 10.h,
                            ),
                            padding: EdgeInsets.symmetric(
                              horizontal: 16.w,
                              vertical: 10.h,
                            ),
                            decoration: BoxDecoration(
                              color: primaryColor.withAlpha(20),
                              borderRadius: BorderRadius.circular(10.r),
                            ),
                            child: Text(
                              'Search for job seekers',
                              style: getRegularStyle.copyWith(
                                color: primaryColor,
                              ),
                            ),
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
                                hasDelete: true,
                                onTapDelete: () {
                                  controller.deleteJobsDialog(
                                    controller.jobs[index].id,
                                  );
                                },
                                hasEdit: true,
                              );
                            },
                            separatorBuilder: (context, index) => Gap(10.h),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                if (controller.isDeleteLoading)
                  Container(
                    width: 1.sw,
                    height: 1.sh,
                    color: blackColor.withAlpha(80),
                    alignment: Alignment.center,
                    child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.r),
                      ),
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: 20.w,
                          vertical: 20.h,
                        ),
                        child: CircularProgressIndicator(
                          color: primaryColor,
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ),
        );
      },
    );
  }
}
