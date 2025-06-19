import 'package:b2b_partenership/core/functions/translate_database.dart';
import 'package:b2b_partenership/core/theme/app_color.dart';
import 'package:b2b_partenership/core/theme/text_style.dart';
import 'package:b2b_partenership/models/sub_specialize_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SelectSupSpecializationWidget extends StatelessWidget {
  const SelectSupSpecializationWidget({
    super.key,
    required this.value,
    required this.models,
    required this.onChanged,
  });
  final SubSpecializeModel value;
  final List<SubSpecializeModel> models;
  final void Function(SubSpecializeModel?) onChanged;

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<SubSpecializeModel>(
      isExpanded: true,
      value: value,
      decoration: InputDecoration(
        filled: true,
        fillColor: whiteColor,
        contentPadding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 12.w),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(7.r),
          borderSide: const BorderSide(color: blackColor, width: 1),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(7),
          borderSide: const BorderSide(color: pageColor, width: 1.5),
        ),
        // label: Text(
        //   'Select Sub Category'.tr,
        //   style: getMediumStyle(context).copyWith(
        //     fontWeight: FontWeight.w500,
        //     color: Colors.black87,
        //   ),
        // ),
      ),
      icon: Icon(
        Icons.keyboard_arrow_down_outlined,
        size: 23.r,
        color: primaryColor,
      ),
      items: models.map((item) {
        return DropdownMenuItem<SubSpecializeModel>(
          value: item,
          child: Text(
            translateDatabase(
                arabic: item.nameAr ?? "", english: item.nameEn ?? ""),
            style: getLightStyle(context).copyWith(
              color: blackColor,
              fontWeight: FontWeight.w500,
            ),
          ),
        );
      }).toList(),
      onChanged: onChanged,
    );
  }
}
