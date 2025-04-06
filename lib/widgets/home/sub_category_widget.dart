import 'package:b2b_partenership/controller/in_category/providers_in_category_controller.dart';
import 'package:b2b_partenership/core/functions/translate_database.dart';
import 'package:b2b_partenership/core/theme/app_color.dart';
import 'package:b2b_partenership/core/theme/text_style.dart';
import 'package:b2b_partenership/models/sub_specialize_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

class SubCategoryWidget extends StatelessWidget {
  const SubCategoryWidget({super.key, required this.subSpecializations});
  final List<SubSpecializeModel> subSpecializations;
  @override
  Widget build(BuildContext context) {
    Get.put(ProvidersInCategoryController());
    return GetBuilder<ProvidersInCategoryController>(
      builder: (controller) {
        return ListView.separated(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          scrollDirection: Axis.horizontal,
          itemCount: subSpecializations.length,
          separatorBuilder: (context, index) => Gap(20),
          itemBuilder: (context, index) => InkWell(
            onTap: () {
              controller.onTapSub(subSpecializations[index]);
            },
            child: Container(
              //width: 100.h,
              height: 100.h,
              padding: EdgeInsets.symmetric(
                horizontal: 15,
              ),
              decoration: BoxDecoration(
                  color: controller.selectedSubSpecialization.id ==
                          subSpecializations[index].id
                      ? primaryColor
                      : whiteColor,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Colors.grey.withAlpha(80))),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    translateDatabase(
                      arabic: subSpecializations[index].nameAr!,
                      english: subSpecializations[index].nameEn!,
                    ),
                    textAlign: TextAlign.center,
                    style: getLightStyle(context).copyWith(
                      color: controller.selectedSubSpecialization.id ==
                              subSpecializations[index].id
                          ? whiteColor
                          : blackColor,
                      fontWeight: controller.selectedSubSpecialization.id ==
                              subSpecializations[index].id
                          ? FontWeight.bold
                          : FontWeight.w300,
                    ),
                    //maxLines: 2,
                    // overflow: TextOverflow.ellipsis,
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
