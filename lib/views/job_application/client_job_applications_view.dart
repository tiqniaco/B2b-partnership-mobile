import 'package:b2b_partenership/app_routes.dart';
import 'package:b2b_partenership/controller/job_application/client_job_applications_controller.dart';
import 'package:b2b_partenership/core/enums/job_application_status_enum.dart';
import 'package:b2b_partenership/core/enums/jobs_contract_type_enum.dart';
import 'package:b2b_partenership/core/global/widgets/custom_network_image.dart';
import 'package:b2b_partenership/core/global/widgets/custom_sliver_server_status_widget.dart';
import 'package:b2b_partenership/core/theme/app_color.dart';
import 'package:b2b_partenership/core/theme/text_style.dart';
import 'package:b2b_partenership/core/theme/themes.dart';
import 'package:b2b_partenership/core/utils/font_manager.dart';
import 'package:b2b_partenership/widgets/job_widget.dart';
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
            title: Row(
              children: [
                Text(
                  "My Job Applications".tr,
                ),
                Spacer(),
                InkWell(
                  onTap: () => Get.toNamed(AppRoutes.providerJobs),
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 16),
                    decoration: BoxDecoration(
                      color: primaryColor,
                      borderRadius: customBorderRadius,
                    ),
                    child: Text(
                      "My Jobs".tr,
                      style: TextStyle(
                        color: whiteColor,
                        fontSize: 12.r,
                      ),
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
                                  alignment: Alignment.center,
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 24,
                                  ),
                                  margin: EdgeInsetsDirectional.only(
                                    end: 10.w,
                                  ),
                                  decoration: BoxDecoration(
                                    color: controller.jobApplicationStatus == e
                                        ? primaryColor
                                        : Colors.transparent,
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
                              color: lightPrimaryColor.withAlpha(130),
                              border:
                                  Border.all(color: borderColor.withAlpha(50)),
                              borderRadius: BorderRadius.circular(20.r),
                            ),
                            child: Row(
                              children: [
                                Column(
                                  children: [
                                    Container(
                                      decoration: BoxDecoration(
                                          color: whiteColor,
                                          shape: BoxShape.circle),
                                      child: CustomNetworkImage(
                                        imageUrl: model.providerImage,
                                        height: 90.r,
                                        fit: BoxFit.cover,
                                        shape: BoxShape.circle,
                                      ),
                                    ),
                                    Gap(4),
                                    Text(
                                      model.providerName,
                                      style: getBoldStyle(context).copyWith(
                                          fontWeight:
                                              FontManager.boldFontWeight,
                                          fontSize: 14.r),
                                    ),
                                  ],
                                ),
                                Gap(12.w),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      rowWidget("Job Title".tr, model.jobTitle,
                                          context),
                                      Gap(5),
                                      rowWidget("Contract Type".tr,
                                          model.jobContractType.text, context),
                                      Gap(5),
                                      rowWidget("Expiry Date".tr,
                                          model.jobExpirationDate, context),
                                      if (model.expectedSalary != "null") ...[
                                        Gap(5),
                                        rowWidget("Salary".tr,
                                            model.expectedSalary, context),
                                      ],
                                      Gap(10),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: [
                                          Container(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 16, vertical: 6),
                                            decoration: BoxDecoration(
                                              color: primaryColor,
                                              borderRadius: customBorderRadius,
                                            ),
                                            child: Text(
                                              model.applicationStatus.name.tr
                                                  .capitalizeFirst!,
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 14.r,
                                                  color: Colors.white),
                                            ),
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                                // Column(
                                //   mainAxisAlignment: MainAxisAlignment.start,
                                //   children: [
                                //     if (hasDelete)
                                //       InkWell(
                                //         onTap: () {
                                //           if (onTapDelete != null) {
                                //             onTapDelete!();
                                //           }
                                //         },
                                //         child: Container(
                                //           padding: EdgeInsets.all(4.w),
                                //           decoration: BoxDecoration(
                                //             shape: BoxShape.circle,
                                //             color: primaryColor,
                                //           ),
                                //           child: Icon(
                                //             FontAwesomeIcons.xmark,
                                //             size: 16.r,
                                //             color: whiteColor,
                                //           ),
                                //         ),
                                //       ),
                                //     if (hasEdit) ...[
                                //       Gap(8.h),
                                //       InkWell(
                                //         onTap: () {
                                //           Get.toNamed(
                                //             AppRoutes.addNewJob,
                                //             arguments: {
                                //               "model": model,
                                //             },
                                //           );
                                //         },
                                //         child: Container(
                                //           padding: EdgeInsets.all(4.w),
                                //           decoration: BoxDecoration(
                                //             shape: BoxShape.circle,
                                //             color: primaryColor,
                                //           ),
                                //           child: Icon(
                                //             FontAwesomeIcons.penToSquare,
                                //             size: 16.r,
                                //             color: whiteColor,
                                //           ),
                                //         ),
                                //       )
                                //     ]
                                //   ],
                                // ),
                              ],
                            ),
                          ),
                        );

                        // InkWell(
                        //   onTap: () {},
                        //   child: Container(
                        //     padding: EdgeInsets.symmetric(
                        //       horizontal: 16.w,
                        //       vertical: 10.h,
                        //     ),
                        //     decoration: BoxDecoration(
                        //       color: whiteColor,
                        //       border: Border.all(color: borderColor),
                        //       borderRadius: BorderRadius.circular(8.r),
                        //     ),
                        //     child: Row(
                        //       children: [
                        //         CircleAvatar(
                        //           backgroundColor: whiteColor,
                        //           radius: 35.r,
                        //           child: CustomNetworkImage(
                        //             imageUrl: model.providerImage,
                        //             fit: BoxFit.contain,
                        //             shape: BoxShape.circle,
                        //           ),
                        //         ),
                        //         Gap(12.w),
                        //         Expanded(
                        //           child: Column(
                        //             crossAxisAlignment:
                        //                 CrossAxisAlignment.start,
                        //             children: [
                        //               Text.rich(
                        //                 TextSpan(children: [
                        //                   TextSpan(
                        //                     text: "${"Status".tr}: ",
                        //                     style: getRegularStyle(context)
                        //                         .copyWith(
                        //                       fontWeight:
                        //                           FontManager.mediumFontWeight,
                        //                     ),
                        //                   ),
                        //                   TextSpan(
                        //                     text:
                        // model.applicationStatus.name
                        //                         .tr.capitalizeFirst,
                        //                     style: getRegularStyle(context)
                        //                         .copyWith(
                        //                       fontWeight:
                        //                           FontManager.mediumFontWeight,
                        //                       color: primaryColor,
                        //                     ),
                        //                   ),
                        //                 ]),
                        //               ),
                        //               Gap(5.h),
                        //               Text(
                        //                 "${"Company".tr}: ${model.providerName}",
                        //                 style:
                        //                     getRegularStyle(context).copyWith(
                        //                   fontWeight:
                        //                       FontManager.mediumFontWeight,
                        //                 ),
                        //               ),
                        //               Gap(5.h),
                        //               Text(
                        //                 "${"Job Title".tr}: ${model.jobTitle}",
                        //                 style:
                        //                     getRegularStyle(context).copyWith(
                        //                   fontWeight:
                        //                       FontManager.mediumFontWeight,
                        //                 ),
                        //               ),
                        //               Gap(5.h),
                        //               Text(
                        //                 "${"Contract Type".tr}: ${model.jobContractType.text}",
                        //                 style: getLightStyle(context),
                        //               ),
                        //               Gap(5.h),
                        //               Text(
                        //                 "${"Expiry Date".tr}: ${model.jobExpirationDate}",
                        //                 style: getLightStyle(context),
                        //               ),
                        //               if (model.jobSalary != "null") ...[
                        //                 Gap(5.h),
                        //                 Text(
                        //                   "${"Salary".tr}: ${model.jobSalary}",
                        //                   style: getLightStyle(context),
                        //                 )
                        //               ],
                        //             ],
                        //           ),
                        //         ),
                        //       ],
                        //     ),
                        //   ),
                        // );
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
