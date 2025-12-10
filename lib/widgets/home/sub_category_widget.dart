import 'package:b2b_partenership/controller/in_category/providers_in_category_controller.dart';
import 'package:b2b_partenership/core/functions/translate_database.dart';
import 'package:b2b_partenership/core/theme/app_color.dart';
import 'package:b2b_partenership/core/theme/text_style.dart';
import 'package:b2b_partenership/core/theme/themes.dart';
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
          scrollDirection: Axis.horizontal,
          itemCount: subSpecializations.length,
          separatorBuilder: (context, index) => Gap(8),
          itemBuilder: (context, index) => InkWell(
            onTap: () {
              controller.onTapSub(subSpecializations[index]);
            },
            child: Container(
              alignment: Alignment.center,
              padding: EdgeInsets.symmetric(horizontal: 15),
              decoration: BoxDecoration(
                  color: controller.selectedSubSpecialization.id ==
                          subSpecializations[index].id
                      ? primaryColor
                      : null,
                  borderRadius: customBorderRadius,
                  border: Border.all(color: primaryColor)),
              child: Text(
                translateDatabase(
                  arabic: subSpecializations[index].nameAr!,
                  english: subSpecializations[index].nameEn!,
                ),
                textAlign: TextAlign.center,
                style: getLightStyle(context).copyWith(
                    fontSize: 13.r,
                    color: controller.selectedSubSpecialization.id ==
                            subSpecializations[index].id
                        ? whiteColor
                        : primaryColor,
                    fontWeight: FontWeight.w500),
              ),
            ),
          ),
        );
      },
    );
  }
}
