import 'package:b2b_partenership/core/enums/status_request.dart';
import 'package:b2b_partenership/core/global/widgets/custom_error_widget.dart';
import 'package:b2b_partenership/core/global/widgets/custom_no_connection_widget.dart';
import 'package:b2b_partenership/core/global/widgets/global_sliver_server_status_widget.dart';
import 'package:b2b_partenership/core/global/widgets/place_holder.dart';
import 'package:b2b_partenership/widgets/jobs/jobs_loading_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gap/gap.dart';

import '/controller/jobs/jobs_controller.dart';
import '/core/theme/app_color.dart';
import '/core/theme/text_style.dart';
import '../../widgets/jobs/job_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class AllJobsView extends StatelessWidget {
  const AllJobsView({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<JobsController>(
      init: JobsController(),
      builder: (JobsController controller) {
        return Scaffold(
          body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: CustomScrollView(
                controller: controller.scrollController,
                slivers: [
                  SliverToBoxAdapter(
                    child: Row(
                      children: [
                        Expanded(
                          child: TextFormField(
                            controller: controller.searchController,
                            style: getRegularStyle(context),
                            decoration: InputDecoration(
                              prefixIcon: IconButton(
                                onPressed: () {
                                  controller.getJobs(refresh: true);
                                  if (controller
                                      .searchController.text.isNotEmpty) {
                                    controller.getJobs(refresh: true);
                                  } else {
                                    controller.getJobs();
                                  }
                                },
                                icon: Icon(
                                  CupertinoIcons.search,
                                  size: context.isTablet ? 13.w : 18.w,
                                  color: Colors.black87,
                                ),
                              ),
                              contentPadding: EdgeInsets.symmetric(
                                  vertical: context.isTablet ? 12 : 4,
                                  horizontal: context.isTablet ? 18 : 16),
                              hintText: 'Search...'.tr,
                              hintStyle: getMediumStyle(context).copyWith(
                                  fontSize: 15.r, color: Colors.black87),
                              border: InputBorder.none,
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: greyColor),
                                borderRadius: BorderRadius.only(
                                  topRight: Radius.circular(10.r),
                                  bottomLeft: Radius.circular(10.r),
                                ),
                              ),
                            ),
                            onFieldSubmitted: (value) {
                              if (value.isNotEmpty) {
                                controller.getJobs(refresh: true);
                              } else {
                                controller.getJobs();
                              }
                            },
                          ),
                        ),
                        Gap(12),
                        InkWell(
                          onTap: () {
                            controller.showFilterDialog();
                          },
                          child: Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 10, vertical: 13),
                            decoration: BoxDecoration(
                              color: primaryColor,
                              borderRadius: BorderRadius.only(
                                  topRight: Radius.circular(10.r),
                                  bottomLeft: Radius.circular(10.r)),
                            ),
                            child: Icon(
                              FontAwesomeIcons.sliders,
                              color: whiteColor,
                              size: 18.r,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SliverToBoxAdapter(
                    child: Gap(
                        controller.statusRequest == StatusRequest.error ||
                                controller.statusRequest ==
                                    StatusRequest.noConnection ||
                                controller.statusRequest == StatusRequest.noData
                            ? 150
                            : 16),
                  ),
                  GlobalSliverServerStatusWidget(
                    statusRequest: controller.statusRequest,
                    loadingChild: JobsLoadingWidget(),
                    errorChild: SliverToBoxAdapter(child: CustomErrorWidget()),
                    noConnectionChild: SliverToBoxAdapter(
                      child: CustomNoConnectionWidget(
                        onTap: () {
                          controller.getJobs();
                          controller.getCountries();
                          controller.getCities();
                        },
                      ),
                    ),
                    noDataChild: SliverToBoxAdapter(
                      child: PlaceHolderWidget(
                        icon: Image.asset("assets/images/no_jobs.png"),
                        title: 'No Jobs Now'.tr,
                        subTitle: 'Try again later or add new job'.tr,
                      ),
                    ),
                    successChild: SliverList.separated(
                      itemCount: controller.jobs.length,
                      itemBuilder: (context, index) {
                        return JobWidget(
                          model: controller.jobs[index],
                        );
                      },
                      separatorBuilder: (context, index) => Gap(20),
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
