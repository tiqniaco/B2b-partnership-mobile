import 'package:b2b_partenership/controller/previous_work/previous_work_controller.dart';
import 'package:b2b_partenership/core/functions/translate_database.dart';
import 'package:b2b_partenership/core/theme/app_color.dart';
import 'package:b2b_partenership/core/theme/text_style.dart';
import 'package:b2b_partenership/widgets/provider_profile/work_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:readmore/readmore.dart';

class PreviousWorkView extends StatelessWidget {
  const PreviousWorkView({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(PreviousDetailsWorkController());
    return Scaffold(
      appBar: AppBar(
        backgroundColor: whiteColor,
      ),
      body: GetBuilder<PreviousDetailsWorkController>(
        builder: (controller) {
          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10.0.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Gap(10),
                      Text(
                        translateDatabase(
                            arabic: controller.model.titleAr!,
                            english: controller.model.titleEn!),
                        style: getSemiBoldStyle(context).copyWith(
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Gap(10),
                      ReadMoreText(
                        "${controller.model.description!} ",
                        style: getMediumStyle(context).copyWith(
                          fontWeight: FontWeight.normal,
                        ),
                        trimCollapsedText: "See more".tr,
                        trimExpandedText: 'See less'.tr,
                      ),
                      Gap(15),
                    ],
                  ),
                ),
                SizedBox(height: 500.h, child: WorkImage()),
              ],
            ),
          );
        },
      ),
    );
  }
}
