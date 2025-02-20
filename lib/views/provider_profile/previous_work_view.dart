import 'package:b2b_partenership/controller/previous_work/previous_work_controller.dart';
import 'package:b2b_partenership/core/functions/translate_database.dart';
import 'package:b2b_partenership/core/theme/app_color.dart';
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
        body: GetBuilder<PreviousDetailsWorkController>(builder: (controller) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //WorkSlider(),
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
                      style: TextStyle(
                          fontWeight: FontWeight.w500, fontSize: 18.sp),
                    ),
                    Gap(10),
                    ReadMoreText(
                      "${controller.model.description!} ",
                      style: TextStyle(
                        fontSize: 15.sp,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                    Gap(15),
                  ],
                ),
              ),
            ],
          );
        }));
  }
}
