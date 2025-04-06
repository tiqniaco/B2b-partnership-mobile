import 'package:b2b_partenership/core/functions/translate_database.dart';
import 'package:b2b_partenership/core/theme/app_color.dart';
import 'package:b2b_partenership/core/theme/text_style.dart';
import 'package:b2b_partenership/models/city_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class SelectCityWidget extends StatelessWidget {
  const SelectCityWidget({
    super.key,
    required this.value,
    required this.models,
    required this.onChanged,
  });
  final CityModel value;
  final List<CityModel> models;
  final void Function(CityModel?) onChanged;
  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<CityModel>(
        isExpanded: true,
        value: value, //CountryModel
        decoration: InputDecoration(
          contentPadding:
              EdgeInsets.symmetric(vertical: 12.h, horizontal: 12.w),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(7.r),
            borderSide: const BorderSide(color: blackColor, width: 1),
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(7),
            borderSide: const BorderSide(color: pageColor, width: 1.5),
          ),
          label: Text(
            'Select City'.tr,
            style: getMediumStyle(context)
                .copyWith(fontWeight: FontWeight.w500, color: Colors.black87),
          ),
        ),
        icon: Icon(
          Icons.keyboard_arrow_down_outlined,
          size: 23.r,
          color: greyColor,
        ),
        items: models.map((item) {
          return DropdownMenuItem<CityModel>(
            value: item,
            child: Text(
              translateDatabase(
                  arabic: item.nameAr ?? "", english: item.nameEn ?? ""),
              style: getLightStyle(context).copyWith(
                color: greyColor.withAlpha(160),
                fontWeight: FontWeight.bold,
              ),
            ),
          );
        }).toList(),
        onChanged: onChanged);
  }
}
