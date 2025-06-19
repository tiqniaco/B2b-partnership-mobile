import 'package:flutter/cupertino.dart';
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
                            // controller: controller.searchController,
                            style: getRegularStyle(context),
                            decoration: InputDecoration(
                              prefixIcon: IconButton(
                                onPressed: () {
                                  controller.getJobs(refresh: true);
                                  // if (controller.searchController.text.isNotEmpty) {
                                  //   controller.getShopProducts(isSearch: true);
                                  // } else {
                                  //   controller.getShopProducts();
                                  // }
                                },
                                icon: Icon(
                                  CupertinoIcons.search,
                                  size: context.isTablet ? 13.w : 18.w,
                                  color: primaryColor,
                                ),
                              ),
                              contentPadding: EdgeInsets.symmetric(
                                  vertical: 4, horizontal: 16),
                              hintText: 'Search...'.tr,
                              hintStyle: getBoldStyle(context).copyWith(
                                  fontSize: 16.r, color: primaryColor),
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
                              // if (value.isNotEmpty) {
                              //   controller.getShopProducts(isSearch: true);
                              // } else {
                              //   controller.getShopProducts();
                              // }
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
                  // SliverToBoxAdapter(
                  //   child: Container(
                  //     margin: EdgeInsetsDirectional.only(
                  //       start: 16.w,
                  //       end: 16.w,
                  //       bottom: 6.h,
                  //       top: 16.h,
                  //     ),
                  //     child: Row(
                  //       children: [
                  //         Expanded(
                  //           child: TextFormField(
                  //             controller: controller.searchController,
                  //             decoration: InputDecoration(
                  //               contentPadding: EdgeInsets.symmetric(
                  //                 horizontal: 12.w,
                  //                 vertical: 12.h,
                  //               ),
                  //               labelText: "Search".tr,
                  //               labelStyle: getMediumStyle(context).copyWith(
                  //                 color: hintColor,
                  //               ),
                  //               border: OutlineInputBorder(
                  //                 borderRadius: BorderRadius.circular(8.r),
                  //               ),
                  //               suffixIcon: Row(
                  //                 mainAxisSize: MainAxisSize.min,
                  //                 children: [
                  //                   IconButton(
                  //                     icon: Icon(
                  //                       FontAwesomeIcons.sliders,
                  //                       color: primaryColor,
                  //                       size: context.isTablet ? 10.w : 16.w,
                  //                     ),
                  //                     onPressed: () {
                  //                       controller.showFilterDialog();
                  //                     },
                  //                   ),
                  //                   if (context.isTablet) Gap(4.w),
                  //                   IconButton(
                  //                     icon: Icon(
                  //                       FontAwesomeIcons.magnifyingGlass,
                  //                       color: primaryColor,
                  //                       size: context.isTablet ? 10.w : 16.w,
                  //                     ),
                  //                     onPressed: () {
                  //                       controller.getJobs(refresh: true);
                  //                     },
                  //                   ),
                  //                   if (context.isTablet) Gap(6.w),
                  //                 ],
                  //               ),
                  //             ),
                  //             onFieldSubmitted: (value) {
                  //               controller.getJobs(refresh: true);
                  //             },
                  //           ),
                  //         ),
                  //       ],
                  //     ),
                  //   ),
                  // ),
                  SliverToBoxAdapter(
                    child: Gap(16),
                  ),
                  CustomSliverServerStatusWidget(
                    statusRequest: controller.statusRequest,
                    child: SliverList.separated(
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
