import 'package:b2b_partenership/controller/search/search_controller.dart';
import 'package:b2b_partenership/core/functions/translate_database.dart';
import 'package:b2b_partenership/core/theme/app_color.dart';
import 'package:b2b_partenership/core/theme/text_style.dart';
import 'package:b2b_partenership/models/sub_specialize_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class SelectSupSpecializationFilter extends StatelessWidget {
  const SelectSupSpecializationFilter({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SearchControllerIM>(
      builder: (controller) => DropdownButtonFormField<SubSpecializeModel>(
        value: controller.selectedSubSpecialization,
        isExpanded: true,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(
            vertical: context.isTablet ? 8.h : 10.h,
            horizontal: 12.w,
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(7.r),
            borderSide: const BorderSide(color: blackColor, width: 1),
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(7),
            borderSide: const BorderSide(color: pageColor, width: 1.5),
          ),
          hintText: "All sub Categories".tr,
          hintStyle: getMediumStyle(context).copyWith(
            fontWeight: FontWeight.w500,
            color: hintColor,
          ),
          label: Text(
            'Select Sub Category'.tr,
            style: getMediumStyle(context).copyWith(
              fontWeight: FontWeight.w500,
              color: Colors.black87,
            ),
          ),
        ),
        icon: Icon(
          Icons.keyboard_arrow_down_outlined,
          size: 23.r,
          color: greyColor,
        ),
        items: controller.subSpecializations.map((item) {
          return DropdownMenuItem<SubSpecializeModel>(
            value: item,
            child: Text(
              translateDatabase(arabic: item.nameAr!, english: item.nameEn!),
              style: getMediumStyle(context).copyWith(
                  color: blackColor,
                  fontWeight: FontWeight.normal,
                  fontSize: 13.r),
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
            ),
          );
        }).toList(),
        onChanged: (value) {
          controller.onSubSpecializeChanged(value);
        },
      ),
    );
  }
}
