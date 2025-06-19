import 'package:b2b_partenership/app_routes.dart';
import 'package:b2b_partenership/controller/provider/jobs/provider_jobs_controller.dart';
import 'package:b2b_partenership/core/global/widgets/custom_sliver_server_status_widget.dart';
import 'package:b2b_partenership/core/theme/app_color.dart';
import 'package:b2b_partenership/core/theme/text_style.dart';
import 'package:b2b_partenership/core/theme/themes.dart';
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
            title: Text(
              "MY JOBS".tr,
              style: getMediumStyle(context).copyWith(
                  letterSpacing: 1.5.w,
                  color: blackColor,
                  fontWeight: FontWeight.bold),
            ),
          ),
          floatingActionButton: SizedBox(
            width: context.isTablet ? 30.w : 50.w,
            height: context.isTablet ? 30.w : 50.w,
            child: FloatingActionButton(
              shape: CircleBorder(),
              backgroundColor: primaryColor,
              onPressed: () {
                controller.addNewJob();
              },
              child: Icon(
                Icons.add,
                color: whiteColor,
                size: 20.r,
              ),
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
                                start: 16, end: 16, top: 8, bottom: 16),
                            padding: EdgeInsets.symmetric(
                              horizontal: 16.w,
                              vertical: 10.h,
                            ),
                            decoration: BoxDecoration(
                              borderRadius: customBorderRadius,
                              border: Border.all(
                                color: Colors.grey.withAlpha(190),
                              ),
                            ),
                            child: Row(
                              children: [
                                Icon(Icons.search, color: primaryColor),
                                Gap(8),
                                Text(
                                  'Search for Seekers'.tr,
                                  style: getRegularStyle(context).copyWith(
                                    color: primaryColor,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16.r,
                                  ),
                                ),
                              ],
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
