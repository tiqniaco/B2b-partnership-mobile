import 'package:b2b_partenership/app_routes.dart';
import 'package:b2b_partenership/controller/previous_work/provider_profile_controller.dart';
import 'package:b2b_partenership/core/global/widgets/custom_server_status_widget.dart';
import 'package:b2b_partenership/core/theme/app_color.dart';
import 'package:b2b_partenership/core/theme/text_style.dart';
import 'package:b2b_partenership/widgets/settings/manage_previous_work_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

class ManagePreviousWork extends StatefulWidget {
  const ManagePreviousWork({super.key});

  @override
  State<ManagePreviousWork> createState() => _ManagePreviousWorkState();
}

class _ManagePreviousWorkState extends State<ManagePreviousWork> {
  @override
  Widget build(BuildContext context) {
    Get.put(ProviderProfileController());
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Previous Work'.tr,
          style: getSemiBoldStyle(context).copyWith(color: Colors.black),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        shape: CircleBorder(),
        backgroundColor: primaryColor,
        onPressed: () {
          Get.toNamed(AppRoutes.addPreviousWork);
        },
        child: Icon(
          Icons.add,
        ),
      ),
      body: GetBuilder<ProviderProfileController>(
        builder: (controller) => CustomServerStatusWidget(
          emptyMessage: "No Previous work\nhere now".tr,
          statusRequest: controller.statusRequestPerviousWork,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: ListView.separated(
              itemCount: controller.previousWork.length,
              separatorBuilder: (BuildContext context, int index) => Gap(14.h),
              itemBuilder: (BuildContext context, int index) =>
                  ManagePreviousWorkWidget(
                model: controller.previousWork[index],
                onDelete: () {
                  controller.deletePreviousWork(index);
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}
