import 'package:avatar_glow/avatar_glow.dart';
import 'package:b2b_partenership/controller/complaints/complaints_controller.dart';
import 'package:b2b_partenership/core/global/widgets/custom_server_status_widget.dart';
import 'package:b2b_partenership/core/theme/app_color.dart';
import 'package:b2b_partenership/core/theme/text_style.dart';
import 'package:b2b_partenership/widgets/complaints/complaints_message_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

class ComplaintsView extends StatelessWidget {
  const ComplaintsView({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ComplaintsController>(
      init: ComplaintsController(),
      builder: (ComplaintsController controller) {
        return Scaffold(
          appBar: AppBar(
            toolbarHeight: context.isTablet ? 45.h : null,
            titleSpacing: 0,
            title: Row(
              children: [
                CircleAvatar(
                  radius: 17.r,
                  backgroundColor: redColor.withAlpha(30),
                  child: Icon(
                    Icons.headset_mic_outlined,
                    color: redColor,
                    size: 16.r,
                  ),
                ),
                Gap(10.w),
                Text(
                  "Complaints".tr,
                  style: getMediumStyle(context),
                ),
              ],
            ),
          ),
          body: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 10.w,
              vertical: 10.h,
            ),
            child: Column(
              children: [
                Expanded(
                  child: CustomServerStatusWidget(
                    statusRequest: controller.statusRequest,
                    child: CustomScrollView(
                      reverse: true,
                      slivers: [
                        SliverList.separated(
                          itemBuilder: (context, index) =>
                              ComplaintsMessageWidget(
                            model: controller.complaints[index],
                          ),
                          separatorBuilder: (context, index) => Gap(10.h),
                          itemCount: controller.complaints.length,
                        ),
                      ],
                    ),
                  ),
                ),
                Gap(12.h),
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 10.w,
                    vertical: 10.h,
                  ),
                  child: Row(
                    children: [
                      AvatarGlow(
                        animate: controller.isRecording,
                        glowColor: primaryColor,
                        child: Container(
                          width: 40.r,
                          height: 40.r,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(50.r),
                            color: primaryColor,
                          ),
                          child: FloatingActionButton(
                            onPressed: () {
                              if (!controller.isRecording) {
                                controller.record();
                              } else {
                                controller.stopRecord();
                              }
                            },
                            child: Icon(
                              controller.isRecording
                                  ? FontAwesomeIcons.stop
                                  : FontAwesomeIcons.microphone,
                              color: whiteColor,
                              size: 18.r,
                            ),
                          ),
                        ),
                      ),
                      Gap(10.w),
                      Expanded(
                        child: TextFormField(
                          controller: controller.complaintController,
                          onFieldSubmitted: (value) {
                            if (value.isNotEmpty) {
                              controller.sendComplaint();
                            }
                          },
                          minLines: context.isTablet ? 2 : 1,
                          maxLines: context.isTablet ? 2 : 1,
                          decoration: InputDecoration(
                            hintText: "Enter your complaints...".tr,
                            hintStyle: getLightStyle(context).copyWith(
                              color: greyColor,
                            ),
                            filled: true,
                            fillColor: Colors.white,
                          ),
                        ),
                      ),
                      Gap(context.isTablet ? 8.w : 0),
                      IconButton(
                        onPressed: () {
                          if (controller.complaintController.text.isNotEmpty) {
                            controller.sendComplaint();
                          }
                        },
                        icon: Icon(
                          FontAwesomeIcons.paperPlane,
                          color: primaryColor,
                          size: 20.r,
                        ),
                      ),
                    ],
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
